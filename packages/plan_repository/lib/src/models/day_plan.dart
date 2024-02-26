import 'package:plan_repository/plan_repository.dart';

class DayPlan {
  final String day;
  final String placeName;
  final String timeSlot;
  final String entryFee;
  final String distFromPrevLoc;
  final String travelTime;
  DayPlan(
      {required this.day,
      required this.placeName,
      required this.timeSlot,
      required this.entryFee,
      required this.distFromPrevLoc,
      required this.travelTime});

  static DayPlan fromEntity(DayPlanEntity entity) {
    return DayPlan(
        day: entity.day,
        placeName: entity.placeName,
        timeSlot: entity.timeSlot,
        entryFee: entity.entryFee,
        distFromPrevLoc: entity.distFromPrevLoc,
        travelTime: entity.travelTime);
  }
}
