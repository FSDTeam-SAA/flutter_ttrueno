import 'package:ttrueno_fo827e642a0c4/core/api_handler/success.dart';
import 'package:ttrueno_fo827e642a0c4/core/constants/api_endpoints.dart';
import 'package:ttrueno_fo827e642a0c4/core/helpers/typedefs.dart';
import 'package:ttrueno_fo827e642a0c4/core/services/app_pigeon/app_pigeon.dart';
import 'package:ttrueno_fo827e642a0c4/modules/message/interface/message_interface.dart';
import 'package:ttrueno_fo827e642a0c4/modules/message/model/chat_room.dart';
import 'package:ttrueno_fo827e642a0c4/modules/message/model/message.dart';
import 'package:ttrueno_fo827e642a0c4/modules/message/model/send_message_req_param.dart';

import '../../../core/helpers/format_response_data.dart';

base class MessageService extends MessageInterface{
  final AppPigeon appPigeon;

  MessageService(this.appPigeon);

  @override
  FutureRequest<Success<List<Message>>> getMessages(String chatId) async {
    return await asyncTryCatch(
      tryFunc: () async{
        final response = await appPigeon.get(ApiEndpoints.getMessages(chatId));
        final messages = (extractBodyData(response)["messages"] as List<dynamic>).map((e) => Message.fromJson(e)).toList();
        return Success(message: extractSuccessMessage(response), data: messages);
      },
    );
  }

  @override
  Stream<Message> messageStream() {
    return appPigeon.listen("message").map((e) => Message.fromJson(e));
  }

  @override
  FutureRequest<Success> sendMessage(SendMessageReqParam param) async{
    return await asyncTryCatch(
      tryFunc: () async{
        final response = await appPigeon.post(
          ApiEndpoints.sendMessage(param.chatId),
          data: param.toFormData(),
        );
        return Success(message: extractSuccessMessage(response));
      },
    );
  }
  
  @override
  FutureRequest<Success> deleteMessage(String messageId) async{
    return asyncTryCatch(
      tryFunc: () async{
        final response = await appPigeon.delete(ApiEndpoints.deleteMessage(messageId));
        return Success(message: extractSuccessMessage(response));
      },
    );
  }

  @override
  FutureRequest<Success<List<ChatRoom>>> getAllChat() async{
    return await asyncTryCatch(
      tryFunc: () async{
        final response = await appPigeon.get(ApiEndpoints.getAllChat);
        final chatRooms = (extractBodyData(response)["data"] as List<dynamic>).map((e) => ChatRoom.fromJson(e)).toList();
        return Success(message: extractSuccessMessage(response), data: chatRooms);
      },
    );
    
  }
}