import 'dart:convert';

import 'package:plan_repository/src/function.dart';
import 'package:plan_repository/src/models/plan.dart';
import 'package:plan_repository/src/plan_repo.dart';

class ModelPlanRepo implements PlanRepo {
  @override
  String getPlan(MyPlan plan) {
    var data;
    String days =
        daysBetween(plan.startDate as DateTime, plan.endDate as DateTime)
            as String;
    String value = days + "," + plan.area as String;
    String url = 'http://10.0.2.2:5000/api?query=' + value;
    return "Hello there";
  }

  int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }
}
