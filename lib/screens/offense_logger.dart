import 'package:exercise_counter/components/offense_button.dart';
import 'package:exercise_counter/screens/offense_sum.dart';
import 'package:exercise_counter/singletons/offense_counter.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

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
    final getit = GetIt.instance;
    getit.registerSingleton(OffenseCounter());
    offenseCounter = getit.get<OffenseCounter>();
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
          Card(
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Column(
                children: [
                  Text(
                    "${offenseCounter.carDamage}%",
                    style: const TextStyle(fontSize: 50),
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: MaterialButton(
                          color: Colors.blue,
                          child: const Text("+1"),
                          onPressed: () {
                            setState(() {
                              offenseCounter.carDamage += 1;
                            });
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        flex: 1,
                        child: MaterialButton(
                          color: Colors.blue,
                          child: const Text("+10"),
                          onPressed: () {
                            setState(() {
                              offenseCounter.carDamage += 10;
                            });
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        flex: 1,
                        child: MaterialButton(
                          color: Colors.blue,
                          child: const Text("-1"),
                          onPressed: () {
                            setState(() {
                              offenseCounter.carDamage -= 1;
                            });
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        flex: 1,
                        child: MaterialButton(
                          color: Colors.blue,
                          child: const Text("-10"),
                          onPressed: () {
                            setState(() {
                              offenseCounter.carDamage -= 10;
                            });
                          },
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
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
