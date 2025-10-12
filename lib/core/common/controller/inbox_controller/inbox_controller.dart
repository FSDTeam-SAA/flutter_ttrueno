
import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:ttrueno_fo827e642a0c4/core/base/pagination.dart';
import 'package:ttrueno_fo827e642a0c4/core/notifiers/button_status_notifier.dart';
import 'package:ttrueno_fo827e642a0c4/core/notifiers/snackbar_notifier.dart';
import 'package:ttrueno_fo827e642a0c4/init_dependency.dart';
import 'package:ttrueno_fo827e642a0c4/modules/message/model/chat_room.dart';
import 'package:ttrueno_fo827e642a0c4/modules/ride&booking/controller/change_baggage_controller.dart';
import 'package:ttrueno_fo827e642a0c4/modules/ride&booking/controller/join_ride_controller.dart';
import 'package:ttrueno_fo827e642a0c4/modules/ride&booking/controller/kickout_rider_controller.dart';
import 'package:ttrueno_fo827e642a0c4/modules/ride&booking/controller/leave_ride_controller.dart';
import 'package:ttrueno_fo827e642a0c4/modules/ride&booking/model/ride_model.dart';
import '../../../../modules/message/interface/message_interface.dart';
import '../../../../modules/message/model/get_chats_req_param.dart';
import '../../../../modules/message/model/get_messages_param.dart';
import '../../../../modules/message/model/message.dart';
import '../../../../modules/message/model/send_message_req_param.dart';
import '../../../../modules/profile/controller/profile_data_controller.dart';
import '../../../../modules/ride&booking/interface/ride_interface.dart';
import '../../../../modules/ride&booking/model/enum/baggage_type_enum.dart';
import '../../../utils/helpers/handle_fold.dart';
import '../../model/rider.dart';
import '../../model/rider_joined_state.dart';
import '../../model/rider_left_state.dart';
part 'part/active_ride_chat_controller.dart';


class InboxController extends GetxController{

  InboxController();
  int _limit = 10;
  Rx<Pagination<ActiveRideChatController>> rideChatPages =
      Rx<Pagination<ActiveRideChatController>>(
        NotInitialized<ActiveRideChatController>([]),
      );
  bool _isLastPage = false;

  Future<void> init() async{
    await getAllChat(forceRefresh: true);
    _lisenToStreams();
  }

  StreamSubscription<RiderJoinedState>? _riderJoinedStreamSubscription;
  StreamSubscription<RiderLeftState>? _riderLeftStreamSubscription;
  StreamSubscription<Message?>? _messageStreamSubscription;
  StreamSubscription<ChatRoom?>? _chatRoomStreamSubscription;

  Future<ActiveRideChatController?> getChatById(String chatId) async{
    for(int i = 0; i < rideChatPages.value.data.length; i++) {
      if(rideChatPages.value.data[i].chat.id == chatId) {
        return rideChatPages.value.data[i];
      }
    }
    return null;
  }

  Future<ActiveRideChatController?> getChatByRideId(String rideId) async{
    for(int i = 0; i < rideChatPages.value.data.length; i++) {
      if(rideChatPages.value.data[i].ride.value.id == rideId) {
        return rideChatPages.value.data[i];
      }
    }
    return null;
  }
  
  Future<void> getAllChat({bool? forceRefresh}) async{
    if(forceRefresh == true) {
      _isLastPage = false;
      rideChatPages.value = RefreshingPage([]);
    } else {
      if(_isLastPage) {
        return;
      }
      if(rideChatPages.value is LoadingMorePage || rideChatPages.value is RefreshingPage) {
        return;
      }
      rideChatPages.value = LoadingMorePage(rideChatPages.value.data);
    }

    await serviceLocator<MessageInterface>().getAllChat(
      GetChatsParam(page: rideChatPages.value.page, limit: _limit)
    ).then((lr) {
      handleFold(
        either: lr,
        processStatusNotifier: null,
        onSuccess: (data) {
          List<ActiveRideChatController> page = [];
          for(final chat in data) {
            debugPrint("Chat Room: ${chat.id}, participants: ${chat.participants.length}");
            final activeRideChat = ActiveRideChatController(chat: chat);
            page.add(activeRideChat);
            activeRideChat.init();
          }
          rideChatPages.refresh();
          if(data.length < _limit) {
            _isLastPage = true;
          }
          rideChatPages.value = Loaded(rideChatPages.value is RefreshingPage ? page : [...rideChatPages.value.data, ...page]); 
          rideChatPages.refresh(); 
        },
      );
    });
  }

  _lisenToStreams() {
    // Rider join stream
    // _riderJoinedStreamSubscription = serviceLocator<RideInterface>().riderJoinedStream().listen((riderState) {
    //   rideChatPages.value.data.firstWhere((e) => e.rideId == riderState.rideId).addNewRider(riderState.rider);
    // });
    // // Rider left stream
    // _riderLeftStreamSubscription = serviceLocator<RideInterface>().riderLeftStream().listen((riderState) {
    //   rideChatPages.value.data.firstWhere((e) => e.rideId == riderState.riderId).removeRider(riderState.riderId);
    // });


    _chatRoomStreamSubscription = serviceLocator<MessageInterface>().chatStream().listen((chatRoom) {
      if(chatRoom == null) return;
      final index = rideChatPages.value.data.indexWhere((e) => e.chat.id == chatRoom.id);
      if(index != -1) {
        rideChatPages.value.data.add(ActiveRideChatController(chat: chatRoom));
      } else {
        rideChatPages.value.data[index] = ActiveRideChatController(chat: chatRoom);
        rideChatPages.refresh();
      }
    });
    _messageStreamSubscription = serviceLocator<MessageInterface>().messageStream().listen((message) async{
      if(message == null) return;
      final int index = rideChatPages.value.data.indexWhere((e) => e.chat.id == message.chatId);
      if(index != -1) {
        rideChatPages.value.data[index]._addMessage(message);
        if(message.type == MessageType.system) {
          debugPrint("New system message: ${message.message}");
          debugPrint("Updating ride");
          await serviceLocator<RideInterface>().getRideById(rideId: rideChatPages.value.data[index].rideId).then((lr) {
            handleFold(
              either: lr,
              processStatusNotifier: null,
              onSuccess: (data) {
                rideChatPages.value.data[index].participants.value = data.participants;
                rideChatPages.value.data[index].participants.refresh();
                debugPrint("Ride chat updated");
              },
            );
          });
        }
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _riderJoinedStreamSubscription?.cancel();
    _riderLeftStreamSubscription?.cancel();
    _chatRoomStreamSubscription?.cancel();
    _messageStreamSubscription?.cancel();
  }
}

// extension ToRider on RiderStreamState{
//   bool get isJoined => riderState == RiderState.joined;

//   Rider get rider => Rider(id: id, name: name, email: email, number: number, imageUrl: imageUrl, rating: rating, baggageType: baggageType);
// }
