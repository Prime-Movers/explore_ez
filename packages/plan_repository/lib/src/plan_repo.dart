import 'package:area_repository/area_repository.dart';
import 'package:plan_repository/plan_repository.dart';

abstract class PlanRepo {
  Future<List<List<DayPlan>>> getPlan(MyPlan plan);
  List<MarkPoint> getPoints(
      List<DayPlan> dayPlan, List<Place> places, String areaName);
  MarkPoint getCurrentPoint(Place place);
}
