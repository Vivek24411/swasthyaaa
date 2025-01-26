import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/yoga_plan_generator.dart';
import 'yoga_day_page.dart';

class YogaOverviewPage extends StatefulWidget {
  @override
  _YogaOverviewPageState createState() => _YogaOverviewPageState();
}

class _YogaOverviewPageState extends State<YogaOverviewPage> {
  final List<Map<String, dynamic>> yogaPlan = generateYogaPlan();
  Set<int> completedDays = {};

  @override
  void initState() {
    super.initState();
    _loadCompletedDays();
  }

  Future<void> _loadCompletedDays() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      completedDays = (prefs.getStringList('completedYogaDays') ?? [])
          .map((day) => int.parse(day))
          .toSet();
    });
  }

  Future<void> _markDayAsCompleted(int day) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      completedDays.add(day);
      prefs.setStringList('completedYogaDays', completedDays.map((d) => d.toString()).toList());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Yoga Plan', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.deepPurple,
      ),
      backgroundColor: Colors.black,
      body: ListView.builder(
        itemCount: yogaPlan.length,
        itemBuilder: (context, index) {
          final dayData = yogaPlan[index];
          final isCompleted = completedDays.contains(dayData['day']);
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: isCompleted ? Colors.deepPurple.withOpacity(0.3) : Colors.white,
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
                  color: isCompleted ? Colors.deepPurple : Colors.black,
                ),
              ),
              subtitle: dayData['isRestDay']
                  ? null
                  : Text(
                '${dayData['poses'].length} yoga poses',
                style: TextStyle(color: Colors.grey[700]),
              ),
              trailing: Icon(
                dayData['isRestDay'] ? Icons.hotel : Icons.spa,
                color: dayData['isRestDay'] ? Colors.blueGrey : Colors.green,
              ),
              onTap: dayData['isRestDay']
                  ? null
                  : () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => YogaDayPage(
                      day: dayData['day'],
                      yogaPlan: yogaPlan,
                      onYogaCompleted: () => _markDayAsCompleted(dayData['day']),
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