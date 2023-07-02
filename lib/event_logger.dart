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
        padding: const EdgeInsets.only(left: 5, right: 5),
        children: [
          Row(
            children: [
              Expanded(
                flex: 1,
                child: MaterialButton(
                  color: Colors.blue,
                  child: const Text("BB"),
                  onPressed: () {},
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                flex: 1,
                child: MaterialButton(
                  color: Colors.blue,
                  child: const Text("AA"),
                  onPressed: () {},
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
