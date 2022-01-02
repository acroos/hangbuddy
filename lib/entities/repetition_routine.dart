class RepetitionRoutine {
  final String name;
  final int hangTime;
  final int restTime;
  final int repetitions;

  RepetitionRoutine(
      {required this.name,
      required this.hangTime,
      required this.restTime,
      required this.repetitions});

  String prettyTotalTime() {
    var totalTime = (hangTime + restTime) * repetitions;
    if (totalTime < 60) {
      return "${totalTime}s";
    }

    var minutes = totalTime ~/ 60;
    var seconds = totalTime - (minutes * 60);
    return "${minutes}m${seconds}s";
  }

  Map<String, dynamic> toJSONEncodable() {
    return {
      'name': name,
      'hangTime': hangTime,
      'restTime': restTime,
      'repetitions': repetitions
    };
  }

  factory RepetitionRoutine.fromJson(Map<String, dynamic> json) {
    return RepetitionRoutine(
        name: json['name'],
        hangTime: json['hangTime'],
        restTime: json['restTime'],
        repetitions: json['repetitions']);
  }
}
