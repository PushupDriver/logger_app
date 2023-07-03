import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PushUp extends StatefulWidget {
  const PushUp({super.key});

  @override
  State<PushUp> createState() => _PushUpState();
}

class _PushUpState extends State<PushUp> {
  String disp = "Press key";

  @override
  void initState() {
    super.initState();

    // Set landscape orientation
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Push up!"),
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
