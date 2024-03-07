import 'dart:math';

class GenerateNumber {
  int generateRandomNumber(int min, int max, List<int> excludedNumbers) {
    Random random = Random();
    int number;

    do {
      number = min + random.nextInt(max - min);
    } while (excludedNumbers.contains(number));

    return number;
  }
}
