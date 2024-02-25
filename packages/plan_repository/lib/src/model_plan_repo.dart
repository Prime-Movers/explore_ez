import 'dart:convert';

import 'package:plan_repository/src/function.dart';
import 'package:plan_repository/src/models/plan.dart';
import 'package:plan_repository/src/plan_repo.dart';

class ModelPlanRepo implements PlanRepo {
  String url = "";
  var data;
  String output = "";
  @override
  String getPlan(MyPlan plan) {
    int days =
        daysBetween(plan.startDate as DateTime, plan.endDate as DateTime);
    List value1 = plan.places;
    String value = value1.join(",");
    value += "$days";
    // String value = days + "," + plan.area as String;
    url = 'http://10.0.2.2:5000/api?query=' + value;
    String ans = getdata(url) as String;
    return ans;
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
