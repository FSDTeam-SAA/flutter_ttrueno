import 'dart:io';

import 'package:dio/dio.dart';


class SendMessageReqParam {
  final String chatId;
  final String? content;
  final String contentType;
  final String? replyTo;
  final List<File>? files;

  SendMessageReqParam({
    required this.chatId,
    this.content,
    this.contentType = 'text',
    this.files,
    this.replyTo
  });

  Map<String, dynamic> toMap() => {
        'chatId': chatId,
        'content': content,
        'contentType': contentType,
        'files': files,
      };

  Future<FormData> toFormData() async{
    final FormData formData = FormData();
    formData.fields.addAll([
      MapEntry('chatId', chatId),
      MapEntry('content', content ?? ''),
      MapEntry('contentType', contentType),
      MapEntry('replyTo', replyTo ?? ''),
    ]);
    if(files != null){
      for(var file in files!){
        formData.files.add(MapEntry('files', await MultipartFile.fromFile(file.path)));
      }
    }
    return formData;
  }

  @override
  String toString() =>
      'SendMessageParams(chatId: $chatId, content: $content, contentType: $contentType, files: ${files?.length})';
}