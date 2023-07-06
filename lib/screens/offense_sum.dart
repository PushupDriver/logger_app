import 'package:exercise_counter/screens/wait_for_presser.dart';
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
        title: const Text("Sum"),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text("Wrong way offense"),
            trailing: Text(
                "${offenseCounter.wrongWayOffenseCount} x $perOffencePushup"),
          ),
          const Divider(),
          ListTile(
            title: const Text("Headlight usage offense"),
            trailing: Text(
                "${offenseCounter.headlightUsageOffenseCount} x $perOffencePushup"),
          ),
          const Divider(),
          ListTile(
            title: const Text("Not resting offense"),
            trailing: Text(
                "${offenseCounter.notRestingOffenseCount} x $perOffencePushup"),
          ),
          const Divider(),
          ListTile(
            title: const Text("Red light offense"),
            trailing: Text(
                "${offenseCounter.redLightOffenseCount} x $perOffencePushup"),
          ),
          const Divider(),
          ListTile(
            title: const Text("Colliding with car offense"),
            trailing: Text(
                "${offenseCounter.collidingWithCarCount} x $perOffencePushup"),
          ),
          const Divider(),
          ListTile(
            title: const Text("Speeding offense"),
            trailing:
                Text("${offenseCounter.speedingCount} x $perOffencePushup"),
          ),
          const Divider(),
          ListTile(
            title: const Text("Failed to stop at weight station offense"),
            trailing: Text(
                "${offenseCounter.failedToStopAtWeightStationCount} x $perOffencePushup"),
          ),
          const Divider(),
          ListTile(
            title: const Text("Illegal trailer offense"),
            trailing: Text(
                "${offenseCounter.illegalTrailerCount} x $perOffencePushup"),
          ),
          const Divider(),
          ListTile(
            title: const Text("Damaged vehicle offense"),
            trailing: Text(
                "${offenseCounter.damagedVehicleCount} x $perOffencePushup"),
          ),
          const Divider(),
          ListTile(
            title: const Text("Car damage"),
            trailing: Text(
                "${offenseCounter.carDamageSum}% x 100 x $perOffencePushup"),
          ),
          const Divider(),
          ListTile(
            title: const Text("Trailer damage"),
            trailing: Text(
                "${offenseCounter.trailerDamageSum}% x 100 x $perOffencePushup"),
          ),
          const Divider(),
          ListTile(
            title:
                const Text("Lower than $compensationThreashold compensation"),
            trailing: Text(offenseCounter.compensation.toString()),
          ),
          const Divider(),
          ListTile(
            title: const Text(
              "Sum",
              style: TextStyle(fontSize: 30),
            ),
            trailing: Text(
              offenseCounter.sumPushup.toString(),
              style: const TextStyle(fontSize: 30),
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MaterialButton(
              color: Colors.blue,
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const WaitForPresser()));
              },
              child: const Text("Next"),
            ),
          )
        ],
      ),
    );
  }
}
