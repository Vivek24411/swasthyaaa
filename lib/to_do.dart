import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';  // To format and compare dates

class ToDoPage extends StatefulWidget {
  @override
  _ToDoPageState createState() => _ToDoPageState();
}

class _ToDoPageState extends State<ToDoPage> {
  bool isExerciseDone = false;
  bool isYogaDone = false;
  bool isWaterDone = false;
  String lastUpdatedDate = "";

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  _loadTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String storedDate = prefs.getString('lastUpdatedDate') ?? "";


    String currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

    if (storedDate != currentDate) {
      setState(() {
        isExerciseDone = false;
        isYogaDone = false;
        isWaterDone = false;
        lastUpdatedDate = currentDate;
      });

      prefs.setString('lastUpdatedDate', currentDate);
      prefs.setBool('isExerciseDone', false);
      prefs.setBool('isYogaDone', false);
      prefs.setBool('isWaterDone', false);
    } else {
      setState(() {
        isExerciseDone = prefs.getBool('isExerciseDone') ?? false;
        isYogaDone = prefs.getBool('isYogaDone') ?? false;
        isWaterDone = prefs.getBool('isWaterDone') ?? false;
        lastUpdatedDate = storedDate;
      });
    }
  }

  _saveTaskStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isExerciseDone', isExerciseDone);
    prefs.setBool('isYogaDone', isYogaDone);
    prefs.setBool('isWaterDone', isWaterDone);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Tasks'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Mark your daily tasks as complete!',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            _buildTaskTile('Exercise', isExerciseDone, (value) {
              setState(() {
                isExerciseDone = value!;
                _saveTaskStatus();
              });
            }),
            _buildTaskTile('Yoga', isYogaDone, (value) {
              setState(() {
                isYogaDone = value!;
                _saveTaskStatus();
              });
            }),
            _buildTaskTile('Drink Water', isWaterDone, (value) {
              setState(() {
                isWaterDone = value!;
                _saveTaskStatus();
              });
            }),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
              },
              child: const Text('Save Progress'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 12),
                textStyle: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTaskTile(String taskName, bool isTaskDone, ValueChanged<bool?> onChanged) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        title: Text(
          taskName,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        trailing: Checkbox(
          value: isTaskDone,
          onChanged: onChanged,
        ),
      ),
    );
  }
}
