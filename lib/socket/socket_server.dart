import 'dart:async';
import 'dart:io';

import 'package:exercise_counter/blocs/blocs.dart';
import 'package:exercise_counter/socket/presser_socket.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class PushUpSocketServer {
  ServerSocket? serverSocket;
  StreamSubscription<Socket>? socketSub;
  PresserSocket? presserSocket;

  void newConnection(Socket socket) {
    if (presserSocket != null) {
      socket.destroy();
      socket.close();
    }

    presserSocket = PresserSocket();
    presserSocket?.socket = socket;
    // presserSocket = socket;
    presserSocket?.startListen();
    GetIt.instance.get<Blocs>().connectBloc.add(ConnectionState.active);
  }

  void onServerDone() async {
    await socketSub?.cancel();
    socketSub = null;
    presserSocket?.close();
    presserSocket?.socket = null;
    presserSocket = null;
    serverSocket!.close();
    serverSocket = null;
  }

  void onServerError(e) {
    debugPrint(e.toString());
  }

  void bind() async {
    serverSocket ??= await ServerSocket.bind(InternetAddress.anyIPv6, 12635);
    socketSub ??= serverSocket!
        .listen(newConnection, onDone: onServerDone, onError: onServerError);
  }
}
