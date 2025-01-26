import 'package:flutter/material.dart';
import 'meditation_session_page.dart';

class MeditationDayPage extends StatelessWidget {
  final int day;
  final List<Map<String, dynamic>> meditationPlan;
  final VoidCallback onMeditationCompleted;

  MeditationDayPage({required this.day, required this.meditationPlan, required this.onMeditationCompleted});

  @override
  Widget build(BuildContext context) {
    final dayData = meditationPlan.firstWhere((plan) => plan['day'] == day);

    if (dayData['isRestDay']) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Day $day - Rest Day'),
          backgroundColor: Colors.black,
        ),
        body: Center(
          child: Text(
            'Enjoy your rest day!',
            style: const TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
        backgroundColor: Colors.black,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Day $day'),
        backgroundColor: Colors.teal,
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Two columns
                  crossAxisSpacing: 16.0, // Spacing between columns
                  mainAxisSpacing: 16.0, // Spacing between rows
                  childAspectRatio: 1.2, // Adjust the aspect ratio for better tile size
                ),
                itemCount: dayData['exercises'].length,
                itemBuilder: (context, index) {
                  final exercise = dayData['exercises'][index];
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            exercise['name'],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '${exercise['duration']} seconds',
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                textStyle: const TextStyle(fontSize: 21),
              ),
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MeditationSessionPage(
                      day: day,
                      meditationPlan: dayData['exercises'],
                    ),
                  ),
                );
                onMeditationCompleted();
              },
              child: const Text(
                'Start Meditation',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.grey[200], // Light background for better contrast
    );
  }
}