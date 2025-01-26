import 'dart:math';
List<Map<String, dynamic>> generateWorkoutPlan() {
  List<String> timeBasedExercises = [
    'Jumping Jacks',
    'Plank',
    'Cobra Stretch',
    'Child Pose',
    'Skipping',
    'Burpees',
  ];
  List<String> countBasedExercises = [
    'Push Ups',
    'Reverse Crunches',
    'Abdominal Crunches',
    'Triceps Dips',
    'Lunges',
    'Wide Arm Pushups',
    'Diamond Pushups',
    'Arm Raise',
    'Knee Pushups',
  ];

  List<Map<String, dynamic>> workoutPlan = [];
  for (int day = 1; day <= 30; day++) {
    if (day % 7 == 0) {
      workoutPlan.add({'day': day, 'exercises': [], 'isRestDay': true});
      continue;
    }

    int exerciseCount = min(7 + ((day - 1) ~/ 5), 13);
    List<String> dailyExercises = ['Jumping Jacks'];

    List<String> remainingExercises = [
      ...timeBasedExercises,
      ...countBasedExercises
    ];
    remainingExercises.remove('Jumping Jacks');
    remainingExercises.remove('Cobra Stretch');

    remainingExercises.shuffle(Random(day));
    dailyExercises.addAll(remainingExercises.take(exerciseCount - 2));
    dailyExercises.add('Cobra Stretch');

    List<Map<String, dynamic>> exercisesWithDetails = dailyExercises.map((exercise) {
      if (timeBasedExercises.contains(exercise)) {
        int time = 30 + ((day - 1) ~/ 5) * 5;
        return {'name': exercise, 'type': 'time', 'value': time};
      } else {
        int count = 7 + ((day - 1) ~/ 5);
        return {'name': exercise, 'type': 'count', 'value': count};
      }
    }).toList();

    workoutPlan.add({'day': day, 'exercises': exercisesWithDetails, 'isRestDay': false});
  }
  return workoutPlan;
}

String getImagePath(String exerciseName) {
  return 'assets/images/${exerciseName.toLowerCase().replaceAll(' ', '_')}.png';
}