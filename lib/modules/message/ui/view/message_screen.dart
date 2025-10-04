import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/state_manager.dart';
import 'package:ttrueno_fo827e642a0c4/core/common/controller/inbox_controller.dart';
import 'package:ttrueno_fo827e642a0c4/core/common/widgets/chat_ride_card_widget.dart';
import 'package:ttrueno_fo827e642a0c4/core/utils/helpers/auth_role.dart';
import 'package:ttrueno_fo827e642a0c4/core/utils/helpers/extensions.dart';
import 'package:ttrueno_fo827e642a0c4/core/theme/app_colors.dart';
import 'package:ttrueno_fo827e642a0c4/modules/message/model/message.dart';
import 'package:ttrueno_fo827e642a0c4/modules/message/model/send_message_req_param.dart';
import 'package:ttrueno_fo827e642a0c4/modules/ride&booking/controller/leave_ride_controller.dart';

import '../../../../app_manager.dart';
import '../../../../core/notifiers/snackbar_notifier.dart';
import '../../../../core/services/app_pigeon/app_pigeon.dart';
import '../../../../core/theme/app_gap.dart';

class MessageScreen extends StatefulWidget {
  final ActiveRideChatController activeRideChatController;
  const MessageScreen({super.key, required this.activeRideChatController});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {

  late final LeaveRideController leaveRideController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    leaveRideController = LeaveRideController(
      rideId: widget.activeRideChatController.ride.value.id,
      onLeaveSuccess: () {
        Get.find<InboxController>().getAllChat(forceRefresh: true);
        Navigator.of(context).pop();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Chat'.tr(), style: TextStyle(color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: GestureDetector(
              onTap: () {
                if(widget.activeRideChatController.eligibleToLeave.value) {
                  leaveRideController.leaveRide(snackbarNotifier: SnackbarNotifier(context: context));
                }
              },
              child: Row(
                children: [
                  Text(
                    'Leave'.tr(),
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Image.asset(
                    'assets/images/leave.png',
                    width: 28,
                    height: 28,
                    color: Colors.red,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),

      body: Column(
        children: [
          ChatRideCardWidget(activeRide: widget.activeRideChatController),
          //RideCard.fromRide(widget.activeRideChatController.ride.value, elevation: 0),
          Gap.h20,
          Divider(height: 4, color: AppColors.primarybutton),
          Expanded(child: _ChatMessagesList(widget.activeRideChatController.messages)),
          _InputMessageBox(widget.activeRideChatController),
        ],
      ),
    );
  }
}


// Keep your other classes (_ChatMessagesList, _InputMessageBox) as they are.

class _ChatMessagesList extends StatelessWidget {
  final RxList<Message> messages;
  const _ChatMessagesList(this.messages);

  @override
  Widget build(BuildContext context) {
    return ObxValue(
      (data)=> ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        itemCount: messages.length,
        itemBuilder: (context, index) {
          final message = messages[index];
          if(message.type == MessageType.system) {
            return _buildSystemMessage(
              message: message.message,
              time: message.updatedAt.toChatTimeString(),
            );
          }
          if(message.sender.id == (Get.find<AppManager>().authStatus as Authenticated).auth.userId) {
            return _buildOutgoingMessage(
              message: message.message,
              time: message.updatedAt.toChatTimeString(),
            );
          }
          return _buildIncomingMessage(
            message: message.message,
            time: message.updatedAt.toChatTimeString(),
            avatarAsset: message.sender.imageUrl,
          );
        },
      ),
      messages,
    );
  }

  Widget _buildIncomingMessage({
    required String message,
    required String time,
    required String avatarAsset,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(radius: 18, backgroundImage: AssetImage(avatarAsset)),
            Gap.w8,
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 250),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                ),
                child: Text(
                  message,
                  style: const TextStyle(
                    fontSize: 18,
                    color: AppColors.primaryTextblack,
                  ),
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 48, top: 4),
          child: Text(
            time,
            style: const TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ),
      ],
    );
  }
  Widget _buildSystemMessage({required String message, required String time}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Text(
        message,
        style: const TextStyle(
          fontSize: 12,
          color: AppColors.primaryTextblack,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildOutgoingMessage({
    required String message,
    required String time,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 300),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.messageBoxbackground,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                ),
                child: Text(
                  message,
                  style: const TextStyle(
                    color: AppColors.primaryTextblack,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(right: 8, top: 4),
          child: Text(time, style: TextStyle(fontSize: 16, color: Colors.grey)),
        ),
      ],
    );
  }
  
  
}

class _InputMessageBox extends StatefulWidget {
  final ActiveRideChatController activeRideChatController;
  const _InputMessageBox(this.activeRideChatController);

  @override
  State<_InputMessageBox> createState() => _InputMessageBoxState();
}

class _InputMessageBoxState extends State<_InputMessageBox> {

  final TextEditingController textEditingController = TextEditingController();

  _sendMessage() async{
     widget.activeRideChatController.sendMessage(
      SendMessageReqParam(
        chatId: widget.activeRideChatController.chat.id,
        message: textEditingController.text
      )
    );
    textEditingController.clear();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(color: Colors.grey[300]!, width: 1.5),
                ),
                child: TextField(
                  controller: textEditingController,
                  decoration: InputDecoration(
                    hintText: 'Type Message'.tr(),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 10),
                  ),
                ),
              ),
            ),
            Gap.w8,
            InkWell(
              onTap: () {
                _sendMessage();
              },
              child: CircleAvatar(
                radius: 22,
                child: Image.asset(
                  'assets/images/send.png',
                  width: 48,
                  height: 48,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
