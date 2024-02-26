import 'dart:convert';
import 'dart:developer';
import 'package:plan_repository/src/function.dart';
import 'package:plan_repository/src/models/plan.dart';
import 'package:plan_repository/src/plan_repo.dart';

class ModelPlanRepo implements PlanRepo {
  String url = "";
  var data;
  String output = "";

  @override
  Future<String> getPlan(MyPlan plan) async {
    String value = "";
    int days = 1;
    try {
      days = calculateDays(plan.startDate, plan.endDate);
      value += "$days" + ",";
      // value += "$days" + ",";
      for (int i = 0; i < plan.places.length - 1; i++) {
        value += plan.places[i].placeName + " " + "chennai" + "," + " ";
      }
      value += plan.places[plan.places.length - 1].placeName + " " + "chennai";
      url =
          "https://d31e-2405-201-e01b-1117-20ce-674e-fb3e-ba5.ngrok-free.app/?query=" +
              value;
      // url = 'http://10.0.2.2:5000/?query=' + value;
      final String ans = await getdata(url);
      return ans;
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
}
