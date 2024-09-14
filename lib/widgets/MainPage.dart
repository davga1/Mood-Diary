import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mood_diary/constants.dart';
import 'package:mood_diary/widgets/MoodDiary.dart';
import 'package:mood_diary/widgets/Statistics.dart';
import 'package:mood_diary/widgets/calendar.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {
  late final TabController _tabController;
  String _timeString = '00:00';

  void _updateTime() {
    setState(() {
      _timeString = _formatDateTime(DateTime.now());
    });
  }

  int index = 0;

  String _formatDateTime(DateTime dateTime) {
    return "${dateTime.day} ${months[dateTime.month]} ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";
  }

  @override
  void initState() {
    controller = TextEditingController();
    _timeString = _formatDateTime(DateTime.now());
    Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      _updateTime();
    });
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  final List<Widget> _tabs = [const MoodDiary(), const Statistics()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            _timeString,
            style: const TextStyle(color: Colors.grey),
          ),
          bottom: TabBar(
            indicatorColor: Colors.orange,
            dividerColor: Colors.transparent,
            labelColor: Colors.orange,
            tabs: const [
              Tab(
                icon: Row(
                  children: [Icon(Icons.book), Text('Дневник настроения')],
                ),
              ),
              Tab(
                icon: Row(
                  children: [Icon(Icons.bar_chart), Text('Статистика')],
                ),
              )
            ],
            controller: _tabController,
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => Calendar()));
                },
                icon: Icon(Icons.calendar_month))
          ],
        ),
        body: TabBarView(
          controller: _tabController,
          children: [_tabs[0], _tabs[1]],
        ));
  }
}
