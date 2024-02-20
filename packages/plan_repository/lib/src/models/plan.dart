import 'package:area_repository/area_repository.dart';

class MyPlan {
  String area = "";
  String startDate = "";
  String endDate = "";
  String budget = "";
  String startTime = "";
  String endTime = "";
  List<Place> places = [];

  MyPlan();
  MyPlan.withData(
      {required this.area,
      required this.startDate,
      required this.endDate,
      required this.budget,
      required this.startTime,
      required this.endTime,
      required this.places});
}
