import 'dart:io';

import 'package:exercise_counter/blocs/blocs.dart';
import 'package:exercise_counter/screens/pushup.dart';
import 'package:exercise_counter/socket/socket_server.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class WaitForPresser extends StatefulWidget {
  const WaitForPresser({super.key});

  @override
  State<WaitForPresser> createState() => _WaitForPresserState();
}

class _WaitForPresserState extends State<WaitForPresser> {
  Future<List<String>> getIPAddresses() async {
    List<String> addresses = [];
    for (final interface in await NetworkInterface.list()) {
      for (final addr in interface.addresses) {
        addresses.add(addr.address);
      }
    }
    return addresses;
  }

  late PushUpSocketServer socketServer;

  @override
  void initState() {
    super.initState();
    GetIt getit = GetIt.instance;
    try {
      final socketServer = getit.get<PushUpSocketServer>();
      if (socketServer.presserSocket != null) {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const PushUp()));
      }
    } catch (e) {
      socketServer = PushUpSocketServer();
      getit.registerSingleton(socketServer);
      socketServer.bind();
    }
    getit.get<Blocs>().connectBloc.stream.listen((event) {
      if (event == ConnectionState.active) {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const PushUp()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<String>>(
          future: getIPAddresses(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            final list = [
              const Text(
                "Please connect to one of following addresses:",
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 1),
                ),
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                    children: snapshot.data!
                        .map((e) => Column(
                              children: [
                                Text(e),
                                const SizedBox(
                                  height: 5,
                                  width: double.infinity,
                                  // width: MediaQuery.of(context).,
                                )
                              ],
                            ))
                        .toList()),
              )
            ];
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: list,
              ),
            );
          }),
    );
  }
}
