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
    String value = "2,";
    // int days =
    //     daysBetween(plan.startDate as DateTime, plan.endDate as DateTime);
    for (int i = 0; i < plan.places.length - 1; i++) {
      value += plan.places[i].placeName + " " + "chennai" + "," + " ";
    }
    value += plan.places[plan.places.length - 1].placeName + " " + "chennai";
    // String value1 = plan.places[0].placeName;
    // String value = value1.join(",");
    // value += "$days";
    // String value = days + "," + plan.area as String;
    url = 'http://10.0.2.2:5000/api?query=' + value;
    try {
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

  int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }
}
