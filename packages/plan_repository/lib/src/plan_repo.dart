import 'package:plan_repository/plan_repository.dart';

abstract class PlanRepo {
  Future<String> getPlan(MyPlan plan);
}
