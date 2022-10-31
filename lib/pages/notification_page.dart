import 'package:chat/core/services/notification/chat_notification_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final servive = Provider.of<ChatNotificationService>(context);

    final items = servive.items;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notificações'),
      ),
      body: ListView.builder(
        itemCount: servive.itemsCount,
        itemBuilder: (ctx, indice) => ListTile(
          title: Text(items[indice].title),
          subtitle: Text(items[indice].body),
          onTap: () => servive.remove(indice),
        ),
      ),
    );
  }
}
