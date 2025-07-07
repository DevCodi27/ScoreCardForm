import 'package:flutter/material.dart';
import 'package:forms/provider/scorecard_provider.dart';
import 'package:forms/screen/form_screen.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ChangeNotifierProvider(create: (_) => ScorecardProvider(), child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: ScoreForm(), debugShowCheckedModeBanner: false);
  }
}
