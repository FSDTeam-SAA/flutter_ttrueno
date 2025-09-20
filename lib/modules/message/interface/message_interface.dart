import 'package:ttrueno_fo827e642a0c4/core/api_handler/trycatch.dart';
import 'package:ttrueno_fo827e642a0c4/modules/message/model/chat_room.dart';

import '../../../core/api_handler/success.dart';
import '../../../core/helpers/typedefs.dart';
import '../model/message.dart';
import '../model/send_message_req_param.dart';

abstract base class MessageInterface extends ErrorCatcher{
  FutureRequest<Success<List<ChatRoom>>> getAllChat();
  
  FutureRequest<Success> sendMessage(SendMessageReqParam param);

  FutureRequest<Success> deleteMessage(String messageId);

  FutureRequest<Success<List<Message>>> getMessages(String chatId);

  Stream<Message> messageStream();
}