import 'dart:developer';
import 'package:area_repository/area_repository.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:plan_repository/plan_repository.dart';

class ModelPlanRepo implements PlanRepo {
  String url = "http://127.0.0.1:5000/";

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
      // url += '?query=$value';
      url = 'https://planz.vercel.app/?query=$value';
      //url ="https://presumably-welcomed-giraffe.ngrok-free.app/?query=" + value;
      //url = "https://endlessly-wise-chigger.ngrok-free.app/?query=" + value;

      final String ans = await getdata(url);
      print(ans);
      List<DayPlan> dayPlanData = getDayPlanData(ans);
      log(dayPlanData.toString());

      return getDayPlans(dayPlanData);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  // Add this helper function at the top or in a utils file
  Place? findRelevantPlace(String query, List<Place> places) {
    query = query.trim().toLowerCase();

    // Exact match
    for (final place in places) {
      if (place.placeName.trim().toLowerCase() == query) {
        return place;
      }
    }

    // Partial match (query in place name)
    for (final place in places) {
      if (place.placeName.trim().toLowerCase().contains(query)) {
        return place;
      }
    }

    // Partial match (place name in query)
    for (final place in places) {
      if (query.contains(place.placeName.trim().toLowerCase())) {
        return place;
      }
    }

    // Fuzzy match: minimum Levenshtein distance
    int minDistance = 3; // You can adjust this threshold
    Place? bestMatch;
    for (final place in places) {
      int distance = _levenshtein(query, place.placeName.trim().toLowerCase());
      if (distance < minDistance) {
        minDistance = distance;
        bestMatch = place;
      }
    }
    return bestMatch;
  }

  // Levenshtein distance implementation
  int _levenshtein(String s, String t) {
    if (s == t) return 0;
    if (s.isEmpty) return t.length;
    if (t.isEmpty) return s.length;

    List<List<int>> matrix = List.generate(
      s.length + 1,
      (_) => List<int>.filled(t.length + 1, 0),
    );

    for (int i = 0; i <= s.length; i++) matrix[i][0] = i;
    for (int j = 0; j <= t.length; j++) matrix[0][j] = j;

    for (int i = 1; i <= s.length; i++) {
      for (int j = 1; j <= t.length; j++) {
        int cost = s[i - 1] == t[j - 1] ? 0 : 1;
        matrix[i][j] = [
          matrix[i - 1][j] + 1,
          matrix[i][j - 1] + 1,
          matrix[i - 1][j - 1] + cost,
        ].reduce((a, b) => a < b ? a : b);
      }
    }
    return matrix[s.length][t.length];
  }

  @override
  List<MarkPoint> getPoints(
      List<DayPlan> dayPlan, List<Place> selectedPlaces, String areaName) {
    List<MarkPoint> points = [];
    List<String> places = planPlaces(dayPlan, areaName);

    for (int i = 0; i < places.length; i++) {
      Place? found = findRelevantPlace(places[i], selectedPlaces);
      if (found != null && found.placeName.isNotEmpty) {
        points.add(MarkPoint(
          name: places[i],
          coordinates: LatLng(double.parse(found.latitude ?? "0"),
              double.parse(found.longitude ?? "0")),
        ));
      }
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
