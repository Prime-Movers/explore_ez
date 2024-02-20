import 'package:area_repository/area_repository.dart';

class MyPlan {
  MyArea area;
  String beginJourney;
  String endJourney;
  String budget;
  String dailyBeginTime;
  String dailyEndTime;
  List<Place> places;
  MyPlan(
      {required this.area,
      required this.beginJourney,
      required this.endJourney,
      required this.budget,
      required this.dailyBeginTime,
      required this.dailyEndTime,
      required this.places});

  getPlanDetails(String beginJourney, String endJourney, String budget,
      String dailyBeginTime, String dailyEndTime) {
    this.beginJourney = beginJourney;
    this.endJourney = endJourney;
    this.budget = budget;
    this.dailyBeginTime = dailyBeginTime;
    this.dailyEndTime = dailyEndTime;
  }

  getPlanPlaces(List<Place> places) {
    this.places = places;
  }
}
