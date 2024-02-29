import 'package:plan_repository/plan_repository.dart';

abstract class PlanRepo {
  Future<List<List<DayPlan>>> getPlan(MyPlan plan);
}
