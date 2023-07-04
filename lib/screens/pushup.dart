import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:confetti/confetti.dart';
import 'package:exercise_counter/singletons/offense_counter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';

class PushUp extends StatefulWidget {
  const PushUp({super.key});

  @override
  State<PushUp> createState() => _PushUpState();
}

class _PushUpState extends State<PushUp> {
  int _toPushUp = 0;
  set toPushUp(int value) {
    _toPushUp = value;
    if (_toPushUp == 0) {
      // Done!!
      confettiController.play();
      donePlayer.seek(Duration.zero);
      donePlayer.resume();
      Future.delayed(const Duration(seconds: 10))
          .then((value) => confettiController.stop());
    } else if (_toPushUp < 0) {
      _toPushUp = 0;
    }
  }

  int get toPushUp => _toPushUp;

  // int toPushUp = 0;
  Duration? lassPressDuration;
  FocusNode focusNode = FocusNode();

  late ConfettiController confettiController;

  final pushupPlayer = AudioPlayer();
  final donePlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    toPushUp = GetIt.instance.get<OffenseCounter>().sumPushup();
    // Set landscape orientation
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    confettiController =
        ConfettiController(duration: const Duration(seconds: 10));

    pushupPlayer.setVolume(1);
    donePlayer.setVolume(1);
    pushupPlayer.setSource(AssetSource('sound_effects/pushup.opus'));
    donePlayer.setSource(AssetSource('sound_effects/done.opus'));
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    confettiController.dispose();
    super.dispose();
  }

  /// A custom Path to paint stars.
  Path drawStar(Size size) {
    // Method to convert degree to radians
    double degToRad(double deg) => deg * (pi / 180.0);

    const numberOfPoints = 5;
    final halfWidth = size.width / 2;
    final externalRadius = halfWidth;
    final internalRadius = halfWidth / 2.5;
    final degreesPerStep = degToRad(360 / numberOfPoints);
    final halfDegreesPerStep = degreesPerStep / 2;
    final path = Path();
    final fullAngle = degToRad(360);
    path.moveTo(size.width, halfWidth);

    for (double step = 0; step < fullAngle; step += degreesPerStep) {
      path.lineTo(halfWidth + externalRadius * cos(step),
          halfWidth + externalRadius * sin(step));
      path.lineTo(halfWidth + internalRadius * cos(step + halfDegreesPerStep),
          halfWidth + internalRadius * sin(step + halfDegreesPerStep));
    }
    path.close();
    return path;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text("Push up!"),
      // ),
      body: KeyboardListener(
        autofocus: true,
        focusNode: focusNode,
        onKeyEvent: (event) {
          if (event is KeyUpEvent) {
            if (lassPressDuration == null ||
                (lassPressDuration != null &&
                    (event.timeStamp.inMicroseconds -
                                lassPressDuration!.inMicroseconds)
                            .abs() >
                        500)) {
              debugPrint(event.logicalKey.debugName.toString());
              setState(() {
                toPushUp = toPushUp - 1;
              });
              focusNode.requestFocus();
              pushupPlayer.seek(Duration.zero);
              pushupPlayer.resume();
            }
            lassPressDuration = event.timeStamp;
          }
        },
        child: Stack(
          children: [
            Center(
              child: Text(
                toPushUp.toString(),
                style: const TextStyle(
                  fontFamily: 'Rajdhiani',
                  fontSize: 350,
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: ConfettiWidget(
                confettiController: confettiController,
                blastDirectionality: BlastDirectionality.explosive,
                shouldLoop: true,
                colors: const [
                  Colors.green,
                  Colors.blue,
                  Colors.pink,
                  Colors.orange,
                  Colors.purple
                ], // manually specify the colors to be used
                createParticlePath: drawStar,
              ),
            )
          ],
        ),
      ),
    );
  }
}
