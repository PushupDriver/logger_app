const int compensationThreashold = 100;
const int perOffencePushup = 10;
const int perDamagePushup = 10;

class OffenseCounter {
  int wrongWayOffenseCount = 0;
  int headlightUsageOffenseCount = 0;
  int notRestingOffenseCount = 0;
  int redLightOffenseCount = 0;
  int collidingWithCarCount = 0;
  int speedingCount = 0;
  int failedToStopAtWeightStationCount = 0;
  int illegalTrailerCount = 0;
  int damagedVehicleCount = 0;

  int _carDamage = 0;

  int get carDamage => _carDamage;
  set carDamage(int value) {
    _carDamage = value;
    if (_carDamage > 100) {
      _carDamage = 100;
    } else if (_carDamage < 0) {
      _carDamage = 0;
    }
  }

  int _trailerDamage = 0;
  int get trailerDamage => _trailerDamage;
  set trailerDamage(int value) {
    _trailerDamage = value;
    if (_trailerDamage > 100) {
      _trailerDamage = 100;
    } else if (_trailerDamage < 0) {
      _trailerDamage = 0;
    }
  }

  int finishedPushup = 0;

  void repair() {
    if (carDamage != 0) {
      carDamages.add(carDamage);
    }
    if (trailerDamage != 0) {
      trailerDamages.add(trailerDamage);
    }
    carDamage = 0;
    trailerDamage = 0;
  }

  int serviceCalled = 0;
  void callService() {
    serviceCalled += 1;
  }

  List<int> carDamages = [];
  List<int> trailerDamages = [];

  int get carDamageSum =>
      carDamages.fold(0, (previous, current) => previous + current) + carDamage;

  int get trailerDamageSum =>
      trailerDamages.fold(0, (previous, current) => previous + current) +
      trailerDamage;

  int get preCompensateCountSum {
    return wrongWayOffenseCount +
        headlightUsageOffenseCount +
        notRestingOffenseCount +
        redLightOffenseCount +
        collidingWithCarCount +
        speedingCount +
        failedToStopAtWeightStationCount +
        illegalTrailerCount +
        damagedVehicleCount;
  }

  int get compensation {
    if (preCompensateCountSum * perOffencePushup +
            (carDamageSum + trailerDamageSum) * perDamagePushup <
        compensationThreashold) {
      return compensationThreashold;
    }
    return 0;
  }

  int get sumPushup =>
      preCompensateCountSum * perOffencePushup +
      (carDamageSum + trailerDamageSum) * perDamagePushup +
      compensation +
      serviceCalled * 50;
}
