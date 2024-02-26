import 'dart:convert';
import 'dart:developer';
import 'package:plan_repository/plan_repository.dart';

class ModelPlanRepo implements PlanRepo {
  String url = "";
  var data;
  String output = "";

  @override
  Future<List<DayPlan>> getPlan(MyPlan plan) async {
    String value = "";
    int days = 1;
    try {
      days = calculateDays(plan.startDate, plan.endDate);
      value += "$days" + ",";
      value += plan.startTime + "-" + plan.endTime + "time fram per day" + ",";
      value += plan.budget + "total budget for trip";
      for (int i = 0; i < plan.places.length - 1; i++) {
        value += plan.places[i].placeName + " " + "chennai" + "," + " ";
      }
      value += plan.places[plan.places.length - 1].placeName + " " + "chennai";
      url =
          "https://41ea-2405-201-e01b-1117-6577-935d-a1b8-4d5c.ngrok-free.app/?query=" +
              value;
      // url = 'http://10.0.2.2:5000/?query=' + value;
      final String ans = await getdata(url);

      List<DayPlan> dayPlanData = getDayPlanData(ans);
      log(dayPlanData.toString());

      return dayPlanData;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<String> getdata(String url) async {
    data = await fetchdata(url);
    var decoded = jsonDecode(data);
    output = decoded['output'];
    return output;
  }

  int calculateDays(String startDate, String endDate) {
    DateTime startDateTime = DateTime.parse(startDate);
    DateTime endDateTime = DateTime.parse(endDate);

    Duration difference = endDateTime.difference(startDateTime);
    return difference.inDays;
  }

  List<DayPlan> getDayPlanData(String val) {
    Map<String, dynamic> jsonData = json.decode(val);
    List<DayPlan> dayPlanData = [];
    jsonData.forEach((key, value) {
      dayPlanData.add(DayPlan.fromEntity(DayPlanEntity.fromDocument(value)));
    });
    return dayPlanData;
  }
}
