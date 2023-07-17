import 'dart:io';

import 'package:exercise_counter/blocs/blocs.dart';
import 'package:exercise_counter/components/offense_button.dart';
import 'package:exercise_counter/screens/offense_sum.dart';
import 'package:exercise_counter/singletons/offense_counter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:wakelock/wakelock.dart';

class OffenseLogger extends StatefulWidget {
  const OffenseLogger({super.key});

  @override
  State<OffenseLogger> createState() => _OffenseLoggerState();
}

class _OffenseLoggerState extends State<OffenseLogger> {
  late OffenseCounter offenseCounter;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    final getit = GetIt.instance;
    getit.registerSingleton(OffenseCounter());
    getit.registerSingleton(Blocs());
    offenseCounter = getit.get<OffenseCounter>();
    if (Platform.isAndroid || Platform.isIOS) Wakelock.enable();
  }

  Widget numberButtonText(String text) {
    const TextStyle numberStyle = TextStyle(fontSize: 10);
    return Text(text, style: numberStyle);
  }

  Widget damageLogger(
    int damageValue,
    void Function(int value) valueUpdater,
    String text,
    List<int> valueList,
  ) {
    const double buttonSpace = 2;
    final Widget buttons = Row(
      children: [
        Expanded(
          flex: 1,
          child: MaterialButton(
            color: Colors.blue,
            child: numberButtonText("+\n1"),
            onPressed: () {
              valueUpdater(damageValue + 1);
            },
          ),
        ),
        const SizedBox(
          width: buttonSpace,
        ),
        Expanded(
          flex: 1,
          child: MaterialButton(
            color: Colors.blue,
            child: numberButtonText("+\n10"),
            onPressed: () {
              valueUpdater(damageValue + 10);
            },
          ),
        ),
        const SizedBox(
          width: buttonSpace,
        ),
        Expanded(
          flex: 1,
          child: MaterialButton(
            color: Colors.red,
            child: numberButtonText("-\n1"),
            onPressed: () {
              valueUpdater(damageValue - 1);
            },
          ),
        ),
        const SizedBox(
          width: buttonSpace,
        ),
        Expanded(
          flex: 1,
          child: MaterialButton(
            color: Colors.red,
            child: numberButtonText("-\n10"),
            onPressed: () {
              valueUpdater(damageValue - 10);
            },
          ),
        )
      ],
    );

    Widget labels = Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        valueList.isNotEmpty
            ? Container(
                height: 50,
                width: 90,
                decoration: BoxDecoration(
                    border: Border.all(
                  color: Colors.white,
                  width: 1,
                )),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: valueList.map((e) => Text(e.toString())).toList(),
                ),
              )
            : null,
        Column(
          children: [
            Text(
              "$damageValue%",
              style: const TextStyle(fontSize: 30),
            ),
            Text(text),
          ],
        ),
      ].where((element) => element != null).cast<Widget>().toList(),
    );

    return Expanded(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Column(
            children: [
              labels,
              buttons,
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Offenses"),
        actions: [
          Container(
            padding: const EdgeInsets.all(10),
            child: MaterialButton(
              color: Colors.blue,
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const OffenseSum()));
              },
              child: const Text("Next"),
            ),
          )
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.only(left: 5, right: 5),
        children: [
          Row(
            children: [
              damageLogger(offenseCounter.carDamage, (value) {
                setState(() {
                  offenseCounter.carDamage = value;
                });
              }, "Car", offenseCounter.carDamages),
              damageLogger(offenseCounter.trailerDamage, (value) {
                setState(() {
                  offenseCounter.trailerDamage = value;
                });
              }, "Trailer", offenseCounter.trailerDamages),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(5),
            child: Row(
              children: [
                Expanded(
                  child: OffenseButton(
                    count: offenseCounter.wrongWayOffenseCount,
                    onPressed: () {
                      setState(() {
                        offenseCounter.wrongWayOffenseCount += 1;
                      });
                    },
                    text: "Wrong way",
                    icon: Icons.directions_off,
                    color: Colors.red,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: OffenseButton(
                    count: offenseCounter.headlightUsageOffenseCount,
                    onPressed: () {
                      setState(() {
                        offenseCounter.headlightUsageOffenseCount += 1;
                      });
                    },
                    text: "Headlight",
                    icon: Icons.light,
                    color: Colors.brown,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5),
            child: Row(
              children: [
                Expanded(
                  child: OffenseButton(
                    count: offenseCounter.notRestingOffenseCount,
                    onPressed: () {
                      setState(() {
                        offenseCounter.notRestingOffenseCount += 1;
                      });
                    },
                    text: "Resting",
                    icon: Icons.bed,
                    color: Colors.lime,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: OffenseButton(
                    count: offenseCounter.redLightOffenseCount,
                    onPressed: () {
                      setState(() {
                        offenseCounter.redLightOffenseCount += 1;
                      });
                    },
                    text: "Red Light",
                    icon: Icons.traffic,
                    color: Colors.pink,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5),
            child: Row(
              children: [
                Expanded(
                  child: OffenseButton(
                    count: offenseCounter.collidingWithCarCount,
                    onPressed: () {
                      setState(() {
                        offenseCounter.collidingWithCarCount += 1;
                      });
                    },
                    text: "Colliding with car",
                    icon: Icons.car_crash,
                    color: Colors.deepPurple,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: OffenseButton(
                    count: offenseCounter.speedingCount,
                    onPressed: () {
                      setState(() {
                        offenseCounter.speedingCount += 1;
                      });
                    },
                    text: "Speed",
                    icon: Icons.speed,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5),
            child: Row(
              children: [
                Expanded(
                  child: OffenseButton(
                    count: offenseCounter.failedToStopAtWeightStationCount,
                    onPressed: () {
                      setState(() {
                        offenseCounter.failedToStopAtWeightStationCount += 1;
                      });
                    },
                    text: "Weight Stop Failed",
                    icon: Icons.scale,
                    color: Colors.cyan,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: OffenseButton(
                    count: offenseCounter.illegalTrailerCount,
                    onPressed: () {
                      setState(() {
                        offenseCounter.illegalTrailerCount += 1;
                      });
                    },
                    text: "Illegal Trailer",
                    icon: Icons.fire_truck,
                    color: Colors.deepOrange,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      MaterialButton(
                        color: Colors.blue,
                        onPressed: () {
                          setState(() {
                            offenseCounter.repair();
                          });
                        },
                        child: const Text("Repair"),
                      ),
                      MaterialButton(
                        color: Colors.blue,
                        onPressed: () {
                          setState(() {
                            offenseCounter.callService();
                          });
                        },
                        child: Text(
                            "Call service ${offenseCounter.serviceCalled}"),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: OffenseButton(
                    count: offenseCounter.damagedVehicleCount,
                    onPressed: () {
                      setState(() {
                        offenseCounter.damagedVehicleCount += 1;
                      });
                    },
                    text: "Damaged vehicle",
                    icon: Icons.car_repair,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
