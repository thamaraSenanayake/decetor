class Converter {
  String questionNumber(int number) {
    return number >= 10 ? "$number" : "0$number";
  }
}
