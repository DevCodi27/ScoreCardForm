class ScoreCard {
  String woNo;
  DateTime Date;
  String workName;
  String constructorName;
  String supervisorName;
  String designation;
  DateTime inspectionDate;
  String trainNo;
  String arrivalTime;
  String departureTime;
  int coachAttendance;
  int totalCoach;
  List<ScoreEntries> scoreentries;
  ScoreCard({
    required this.woNo,
    required this.Date,
    required this.workName,
    required this.constructorName,
    required this.supervisorName,
    required this.designation,
    required this.inspectionDate,
    required this.trainNo,
    required this.arrivalTime,
    required this.departureTime,
    required this.coachAttendance,
    required this.totalCoach,
    required this.scoreentries,
  });
}

class ScoreEntries {
  List<String> scores;
  ScoreEntries({required this.scores});
}
