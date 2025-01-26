import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/workout_plan_generator.dart';
import 'workout_day_page.dart';

class WorkoutOverviewPage extends StatefulWidget {
  @override
  _WorkoutOverviewPageState createState() => _WorkoutOverviewPageState();
}

class _WorkoutOverviewPageState extends State<WorkoutOverviewPage> {
  final List<Map<String, dynamic>> workoutPlan = generateWorkoutPlan();
  Set<int> completedDays = {};

  @override
  void initState() {
    super.initState();
    _loadCompletedDays();
  }

  Future<void> _loadCompletedDays() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      completedDays = (prefs.getStringList('completedDays') ?? [])
          .map((day) => int.parse(day))
          .toSet();
    });
  }

  Future<void> _markDayAsCompleted(int day) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      completedDays.add(day);
      prefs.setStringList('completedDays', completedDays.map((d) => d.toString()).toList());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Workout Plan', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.deepPurple,
      ),
      backgroundColor: Colors.black,
      body: ListView.builder(
        itemCount: workoutPlan.length,
        itemBuilder: (context, index) {
          final dayData = workoutPlan[index];
          final isCompleted = completedDays.contains(dayData['day']);
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: isCompleted ? Colors.green.withOpacity(0.3) : Colors.white,
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
                  color: isCompleted ? Colors.green : Colors.black,
                ),
              ),
              subtitle: dayData['isRestDay']
                  ? null
                  : Text(
                '${dayData['exercises'].length} exercises',
                style: TextStyle(color: Colors.grey[700]),
              ),
              trailing: Icon(
                dayData['isRestDay'] ? Icons.hotel : Icons.fitness_center,
                color: dayData['isRestDay'] ? Colors.blueGrey : Colors.green,
              ),
              onTap: dayData['isRestDay']
                  ? null
                  : () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WorkoutDayPage(
                      day: dayData['day'],
                      workoutPlan: workoutPlan,
                      onWorkoutCompleted: () => _markDayAsCompleted(dayData['day']),
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