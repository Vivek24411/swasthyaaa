import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ActivityPage extends StatefulWidget {
  @override
  _ActivityPageState createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  late SharedPreferences _prefs;
  Map<String, int> workoutData = {};
  Map<String, int> yogaData = {};
  Map<String, int> meditationData = {};
  int workoutCount = 0;
  int yogaCount = 0;
  int meditationCount = 0;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      for (int i = 0; i < 7; i++) {
        DateTime date = DateTime.now().subtract(Duration(days: i));
        String dateKey = _getDateKey(date);

        workoutData[dateKey] = _prefs.getInt('workout_$dateKey') ?? 0;
        yogaData[dateKey] = _prefs.getInt('yoga_$dateKey') ?? 0;
        meditationData[dateKey] = _prefs.getInt('meditation_$dateKey') ?? 0;
      }

      workoutCount = _prefs.getInt('workout_count') ?? 0;
      yogaCount = _prefs.getInt('yoga_count') ?? 0;
      meditationCount = _prefs.getInt('meditation_count') ?? 0;
    });
  }

  String _getDateKey(DateTime date) {
    return '${date.year}-${date.month}-${date.day}';
  }

  Widget _buildActivityRow(String label, Map<String, int> data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(7, (index) {
            DateTime date = DateTime.now().subtract(Duration(days: index));
            String dateKey = _getDateKey(date);
            bool isActive = data[dateKey]! > 0;

            return Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: isActive ? Colors.blue : Colors.grey[300],
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  date.day.toString(),
                  style: TextStyle(
                    color: isActive ? Colors.white : Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          }).reversed.toList(),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildBadge(String label, int count, int milestone) {
    bool isUnlocked = count >= milestone;
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(
              isUnlocked ? Icons.verified : Icons.lock,
              color: isUnlocked ? Colors.green : Colors.grey,
            ),
            const SizedBox(width: 10),
            Text(
              '$label ($count/$milestone)',
              style: TextStyle(
                fontSize: 16,
                color: isUnlocked ? Colors.green : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Activity'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Last 7 Days Activity',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            _buildActivityRow('Workout', workoutData),
            _buildActivityRow('Yoga', yogaData),
            _buildActivityRow('Meditation', meditationData),
            const SizedBox(height: 20),
            Text(
              'Badges',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            _buildBadge('10 Workouts', workoutCount, 10),
            const SizedBox(height: 10),
            _buildBadge('10 Yoga Sessions', yogaCount, 10),
            const SizedBox(height: 10),
            _buildBadge('10 Meditation Sessions', meditationCount, 10),
          ],
        ),
      ),
    );
  }
}