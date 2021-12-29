import 'package:hangbuddy/entities/repetition_routine.dart';

class RoutineList {
  List<RepetitionRoutine> routines = <RepetitionRoutine>[];

  List<Map<String, dynamic>> toJson() {
    return routines.map((e) => e.toJSONEncodable()).toList();
  }

  List<Map<String, dynamic>> toJSONEncodable() {
    return toJson();
  }
}
