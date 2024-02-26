class DayPlanEntity {
  final String day;
  final String placeName;
  final String timeSlot;
  final String entryFee;
  final String distFromPrevLoc;
  final String travelTime;
  DayPlanEntity(
      {required this.day,
      required this.placeName,
      required this.timeSlot,
      required this.entryFee,
      required this.distFromPrevLoc,
      required this.travelTime});

  static DayPlanEntity fromDocument(String day, Map<String, dynamic> doc) {
    return DayPlanEntity(
        day: day,
        placeName: doc['place_name'],
        timeSlot: doc['time_slot'],
        entryFee: doc['entry_fee'],
        distFromPrevLoc: doc['distance_from_previous_location'],
        travelTime: doc['travel_time']);
  }
}
