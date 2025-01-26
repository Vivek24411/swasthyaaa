import 'dart:math';

List<Map<String, dynamic>> generateYogaPlan() {
  List<String> yogaPoses = [
    'Downward Dog',
    'Child\'s Pose',
    'Warrior I',
    'Warrior II',
    'Tree Pose',
    'Triangle Pose',
    'Cobra Pose',
    'Plank Pose',
    'Bridge Pose',
    'Crescent Lunge',
    'Boat Pose',
    'Seated Forward Bend',
    'Legs Up the Wall Pose',
    'Sphinx Pose',
    'Camel Pose',
    'Pigeon Pose',
  ];

  List<Map<String, dynamic>> yogaPlan = [];
  for (int day = 1; day <= 30; day++) {
    if (day % 7 == 0) {
      yogaPlan.add({'day': day, 'poses': [], 'isRestDay': true});
      continue;
    }

    int poseCount = min(7 + ((day - 1) ~/ 5), 12); // Gradually increase to 12 poses
    int poseDuration = 60 + ((day - 1) ~/ 5) * 2; // Gradually increase to 120 seconds

    List<String> dailyPoses = yogaPoses.sublist(0, poseCount);

    List<Map<String, dynamic>> posesWithDetails = dailyPoses.map((pose) {
      return {
        'name': pose,
        'duration': poseDuration,
      };
    }).toList();

    yogaPlan.add({
      'day': day,
      'poses': posesWithDetails,
      'isRestDay': false,
    });
  }
  return yogaPlan;
}