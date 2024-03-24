import 'dart:developer';
import 'package:area_repository/area_repository.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:plan_repository/plan_repository.dart';

class ModelPlanRepo implements PlanRepo {
  String url = "http://10.0.2.2:5000/";

  @override
  Future<List<List<DayPlan>>> getPlan(MyPlan plan) async {
    String value = "";
    int days = 1;
    try {
      days = calculateDays(plan.startDate, plan.endDate);
      value += "$days" ",";
      value += "${plan.startTime}-${plan.endTime}time fram per day,";
      value += "${plan.budget}total budget for trip,";
      value +=
          "${plan.accomodation.latitude!},${plan.accomodation.longitude!},";
      for (int i = 0; i < plan.places.length - 1; i++) {
        value += "${plan.places[i].placeName} chennai, ";
      }
      value += "${plan.places[plan.places.length - 1].placeName} chennai";
      //url = "https://musical-easily-yak.ngrok-free.app/?query=" + value;
      url += '?query=$value';
      //url = 'https://planz.vercel.app/?query=$value';
      //url ="https://presumably-welcomed-giraffe.ngrok-free.app/?query=" + value;
      //url = "https://endlessly-wise-chigger.ngrok-free.app/?query=" + value;

      final String ans = await getdata(url);

      List<DayPlan> dayPlanData = getDayPlanData(ans);
      log(dayPlanData.toString());

      return getDayPlans(dayPlanData);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  List<MarkPoint> getPoints(
      List<DayPlan> dayPlan, List<Place> selectedPlaces, String areaName) {
    List<MarkPoint> points = [];
    List<String> places = planPlaces(dayPlan, areaName);
    log(selectedPlaces.first.placeName);
    for (int i = 0; i < places.length; i++) {
      log(places[i]);
      Place? found = selectedPlaces.firstWhere((element) =>
          element.placeName.toLowerCase() == places[i].toLowerCase());
      points.add(MarkPoint(
          name: places[i],
          coordinates: LatLng(double.parse(found.latitude ?? ""),
              double.parse(found.longitude ?? ""))));
    }
    return points;
  }

  @override
  MarkPoint getCurrentPoint(Place place) {
    return MarkPoint(
        name: place.placeName,
        coordinates: LatLng(double.parse(place.latitude ?? ""),
            double.parse(place.longitude ?? "")));
  }
}
