import 'package:hangbuddy/entities/repetition_routine.dart';

class RoutineList {
  List<RepetitionRoutine> routines = <RepetitionRoutine>[];

  List<Map<String, dynamic>> toJSONEncodable() {
    return routines.map((e) => e.toJSONEncodable()).toList();
  }
}
