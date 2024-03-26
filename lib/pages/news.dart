import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(children: [
        Text("Flutter"), 
        Text("News", style: TextStyle(
          color: Colors.blue, fontWeight: FontWeight.bold
      ))]),
      )
    );
  }
}