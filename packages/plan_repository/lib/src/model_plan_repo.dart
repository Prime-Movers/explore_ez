import 'dart:developer';
import 'package:area_repository/area_repository.dart';
import 'package:plan_repository/src/models/plan.dart';
import 'package:plan_repository/src/plan_repo.dart';

class ModelPlanRepo implements PlanRepo {
  MyPlan plan = MyPlan(
      areaName: "",
      beginJourney: "",
      endJourney: "",
      budget: "",
      dailyBeginTime: "",
      dailyEndTime: "",
      places: []);
  @override
  Future<void> getArea(MyArea area) async {
    try {
      plan.areaName = area.areaName;
      plan.places = area.places;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> getDetails(String beginJourney, String endJourney, String budget,
      String dailyBeginTime, String dailyEndTime) async {
    try {
      plan.getPlanDetails(
          beginJourney, endJourney, budget, dailyBeginTime, dailyEndTime);
    } catch (e) {
      rethrow;
    }
  }

  @override
  List<Place> getPlaces() {
    try {
      return plan.places;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
