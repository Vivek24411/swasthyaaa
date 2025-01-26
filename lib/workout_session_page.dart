import 'package:flutter/material.dart';
import 'dart:async';
import '../utils/workout_plan_generator.dart';

class WorkoutSessionPage extends StatefulWidget {
  final int day;
  final List<Map<String, dynamic>> workoutPlan;

  const WorkoutSessionPage({
    Key? key,
    required this.workoutPlan,
    required this.day,
  }) : super(key: key);

  @override
  State<WorkoutSessionPage> createState() => _WorkoutSessionPageState();
}

class _WorkoutSessionPageState extends State<WorkoutSessionPage> {
  int currentExerciseIndex = 0;
  bool isPaused = false;
  bool isRestPhase = false;
  late int timerValue;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    _initializeTimer();
  }

  void _initializeTimer() {
    setState(() {
      if (isRestPhase) {
        timerValue = 30;
      } else if (widget.workoutPlan[currentExerciseIndex]['type'] == 'time') {
        timerValue = widget.workoutPlan[currentExerciseIndex]['value'];
      } else {
        timerValue = 0;
      }
    });
    _startTimer();
  }

  void _startTimer() {
    timer?.cancel();
    if (timerValue > 0) {
      timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
        if (!isPaused) {
          setState(() {
            if (timerValue > 0) {
              timerValue--;
            } else {
              t.cancel();
              _nextPhase();
            }
          });
        }
      });
    }
  }

  void _togglePause() {
    setState(() {
      isPaused = !isPaused;
    });
  }

  void _nextPhase() {
    setState(() {
      if (isRestPhase) {
        if (currentExerciseIndex < widget.workoutPlan.length - 1) {
          currentExerciseIndex++;
          isRestPhase = false;
          _initializeTimer();
        } else {
          Navigator.pop(context);
        }
      } else {
        isRestPhase = true;
        _initializeTimer();
      }
    });
  }

  void _quitWorkout() {
    timer?.cancel();
    Navigator.pop(context);
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentExercise = widget.workoutPlan[currentExerciseIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text('Day ${widget.day} Workout'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isRestPhase) ...[
              const Text(
                'Rest',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Image.asset(
                'assets/images/rest.png',
                height: 250,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 20),
              Text(
                'Time Left: $timerValue seconds',
                style: const TextStyle(fontSize: 20),
              ),
            ] else ...[
              Text(
                currentExercise['name'],
                style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Image.asset(
                getImagePath(currentExercise['name']),
                height: 300,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 20),
              if (currentExercise['type'] == 'time')
                Text('Time Left: $timerValue seconds', style: const TextStyle(fontSize: 20)),
              if (currentExercise['type'] == 'count')
                Text('Reps: ${currentExercise['value']}', style: const TextStyle(fontSize: 20)),
            ],
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _nextPhase,
                  style: ElevatedButton.styleFrom(minimumSize: Size(100, 45)),
                  child: const Text('Skip'),
                ),
                if (!isRestPhase && currentExercise['type'] == 'time')
                  ElevatedButton(
                    onPressed: _togglePause,
                    style: ElevatedButton.styleFrom(minimumSize: Size(100, 45)),
                    child: Text(isPaused ? 'Resume' : 'Pause'),
                  ),
                if (!isRestPhase && currentExercise['type'] == 'count')
                  ElevatedButton(
                    onPressed: _nextPhase,
                    style: ElevatedButton.styleFrom(minimumSize: Size(100, 45)),
                    child: const Text('Done'),
                  ),
                ElevatedButton(
                  onPressed: _quitWorkout,
                  style: ElevatedButton.styleFrom(minimumSize: Size(100, 45)),
                  child: const Text('Quit'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}