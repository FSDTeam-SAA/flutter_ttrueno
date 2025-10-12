
part of '../inbox_controller.dart';


class ActiveRideChatController extends GetxController{
  
  ActiveRideChatController({required this.chat}){
    ride = Rx<RideModel>(chat.ride);
    participants.addAll(chat.participants);
    eligibleToLeave.value = chat.participants.any((e) => e.userId == Get.find<ProfileDataController>().userProfile.value?.id);
    
    kickoutRiderController = KickoutRiderController(rideId: chat.ride.id, onKickSuccess: (){
      Get.find<InboxController>().getAllChat(forceRefresh: true);
    });
    _leaveRideController = LeaveRideController(rideId: chat.ride.id, onLeaveSuccess: () {
      Get.find<InboxController>().getAllChat(forceRefresh: true);
    },);
    joinRideController = JoinRideController(rideId: chat.ride.id, onJoinSuccess: (riders) {
      onJoinSuccess(riders);
    });
    leaveRideController = LeaveRideController(rideId: rideId, onLeaveSuccess: () {
      Get.find<InboxController>().getAllChat(forceRefresh: true);
    });
  }

  final ChatRoom chat;
  late Rx<RideModel> ride;
  String get rideId => chat.ride.id;
  RxBool eligibleToLeave = RxBool(false);
  RxList<Rider> participants = RxList<Rider>([]);
  RxList<Message> messages = RxList<Message>([]);
  RxString notification = RxString("");
  int _page = 1;
  int _limit = 20;
  bool _allLoaded = false;
  late final LeaveRideController _leaveRideController;
  late final JoinRideController joinRideController;
  late final LeaveRideController leaveRideController;
  late final KickoutRiderController kickoutRiderController;

  ProcessStatusNotifier get leaveRideStn => _leaveRideController.stn;
  ProcessStatusNotifier get joinRideStn => joinRideController.stn;


  init() {
    getMessages();
    serviceLocator<MessageInterface>().joinRoom(chat.id);
  }

  void onJoinSuccess(List<Rider> newRiders) {
    participants.addAll(newRiders);
  }

  leaveRide({SnackbarNotifier? snackbarNotifier}) async{
    await _leaveRideController.leaveRide(snackbarNotifier: snackbarNotifier);
  }
  
  _addMessage(Message message) {
    messages.add(message);
    messages.refresh();
  }

  /// This will be used for updating the message in the list... maybe later
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

  void onBaggageChangeSuccess(BaggageType baggageType) {
    for(int i = 0; i < participants.length; i++) {
      if(participants[i].userId == Get.find<ProfileDataController>().userProfile.value?.id) {
        participants[i] = participants[i].copyWith(baggageType: baggageType);
      }
    }
    participants.refresh();
  }
}
