import 'dart:convert';

import 'package:plan_repository/plan_repository.dart';

import 'package:http/http.dart' as http;

fetchdata(String url) async {
  http.Response response = await http.get(Uri.parse(url));
  return response.body;
}

Future<String> getdata(String url) async {
  var data = await fetchdata(url);
  var decoded = jsonDecode(data);
  var output = decoded['output'];
  return output;
}

int calculateDays(String startDate, String endDate) {
  DateTime startDateTime = DateTime.parse(startDate);
  DateTime endDateTime = DateTime.parse(endDate);

  Duration difference = endDateTime.difference(startDateTime);
  return difference.inDays;
}

List<DayPlan> getDayPlanData(String val) {
  val = val.trim();
  if (val.trim().startsWith('```json')) {
    val = val.trim().substring(7).trim(); // Remove '```json'
  }
  // Remove trailing ``` if present
  if (val.endsWith('```')) {
    val = val.substring(0, val.length - 3).trim();
  }
  print(val);
  Map<String, dynamic> jsonData = json.decode(val);
  List<DayPlan> dayPlanData = [];
  jsonData.forEach((key, value) {
    dayPlanData.add(DayPlan.fromEntity(DayPlanEntity.fromDocument(value)));
  });
  return dayPlanData;
}

List<List<DayPlan>> getDayPlans(List<DayPlan> dayPlanData) {
  Map<String, List<DayPlan>> dayPlans = {};

  for (DayPlan dayPlan in dayPlanData) {
    final String day = dayPlan.day;
    if (dayPlans.containsKey(day)) {
      dayPlans[day]!.add(dayPlan);
    } else {
      dayPlans[day] = [dayPlan];
    }
  }

  return dayPlans.values.toList();
}

List<String> planPlaces(List<DayPlan> plan, String areaName) {
  List<String> places = [];

  for (int i = 0; i < plan.length; i++) {
    String place = plan[i].placeName;
    List<String> str = place.split(" ");

    if (str[str.length - 1].toLowerCase() == areaName.toLowerCase()) {
      String correct = "";
      for (int j = 0; j < str.length - 2; j++) {
        correct += "${str[j]} ";
      }
      correct += str[str.length - 2];
      places.add(correct);
    } else {
      places.add(place);
    }
  }
  return places;
}
