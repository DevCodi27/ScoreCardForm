import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:forms/pdf/pdf_download.dart';
import 'package:forms/provider/scorecard_provider.dart';
import 'package:forms/widgets/text_field.dart';
import 'package:http/http.dart' as http show post;
import 'package:intl/intl.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:provider/provider.dart';

class ScoreCardForm extends StatefulWidget {
  const ScoreCardForm({super.key});

  @override
  State<ScoreCardForm> createState() => _ScoreCardFormState();
}

class _ScoreCardFormState extends State<ScoreCardForm> {
  final _dateController = TextEditingController();
  final _inspectionController = TextEditingController();
  final formkey = GlobalKey<FormState>();

  @override
  void dispose() {
    _dateController.dispose();
    _inspectionController.dispose();
    super.dispose();
  }

  Future<bool> submitForm(Map<String, dynamic> data) async {
    try {
      final response = await http.post(
        Uri.parse("https://httpbin.org/post"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );
      if (response.statusCode == 200) {
        print("Submission successful");
        return true;
      } else {
        print("Submission failed");
        return false;
      }
    } catch (e) {
      print("Error submitting form: $e");
      return false;
    }
  }

  void generateScorecardPdf(Map<String, dynamic> data) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        build: (context) => [
          pw.Text("Train Scorecard", style: pw.TextStyle(fontSize: 24)),
          pw.SizedBox(height: 10),
          pw.Text("WO No: ${data['wo_no']}"),
          pw.Text("Contractor: ${data['constructorName']}"),
          pw.Text("Date: ${data['date']}"),
          pw.Text("Supervisor: ${data['supervisorName']}"),
          pw.Text("Date of Inspection: ${data['inspectionDate']}"),
          pw.Text("Train No: ${data['trainNo']}"),
          pw.Text("Arrival Time: ${data['arrivalTime']}"),
          pw.Text("Departure Time: ${data['departureTime']}"),
          pw.Text("No of Coach: ${data['coachesAttended']}"),
          pw.Text("Total No of Coach: ${data['totalCoaches']}"),

          pw.SizedBox(height: 20),

          pw.Text("Scores:", style: pw.TextStyle(fontSize: 18)),
          pw.Table.fromTextArray(
            context: context,
            headers: List<String>.generate(13, (i) => "C${i + 1}"),
            data: data['scores']
                .map<List<String>>(
                  (entry) => List<String>.from(entry['scores']),
                )
                .toList(),
          ),
        ],
      ),
    );

    await downloadPdf(pdf);
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ScorecardProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white60,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Text("Train Score Card"),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: 0.1,
              child: Image.asset(
                "assets/images/application.png",
                fit: BoxFit.fill,
                alignment: Alignment.center,
              ),
            ),
          ),
          SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "General Info",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  verticalgap(),
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextField(
                          "W.No",
                          (val) => provider.scorecard.woNo = val,
                          initialValue: provider.scorecard.woNo,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: TextFormField(
                          controller: _dateController,
                          readOnly: true,
                          decoration: InputDecoration(
                            labelText: "Date",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(0),
                            ),
                          ),
                          onTap: () async {
                            final pickDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2100),
                            );
                            if (pickDate != null) {
                              _dateController.text = DateFormat(
                                'dd/MM/yyyy',
                              ).format(pickDate);
                              provider.scorecard.Date = pickDate;
                            }
                          },
                          validator: (value) => value == null || value.isEmpty
                              ? 'Date is required'
                              : null,
                        ),
                      ),
                    ],
                  ),
                  verticalgap(),
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextField(
                          "Name of Work",
                          (val) => provider.scorecard.workName = val,
                          initialValue: provider.scorecard.workName,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: CustomTextField(
                          "Name of Contractor",
                          (val) => provider.scorecard.constructorName = val,
                          initialValue: provider.scorecard.constructorName,
                        ),
                      ),
                    ],
                  ),
                  verticalgap(),
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextField(
                          "Name of Supervisor",
                          (val) => provider.scorecard.supervisorName = val,
                          initialValue: provider.scorecard.supervisorName,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: CustomTextField(
                          "Designation",
                          (val) => provider.scorecard.designation = val,
                          initialValue: provider.scorecard.designation,
                        ),
                      ),
                    ],
                  ),
                  verticalgap(),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _inspectionController,
                          readOnly: true,
                          decoration: InputDecoration(
                            labelText: "Date of Inspection",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(0),
                            ),
                          ),
                          onTap: () async {
                            final pickDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2100),
                            );
                            if (pickDate != null) {
                              _inspectionController.text = DateFormat(
                                'dd/MM/yyyy',
                              ).format(pickDate);
                              provider.scorecard.inspectionDate = pickDate;
                            }
                          },
                          validator: (value) => value == null || value.isEmpty
                              ? 'Date of Inspection is required'
                              : null,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: CustomTextField(
                          "Arrival Time",
                          (val) => provider.scorecard.arrivalTime = val,
                          initialValue: provider.scorecard.arrivalTime,
                        ),
                      ),
                    ],
                  ),
                  verticalgap(),
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextField(
                          "Departure Time",
                          (val) => provider.scorecard.departureTime = val,
                          initialValue: provider.scorecard.departureTime,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: CustomTextField(
                          "Number of coach attended by contractor",
                          (val) => provider.scorecard.coachAttendance =
                              int.tryParse(val) ?? 0,
                          initialValue: provider.scorecard.coachAttendance
                              .toString(),
                        ),
                      ),
                    ],
                  ),
                  verticalgap(),
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextField(
                          "Total No of coach",
                          (val) => provider.scorecard.totalCoach =
                              int.tryParse(val) ?? 0,
                          initialValue: provider.scorecard.totalCoach
                              .toString(),
                        ),
                      ),
                    ],
                  ),
                  verticalgap(),
                  const ScoreTable(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          if (formkey.currentState!.validate()) {
                            formkey.currentState!.save();
                            final data = provider.toJson();
                            final ans = await submitForm(data);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  ans
                                      ? "Submitted successfully"
                                      : "Failed to submit",
                                ),
                                backgroundColor: ans
                                    ? Colors.green
                                    : Colors.red,
                              ),
                            );
                          }
                        },
                        child: Text("Submit"),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (formkey.currentState!.validate()) {
                            formkey.currentState!.save();
                            final json = provider.toJson();
                            generateScorecardPdf(json);
                          }
                        },
                        child: Text("Export as PDF"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ScoreTable extends StatelessWidget {
  const ScoreTable({super.key});

  final List<String> coachColumns = const [
    'C1',
    'C2',
    'C3',
    'C4',
    'C5',
    'C6',
    'C7',
    'C8',
    'C9',
    'C10',
    'C11',
    'C12',
    'C13',
  ];

  final List<String> options = const ['0', '1', 'X', '-'];

  final List<String> tasks = const [
    'Toilet Cleaning - T1',
    'Toilet Cleaning - T2',
    'Toilet Cleaning - T3',
    'Toilet Cleaning - T4',
    'Wash Basin - B1',
    'Doorway Area - B2',
    'Footsteps - D1',
    'Waste Disposal - AC Bin',
  ];

  @override
  Widget build(BuildContext context) {
    final p = Provider.of<ScorecardProvider>(context);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columnSpacing: 20,
        columns: [
          const DataColumn(label: Text('Task')),
          ...coachColumns.map((c) => DataColumn(label: Text(c))),
        ],
        rows: List.generate(tasks.length, (taskIndex) {
          return DataRow(
            cells: [
              DataCell(Text(tasks[taskIndex])),
              ...List.generate(coachColumns.length, (coachIndex) {
                String currentValue =
                    p.scorecard.scoreentries[taskIndex].scores[coachIndex];

                return DataCell(
                  DropdownButton<String>(
                    value: currentValue,
                    underline: Container(),
                    items: options.map((opt) {
                      return DropdownMenuItem(value: opt, child: Text(opt));
                    }).toList(),
                    onChanged: (val) {
                      if (val != null) {
                        p.updateScore(taskIndex, coachIndex, val);
                      }
                    },
                  ),
                );
              }),
            ],
          );
        }),
      ),
    );
  }
}
