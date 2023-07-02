import 'package:flutter/material.dart';

class EventLogger extends StatefulWidget {
  const EventLogger({super.key});

  @override
  State<EventLogger> createState() => _EventLoggerState();
}

class _EventLoggerState extends State<EventLogger> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Event Logger")),
      body: ListView(
        children: [],
      ),
    );
  }
}
