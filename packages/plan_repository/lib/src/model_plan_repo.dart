import 'package:plan_repository/src/models/plan.dart';
import 'package:plan_repository/src/plan_repo.dart';

class ModelPlanRepo implements PlanRepo {
  @override
  String getPlan(MyPlan plan) {
    return "Hello there";
  }
}
