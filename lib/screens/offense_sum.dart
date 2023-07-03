import 'package:exercise_counter/singletons/offense_counter.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class OffenseSum extends StatefulWidget {
  const OffenseSum({super.key});

  @override
  State<OffenseSum> createState() => _OffenseSumState();
}

class _OffenseSumState extends State<OffenseSum> {
  late OffenseCounter offenseCounter;

  @override
  void initState() {
    super.initState();
    final getit = GetIt.instance;
    offenseCounter = getit.get<OffenseCounter>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Offense Sum"),
        ),
        body: ListView(
          children: [
            ListTile(
              title: const Text("Wrong way offense"),
              trailing: Text(offenseCounter.wrongWayOffenseCount.toString()),
            ),
            const Divider(),
            ListTile(
              title: const Text("Headlight usage offense"),
              trailing:
                  Text(offenseCounter.headlightUsageOffenseCount.toString()),
            ),
            const Divider(),
            ListTile(
              title: const Text("Not resting offense"),
              trailing: Text(offenseCounter.notRestingOffenseCount.toString()),
            ),
            const Divider(),
            ListTile(
              title: const Text("Red light offense"),
              trailing: Text(offenseCounter.redLightOffenseCount.toString()),
            ),
            const Divider(),
            ListTile(
              title: const Text("Colliding with car offense"),
              trailing: Text(offenseCounter.collidingWithCarCount.toString()),
            ),
            const Divider(),
            ListTile(
              title: const Text("Speeding offense"),
              trailing: Text(offenseCounter.speedingCount.toString()),
            ),
            const Divider(),
            ListTile(
              title: const Text("Failed to stop at weight station offense"),
              trailing: Text(
                  offenseCounter.failedToStopAtWeightStationCount.toString()),
            ),
            const Divider(),
            ListTile(
              title: const Text("Illegal trailer offense"),
              trailing: Text(offenseCounter.illegalTrailerCount.toString()),
            ),
            const Divider(),
            ListTile(
              title: const Text("Damaged vehicle offense"),
              trailing: Text(offenseCounter.damagedVehicleCount.toString()),
            ),
            const Divider(),
            ListTile(
              title: const Text("Car damage"),
              trailing: Text("${offenseCounter.carDamage}%"),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MaterialButton(
                color: Colors.blue,
                onPressed: () {},
                child: const Text("Next"),
              ),
            )
          ],
        )
        // RawKeyboardListener(
        //   autofocus: true,
        //   focusNode: FocusNode(),
        //   onKey: (value) {
        //     setState(() {
        //       disp = value.logicalKey.debugName.toString();
        //     });
        //   },
        //   child: Center(
        //     child: Text(disp),
        //   ),
        // ),
        );
  }
}
