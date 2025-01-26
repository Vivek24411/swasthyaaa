import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/meditation_plan_generator.dart';
import 'meditation_day_page.dart';

class MeditationOverviewPage extends StatefulWidget {
  @override
  _MeditationOverviewPageState createState() => _MeditationOverviewPageState();
}

class _MeditationOverviewPageState extends State<MeditationOverviewPage> {
  final List<Map<String, dynamic>> meditationPlan = generateMeditationPlan();
  Set<int> completedDays = {};

  @override
  void initState() {
    super.initState();
    _loadCompletedDays();
  }

  Future<void> _loadCompletedDays() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      completedDays = (prefs.getStringList('completedMeditationDays') ?? [])
          .map((day) => int.parse(day))
          .toSet();
    });
  }

  Future<void> _markDayAsCompleted(int day) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      completedDays.add(day);
      prefs.setStringList('completedMeditationDays', completedDays.map((d) => d.toString()).toList());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meditation Plan', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.teal,
      ),
      backgroundColor: Colors.black,
      body: ListView.builder(
        itemCount: meditationPlan.length,
        itemBuilder: (context, index) {
          final dayData = meditationPlan[index];
          final isCompleted = completedDays.contains(dayData['day']);
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: isCompleted ? Colors.teal.withOpacity(0.3) : Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(color: Colors.grey, blurRadius: 5, offset: Offset(0, 3)),
              ],
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              title: Text(
                dayData['isRestDay']
                    ? 'Day ${dayData['day']} - Rest Day'
                    : 'Day ${dayData['day']}',
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                  color: isCompleted ? Colors.teal : Colors.black,
                ),
              ),
              subtitle: dayData['isRestDay']
                  ? null
                  : Text(
                '${dayData['exercises'].length} exercises',
                style: TextStyle(color: Colors.grey[700]),
              ),
              trailing: Icon(
                dayData['isRestDay'] ? Icons.hotel : Icons.self_improvement,
                color: dayData['isRestDay'] ? Colors.blueGrey : Colors.teal,
              ),
              onTap: dayData['isRestDay']
                  ? null
                  : () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MeditationDayPage(
                      day: dayData['day'],
                      meditationPlan: meditationPlan,
                      onMeditationCompleted: () => _markDayAsCompleted(dayData['day']),
                    ),
                  ),
                );
                _loadCompletedDays();
              },
            ),
          );
        },
      ),
    );
  }
}