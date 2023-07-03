const int compensationThreashold = 100;

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

  int get sum => (wrongWayOffenseCount +
      headlightUsageOffenseCount +
      notRestingOffenseCount +
      redLightOffenseCount +
      collidingWithCarCount +
      speedingCount +
      failedToStopAtWeightStationCount +
      illegalTrailerCount +
      damagedVehicleCount +
      carDamage);

  int get compensation {
    if (sum < compensationThreashold) {
      return compensationThreashold;
    }
    return 0;
  }

  int sumPushup(int perOffensePushup) {
    return sum * perOffensePushup + compensation;
  }
}
