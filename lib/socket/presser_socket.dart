import 'dart:async';
import 'dart:io';

import 'package:exercise_counter/blocs/blocs.dart';
import 'package:exercise_counter/singletons/offense_counter.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

PresserBloc presserBloc = GetIt.instance.get<Blocs>().presserBloc;
final offenseCounter = GetIt.instance.get<OffenseCounter>();

class PresserSocket {
  Socket? socket;
  StreamSubscription? socketSub;

  DateTime lastPressTime = DateTime.now();

  void onError(e) {}

  void onDone() {
    GetIt.instance.get<Blocs>().connectBloc.add(ConnectionState.done);
  }

  void startListen() {
    if (socket == null) return;
    socketSub = socket!.listen((event) {
      final incoming = String.fromCharCodes(event);
      if (incoming == "Start!") {
        // socket!.write(Geti)
        // final remainPushups =
        //     offenseCounter.sumPushup() - offenseCounter.finishedPushup;
        // socket!.write(remainPushups.toString());
        // socket!.flush();
      } else if (incoming == "Pressed!") {
        // lastPressTime = DateTime.now();
        final betweenPressDuration = DateTime.now().difference(lastPressTime);
        debugPrint(betweenPressDuration.inSeconds.toString());
        if (betweenPressDuration.inSeconds > 1) {
          offenseCounter.finishedPushup += 1;
          presserBloc.add(DateTime.now().millisecondsSinceEpoch);
        }
        lastPressTime = DateTime.now();
      }
      final remainPushups =
          offenseCounter.sumPushup - offenseCounter.finishedPushup;
      socket!.write(remainPushups.toString());
      socket!.flush();
    }, onDone: onDone, onError: onError);
  }

  void close() async {
    await socketSub?.cancel();
    socket?.destroy();
    GetIt.instance.get<Blocs>().connectBloc.add(ConnectionState.active);
  }
}
