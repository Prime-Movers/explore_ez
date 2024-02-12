import 'package:area_repository/area_repository.dart';

class MyPlan {
  String? areaName;
  DateTime? beginJourney;
  DateTime? endJourney;
  int? budget;
  String? accomodation;
  String? dailyBeginTime;
  String? dailyEndTime;
  List<Place>? places;

  MyPlan({this.areaName});

  getPlanDetails(DateTime beginJourney, DateTime endJourney, int budget,
      String accomodation, String dailyBeginTime, String dailyEndTime) {
    this.beginJourney = beginJourney;
    this.endJourney = endJourney;
    this.budget = budget;
    this.accomodation = accomodation;
    this.dailyBeginTime = dailyBeginTime;
    this.dailyEndTime = dailyEndTime;
  }

  getPlanPlaces(List<Place> places) {
    this.places = places;
  }
}
