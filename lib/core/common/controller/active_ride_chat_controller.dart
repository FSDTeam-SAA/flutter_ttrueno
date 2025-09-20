
import 'dart:async';

import 'package:get/get.dart';
import 'package:ttrueno_fo827e642a0c4/core/common/enum/rider_state.dart';
import 'package:ttrueno_fo827e642a0c4/core/common/model/rider_stream_state.dart';
import 'package:ttrueno_fo827e642a0c4/init_dependency.dart';
import 'package:ttrueno_fo827e642a0c4/modules/message/model/chat_room.dart';
import 'package:ttrueno_fo827e642a0c4/modules/ride&booking/model/ride_model.dart';
import '../../../modules/message/interface/message_interface.dart';
import '../../../modules/message/model/message.dart';
import '../../../modules/message/model/send_message_req_param.dart';
import '../../helpers/handle_fold.dart';
import '../model/rider.dart';

class InboxController extends GetxController{

  InboxController(){
    getAllChat();
    _lisenToStreams();
  }

  StreamSubscription<RiderStreamState>? _riderStreamStreamSubscription;
  StreamSubscription<Message>? _messageStreamSubscription;
  RxMap<String, ActiveRideChatController> rideChat = RxMap<String, ActiveRideChatController>({});
  
  Future<void> getAllChat() async{
    await serviceLocator<MessageInterface>().getAllChat().then((lr) {
      handleFold(
        either: lr,
        processStatusNotifier: null,
        onSuccess: (data) {
          for(final chat in data) {
            rideChat[chat.id] = ActiveRideChatController(chat: chat);
          }
        },
      );
    });
  }

  _lisenToStreams() {
    _riderStreamStreamSubscription = serviceLocator<Stream<RiderStreamState>>().listen((riderStreamState) {
      rideChat[riderStreamState.rideId]?._updateRiderState(riderStreamState);
    });
    _messageStreamSubscription = serviceLocator<Stream<Message>>().listen((message) {
      rideChat.values.firstWhere((e) => e.chat.id == message.chatId)._addMessage(message);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _riderStreamStreamSubscription?.cancel();
    _messageStreamSubscription?.cancel();
  }
}

class ActiveRideChatController extends GetxController{
  
  ActiveRideChatController({required this.chat}){
    ride = Rx<RideModel>(chat.rideId);
  }

  final ChatRoom chat;
  late Rx<RideModel> ride;
  String get rideId => chat.id;

  RxList<Rider> participants = RxList<Rider>([]);
  RxMap<String, Message> messages = RxMap<String, Message>({});
  RxString notification = RxString("");

  _addMessage(Message message) {
    messages[message.id] = message;
  }

  _updateRiderState(RiderStreamState riderStreamState) {
    if(riderStreamState.riderState == RiderState.joined) {
      participants.add(riderStreamState.rider);
    }

    if(riderStreamState.riderState == RiderState.left) {
      participants.removeWhere((element) => element.id == riderStreamState.id);
    }

    if(riderStreamState.riderState == RiderState.kicked) {
      participants.removeWhere((element) => element.id == riderStreamState.id);
      notification.value = " ${riderStreamState.rider.name} have been kicked out from the ride";
    }
  }

  getMessages() async{
    await serviceLocator<MessageInterface>().getMessages(chat.id).then((lr) {
      handleFold(
        either: lr,
        processStatusNotifier: null,
        onSuccess: (data) {
          for(var message in data) {
            _addMessage(message);
          }
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

extension ToRider on RiderStreamState{
  bool get isJoined => riderState == RiderState.joined;

  Rider get rider => Rider(id: id, name: name, email: email, number: number, imageUrl: imageUrl, rating: rating, baggageType: baggageType);
}
