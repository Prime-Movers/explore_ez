import 'package:area_repository/area_repository.dart';
import 'package:plan_repository/plan_repository.dart';

abstract class PlanRepo {
  Future<void> getArea(MyArea area);
  Future<void> getDetails(String beginJourney, String endJourney, String budget,
      String dailyBeginTime, String dailyEndTime);
  List<Place> fetchPlaces();

  Future<void> getPlaces(List<Place> places);

  MyPlan getPlan();
}
