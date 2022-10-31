import 'dart:async';
import 'dart:math';

import '../../models/chat_message.dart';
import '../../models/chat_user.dart';
import 'chat_service.dart';

class ChatMockService implements ChatService {
  static MultiStreamController<List<ChatMessage>>? _controller;
  static final List<ChatMessage> _msgs = [
    /*
    ChatMessage(
      id: Random().nextDouble().toString(),
      text: 'text 1 com muito texto para quebrar a linha',
      createdAt: DateTime.now(),
      userId: '1',
      userName: 'user.name1',
      userImageUrl: 'assets/images/avatar.png',
    ),
    ChatMessage(
      id: Random().nextDouble().toString(),
      text: 'text 2',
      createdAt: DateTime.now(),
      userId: '2',
      userName: 'user.name2',
      userImageUrl: 'assets/images/avatar.png',
    ),
    ChatMessage(
      id: Random().nextDouble().toString(),
      text: 'text 3',
      createdAt: DateTime.now(),
      userId: '1',
      userName: 'user.name1',
      userImageUrl: 'assets/images/avatar.png',
    )
    */
  ];
  static final _msgStream = Stream<List<ChatMessage>>.multi((controller) {
    _controller = controller;
    _controller?.add(_msgs.reversed.toList());
  });

  @override
  Stream<List<ChatMessage>> messageStream() {
    return _msgStream;
  }

  @override
  Future<ChatMessage> save(String text, ChatUser user) async {
    final newMessage = ChatMessage(
      id: Random().nextDouble().toString(),
      text: text,
      createdAt: DateTime.now(),
      userId: user.id,
      userName: user.name,
      userImageUrl: user.imageUrl,
    );

    _msgs.add(newMessage);
    _controller?.add(_msgs.reversed.toList());

    return newMessage;
  }
}
