
import 'dart:async';
import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:ttrueno_fo827e642a0c4/init_dependency.dart';
import 'package:ttrueno_fo827e642a0c4/modules/message/model/chat_room.dart';
import 'package:ttrueno_fo827e642a0c4/modules/ride&booking/controller/leave_ride_controller.dart';
import 'package:ttrueno_fo827e642a0c4/modules/ride&booking/model/ride_model.dart';
import '../../../modules/message/interface/message_interface.dart';
import '../../../modules/message/model/get_chats_req_param.dart';
import '../../../modules/message/model/get_messages_param.dart';
import '../../../modules/message/model/message.dart';
import '../../../modules/message/model/send_message_req_param.dart';
import '../../../modules/profile/controller/profile_data_controller.dart';
import '../../../modules/ride&booking/interface/ride_interface.dart';
import '../../utils/helpers/handle_fold.dart';
import '../model/rider.dart';
import '../model/rider_joined_state.dart';
import '../model/rider_left_state.dart';

class InboxController extends GetxController{

  InboxController();
  int _page = 1;
  int _limit = 10;
  bool _isLoading = false;
  bool _isLastPage = false;
  bool get isLoading => _isLoading;

  Future<void> init() async{
    await getAllChat();
    _lisenToStreams();
  }

  StreamSubscription<RiderJoinedState>? _riderJoinedStreamSubscription;
  StreamSubscription<RiderLeftState>? _riderLeftStreamSubscription;
  StreamSubscription<Message?>? _messageStreamSubscription;
  StreamSubscription<ChatRoom?>? _chatRoomStreamSubscription;
  RxList<ActiveRideChatController> rideChats = RxList<ActiveRideChatController>([]);
  
  Future<void> getAllChat({bool? forceRefresh}) async{
    if(forceRefresh == true) {
      _page = 1;
      _isLastPage = false;
      _isLoading = false;
      rideChats.clear();
    }
    if(_isLoading || _isLastPage ) return;
    _isLoading = true;
    await serviceLocator<MessageInterface>().getAllChat(
      GetChatsParam(page: _page, limit: _limit)
    ).then((lr) {
      handleFold(
        either: lr,
        processStatusNotifier: null,
        onSuccess: (data) {
          rideChats.clear();
          for(final chat in data) {
            final activeRideChat = ActiveRideChatController(chat: chat);
            rideChats.add(activeRideChat);
            activeRideChat.init();
          }
          rideChats.refresh();
          _page++;
          if(data.length < _limit) {
            _isLastPage = true;
          }
          _isLoading = false;
        },
      );
    });
  }

  _lisenToStreams() {
    // Rider join stream
    _riderJoinedStreamSubscription = serviceLocator<RideInterface>().riderJoinedStream().listen((riderState) {
      rideChats.firstWhere((e) => e.rideId == riderState.rideId).addNewRider(riderState.rider);
    });
    // Rider left stream
    _riderLeftStreamSubscription = serviceLocator<RideInterface>().riderLeftStream().listen((riderState) {
      rideChats.firstWhere((e) => e.rideId == riderState.riderId).removeRider(riderState.riderId);
    });
    _chatRoomStreamSubscription = serviceLocator<MessageInterface>().chatStream().listen((chatRoom) {
      if(chatRoom == null) return;
      final index = rideChats.indexWhere((e) => e.chat.id == chatRoom.id);
      if(index != -1) {
        rideChats.add(ActiveRideChatController(chat: chatRoom));
      } else {
        rideChats[index] = ActiveRideChatController(chat: chatRoom);
        rideChats.refresh();
      }
    });
    _messageStreamSubscription = serviceLocator<MessageInterface>().messageStream().listen((message) {
      if(message == null) return;
      rideChats.firstWhere((e) => e.chat.id == message.chatId)._addMessage(message);
    });


  }

  @override
  void dispose() {
    super.dispose();
    //_riderStreamStreamSubscription?.cancel();
    _chatRoomStreamSubscription?.cancel();
    _messageStreamSubscription?.cancel();
  }
}

class ActiveRideChatController extends GetxController{
  
  ActiveRideChatController({required this.chat}){
    ride = Rx<RideModel>(chat.ride);
    participants.addAll(chat.participants);
    eligibleToLeave.value = chat.participants.any((e) => e.userId == Get.find<ProfileDataController>().userProfile.value?.id);
    leaveRideController = LeaveRideController(rideId: chat.id, onLeaveSuccess: () {
      
    },);
  }

  final ChatRoom chat;
  late Rx<RideModel> ride;
  String get rideId => chat.id;
  RxBool eligibleToLeave = RxBool(false);
  RxList<Rider> participants = RxList<Rider>([]);
  RxList<Message> messages = RxList<Message>([]);
  RxString notification = RxString("");
  int _page = 1;
  int _limit = 20;
  bool _allLoaded = false;
  late final LeaveRideController leaveRideController;

  init() {
    getMessages();
    serviceLocator<MessageInterface>().joinRoom(chat.id);
  }
  
  _addMessage(Message message) {
    messages.add(message);
    messages.refresh();
  }

  _updateMessage(Message message) {
    final index = messages.indexWhere((e) => e.id == message.id);
    messages[index] = message;
    messages.refresh();
  }

  addNewRider(Rider rider) {
    if(participants.length >= 4) return;
    participants.add(rider);
    participants.refresh();
  }

  removeRider(String userId) {
    final int index = participants.lastIndexWhere((e) => e.userId == userId);
    participants.removeAt(index);
    participants.refresh();
  }

  getMessages({bool refresh = false}) async{
    if(messages.isNotEmpty) {
      return;
    }
    if(_allLoaded && refresh == false) {
      return;
    }
    if(refresh) {
      _page = 1;
    }
    await serviceLocator<MessageInterface>().getMessages(GetMessagesParam(chatId: chat.id, page: _page, limit: _limit)).then((lr) {
      handleFold(
        either: lr,
        processStatusNotifier: null,
        onSuccess: (data) {
          for(var message in data) {
            _addMessage(message);
          }
          _page++;
          if(data.length < _limit) {
            _allLoaded = true;
          }
          debugPrint("Fetched Messages: ${messages.length}");
          messages.refresh();
        },
      );
    });
  }

  Future<bool> sendMessage(SendMessageReqParam param) async{
    bool state = false;
    await serviceLocator<MessageInterface>().sendMessage(param).then((lr) {
      handleFold(
        either: lr,
        processStatusNotifier: null,
        onSuccess: (data) {
          state = true;
        },
      );
    });
    return state;
  }
}

// extension ToRider on RiderStreamState{
//   bool get isJoined => riderState == RiderState.joined;

//   Rider get rider => Rider(id: id, name: name, email: email, number: number, imageUrl: imageUrl, rating: rating, baggageType: baggageType);
// }
