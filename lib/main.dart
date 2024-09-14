import 'package:flutter/material.dart';
import 'package:mood_diary/widgets/MainPage.dart';
import 'package:mood_diary/widgets/MoodDiary.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MaterialApp(home: Main()));
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return  const MainPage();
  }
}