import 'package:flutter/material.dart';
import 'package:forms/model/scorecard.dart';

class ScorecardProvider with ChangeNotifier {
  ScoreCard scorecard = ScoreCard(
    woNo: '',
    Date: DateTime.now(),
    workName: '',
    constructorName: '',
    supervisorName: '',
    designation: '',
    trainNo: '',
    arrivalTime: '',
    departureTime: '',
    coachAttendance: 0,
    totalCoach: 13,
    inspectionDate: DateTime.now(),
    scoreentries: List.generate(
      8,
      (_) => ScoreEntries(scores: List.filled(13, '-')),
    ),
  );

  void updateGeneralInfo({
    String? woNo,
    DateTime? date,
    String? workName,
    String? constructorName,
    String? supervisorName,
    String? designation,
    String? trainNo,
    String? arrivalTime,
    String? departureTime,
    int? coachesAttended,
    int? totalCoaches,
    DateTime? inspectionDate,
  }) {
    if (woNo != null) scorecard.woNo = woNo;
    if (date != null) scorecard.Date = date;
    if (workName != null) scorecard.workName = workName;
    if (constructorName != null) scorecard.constructorName = constructorName;
    if (supervisorName != null) scorecard.supervisorName = supervisorName;
    if (designation != null) scorecard.designation = designation;
    if (trainNo != null) scorecard.trainNo = trainNo;
    if (arrivalTime != null) scorecard.arrivalTime = arrivalTime;
    if (departureTime != null) scorecard.departureTime = departureTime;
    if (coachesAttended != null) scorecard.coachAttendance = coachesAttended;
    if (totalCoaches != null) scorecard.totalCoach = totalCoaches;
    if (inspectionDate != null) scorecard.inspectionDate = inspectionDate;

    notifyListeners();
  }

  void updateScore(int taskIndex, int coachIndex, String score) {
    scorecard.scoreentries[taskIndex].scores[coachIndex] = score;
    notifyListeners();
  }

  // void updateRemark(String task, int coachIndex, String remark) {
  //   // find and update specific task remark
  //   notifyListeners();
  // }

  String getScore(int taskIndex, int coachIndex) {
    return scorecard.scoreentries[taskIndex].scores[coachIndex];
  }

  Map<String, dynamic> toJson() {
    return {
      "wo_no": scorecard.woNo,
      "date": scorecard.Date.toIso8601String(),
      "workName": scorecard.workName,
      "constructorName": scorecard.constructorName,
      "supervisorName": scorecard.supervisorName,
      "designation": scorecard.designation,
      "inspectionDate": scorecard.inspectionDate.toIso8601String(),
      "trainNo": scorecard.trainNo,
      "arrivalTime": scorecard.arrivalTime,
      "departureTime": scorecard.departureTime,
      "coachesAttended": scorecard.coachAttendance,
      "totalCoaches": scorecard.totalCoach,

      "scores": scorecard.scoreentries
          .map((entry) => {"scores": entry.scores})
          .toList(),
    };
  }
}
