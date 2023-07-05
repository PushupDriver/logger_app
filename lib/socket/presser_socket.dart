import 'dart:async';
import 'dart:io';

import 'package:exercise_counter/blocs/blocs.dart';
import 'package:get_it/get_it.dart';

PresserBloc presserBloc = GetIt.instance.get<Blocs>().presserBloc;

class PresserSocket {
  Socket? socket;
  StreamSubscription? socketSub;

  void onError(e) {}

  void onDone() {
    GetIt.instance.get<Blocs>().connectBloc.add(1);
  }

  void startListen() {
    if (socket == null) return;
    socketSub = socket!.listen((event) {
      presserBloc.add(0);
    }, onDone: onDone, onError: onError);
  }

  void close() async {
    await socketSub?.cancel();
    socket?.destroy();
    GetIt.instance.get<Blocs>().connectBloc.add(1);
  }
}
