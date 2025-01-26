import 'package:flutter/material.dart';

class ExerciseTipsPage extends StatelessWidget {
  final List<String> tips = [
    "Warm up before every workout to prevent injuries.",
    "Cool down and stretch after exercising to promote recovery.",
    "Stay hydrated by drinking water before, during, and after workouts.",
    "Focus on proper form to avoid injuries.",
    "Incorporate strength training twice a week.",
    "Don't skip leg day—it builds a strong foundation.",
    "Add variety to your workouts to avoid plateaus.",
    "Rest and recover to let your muscles rebuild.",
    "Gradually increase intensity to avoid overexertion.",
    "Listen to your body and know your limits.",
    "Wear proper workout shoes to prevent strain.",
    "Include a mix of cardio, strength, and flexibility exercises.",
    "Set realistic goals and track your progress.",
    "Take short breaks during workouts when needed.",
    "Engage your core during exercises for better balance.",
    "Practice deep breathing to improve endurance.",
    "Keep your workouts consistent for long-term results.",
    "Avoid overtraining—give your body time to heal.",
    "Use a workout buddy for motivation and accountability.",
    "Incorporate exercises that you enjoy to stay committed.",
    "Fuel your body with nutritious meals for energy.",
    "Prioritize quality over quantity in your exercises.",
    "Challenge yourself with new workout routines.",
    "Use proper equipment for exercises to ensure safety.",
    "Schedule workouts at the same time daily for habit-building.",
    "Don't neglect mobility and stretching exercises.",
    "Focus on progressive overload to build strength.",
    "Get enough sleep to support your fitness goals.",
    "Celebrate your milestones to stay motivated.",
    "Make exercise a lifestyle, not a chore."
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Exercise Tips"),
        backgroundColor: Colors.teal,
      ),
      body: ListView.builder(
        itemCount: tips.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: Card(
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.teal.shade300, Colors.teal.shade700],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Text(
                          "${index + 1}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.teal,
                          ),
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          tips[index],
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
