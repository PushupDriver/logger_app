import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:confetti/confetti.dart';
import 'package:exercise_counter/singletons/offense_counter.dart';
import 'package:exercise_counter/socket/presser_socket.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../blocs/blocs.dart';

class PushUp extends StatefulWidget {
  const PushUp({super.key});

  @override
  State<PushUp> createState() => _PushUpState();
}

class _PushUpState extends State<PushUp> {
  GetIt getit = GetIt.instance;

  late ConfettiController confettiController;

  final pushupPlayer = AudioPlayer();
  final donePlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
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
    pushupPlayer.dispose();
    donePlayer.dispose();
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

  void pressed() {
    setState(() {});
    final toPushup = offenseCounter.sumPushup - offenseCounter.finishedPushup;
    if (toPushup == 0) {
      // Done!!
      confettiController.play();
      donePlayer.seek(Duration.zero);
      donePlayer.resume();
      Future.delayed(const Duration(seconds: 10))
          .then((value) => confettiController.stop());
    } else if (toPushup < 0) {
      setState(() {
        offenseCounter.finishedPushup = offenseCounter.sumPushup;
      });
      return;
    }

    // setState(() {
    //   offenseCounter.finishedPushup += 1;
    // });
    pushupPlayer.seek(Duration.zero);
    pushupPlayer.resume();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text("Push up!"),
      // ),
      body: MultiBlocListener(
        listeners: [
          BlocListener(
            bloc: getit.get<Blocs>().presserBloc,
            listener: (context, state) {
              pressed();
            },
          ),
          BlocListener(
            bloc: getit.get<Blocs>().connectBloc,
            listener: (context, state) {
              if (state == ConnectionState.done &&
                  Navigator.of(context).canPop()) {
                Navigator.of(context).pop();
              }
            },
          )
        ],
        child: Stack(
          children: [
            Center(
              child: Text(
                (offenseCounter.sumPushup - offenseCounter.finishedPushup)
                    .toString(),
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
