import 'package:flutter/material.dart';

class ExerciseCounter extends StatefulWidget {
  const ExerciseCounter({super.key});

  @override
  State<ExerciseCounter> createState() => _ExerciseCounterState();
}

class _ExerciseCounterState extends State<ExerciseCounter> {
  var disp = "Press a key";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Exercise Type"),
      ),
      body: RawKeyboardListener(
        autofocus: true,
        focusNode: FocusNode(),
        onKey: (value) {
          setState(() {
            disp = value.logicalKey.debugName.toString();
          });
        },
        child: Center(
          child: Text(disp),
        ),
      ),
    );
  }
}
