import 'dart:math';

List<Map<String, dynamic>> generateMeditationPlan() {
  List<String> meditationExercises = [
    'Deep Breathing',
    'Body Scan',
    'Mindfulness',
    'Loving-Kindness',
    'Visualization',
    'Mantra Meditation',
    'Yoga Nidra',
    'Zen Meditation',
    'Chakra Meditation',
  ];

  List<Map<String, dynamic>> meditationPlan = [];
  for (int day = 1; day <= 30; day++) {
    if (day % 7 == 0) {
      meditationPlan.add({'day': day, 'exercises': [], 'isRestDay': true});
      continue;
    }

    int exerciseCount = min(4 + ((day - 1) ~/ 5), 9); // Gradually increase to 9 exercises
    int exerciseDuration = 60 + ((day - 1) ~/ 5) * 15; // Gradually increase to 120 seconds

    List<String> dailyExercises = meditationExercises.sublist(0, exerciseCount);

    List<Map<String, dynamic>> exercisesWithDetails = dailyExercises.map((exercise) {
      return {
        'name': exercise,
        'duration': exerciseDuration,
      };
    }).toList();

    meditationPlan.add({
      'day': day,
      'exercises': exercisesWithDetails,
      'isRestDay': false,
    });
  }
  return meditationPlan;
}