import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WaterTrackerPage extends StatefulWidget {
  @override
  _WaterTrackerPageState createState() => _WaterTrackerPageState();
}

class _WaterTrackerPageState extends State<WaterTrackerPage> {
  int waterIntake = 0; // Number of glasses for today
  int dailyGoal = 8; // Default daily goal
  List<Map<String, dynamic>> waterHistory = []; // Past 7 days
  late SharedPreferences _prefs;

  @override
  void initState() {
    super.initState();
    _loadWaterData();
  }

  Future<void> _loadWaterData() async {
    _prefs = await SharedPreferences.getInstance();

    dailyGoal = _prefs.getInt('dailyGoal') ?? 8;

    final today = DateTime.now();
    final todayKey = _getDateKey(today);
    waterIntake = _prefs.getInt(todayKey) ?? 0;

    final historyKeys = _prefs.getKeys().where((key) => key.startsWith('water_')).toList();
    historyKeys.sort((a, b) => b.compareTo(a)); // Sort by date in descending order

    waterHistory = historyKeys.take(7).map((key) {
      final date = DateTime.parse(key.replaceFirst('water_', ''));
      final intake = _prefs.getInt(key) ?? 0;
      return {'date': date, 'intake': intake};
    }).toList();
  }

  Future<void> _updateTodayData() async {
    final today = DateTime.now();
    final todayKey = _getDateKey(today);
    await _prefs.setInt(todayKey, waterIntake);

    if (waterIntake >= dailyGoal) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Congratulations! You\'ve reached your daily goal of $dailyGoal glasses.'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  Future<void> _updateDailyGoal() async {
    await _prefs.setInt('dailyGoal', dailyGoal);
  }

  void _incrementWaterIntake() {
    setState(() {
      waterIntake++;
    });
    _updateTodayData();
  }

  void _resetWaterIntake() {
    setState(() {
      waterIntake = 0;
    });
    _updateTodayData();
  }

  String _getDateKey(DateTime date) {
    return 'water_${date.year}-${date.month}-${date.day}';
  }

  Widget _buildHistoryTile(Map<String, dynamic> entry) {
    final date = entry['date'];
    final intake = entry['intake'];
    return ListTile(
      title: Text('${date.day}/${date.month}/${date.year}'),
      trailing: Text('$intake glasses'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Water Tracker',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Column(
          children: [
            const Text(
              'Track Your Daily Water Intake',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Text(
              'Daily Goal: $dailyGoal glasses',
              style: const TextStyle(
                fontSize: 18,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final newGoal = await _showSetGoalDialog();
                if (newGoal != null) {
                  setState(() {
                    dailyGoal = newGoal;
                  });
                  _updateDailyGoal();
                }
              },
              child: const Text('Set Daily Goal'),
            ),
            const SizedBox(height: 20),
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.blue[100],
                    shape: BoxShape.circle,
                  ),
                ),
                Text(
                  '$waterIntake',
                  style: const TextStyle(
                    fontSize: 72,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Text(
              'Glasses of Water',
              style: TextStyle(
                fontSize: 18,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _incrementWaterIntake,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    backgroundColor: Colors.blueAccent,
                  ),
                  child: const Text(
                    'Add Glass',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                ElevatedButton(
                  onPressed: _resetWaterIntake,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    backgroundColor: Colors.redAccent,
                  ),
                  child: const Text(
                    'Reset',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Divider(),
            const Text(
              'Last 7 Days',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: waterHistory.length,
              itemBuilder: (context, index) {
                return _buildHistoryTile(waterHistory[index]);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<int?> _showSetGoalDialog() {
    final goalController = TextEditingController(text: dailyGoal.toString());
    return showDialog<int>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Set Daily Water Goal'),
          content: TextField(
            controller: goalController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(hintText: 'Enter goal in glasses'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final newGoal = int.tryParse(goalController.text);
                Navigator.pop(context, newGoal);
              },
              child: const Text('Set'),
            ),
          ],
        );
      },
    );
  }
}