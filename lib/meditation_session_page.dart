import 'package:flutter/material.dart';
import 'dart:async';

class MeditationSessionPage extends StatefulWidget {
  final int day;
  final List<Map<String, dynamic>> meditationPlan;

  const MeditationSessionPage({
    Key? key,
    required this.meditationPlan,
    required this.day,
  }) : super(key: key);

  @override
  State<MeditationSessionPage> createState() => _MeditationSessionPageState();
}

class _MeditationSessionPageState extends State<MeditationSessionPage> {
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
      } else {
        timerValue = widget.meditationPlan[currentExerciseIndex]['duration'];
      }
    });
    _startTimer();
  }

  void _startTimer() {
    timer?.cancel();
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

  void _togglePause() {
    setState(() {
      isPaused = !isPaused;
    });
  }

  void _nextPhase() {
    setState(() {
      if (isRestPhase) {
        if (currentExerciseIndex < widget.meditationPlan.length - 1) {
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

  void _quitMeditation() {
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
    final currentExercise = widget.meditationPlan[currentExerciseIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text('Day ${widget.day} Meditation'),
        backgroundColor: Colors.teal,
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
              Icon(Icons.self_improvement, size: 100, color: Colors.teal),
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
              Icon(Icons.self_improvement, size: 100, color: Colors.teal),
              const SizedBox(height: 20),
              Text(
                'Time Left: $timerValue seconds',
                style: const TextStyle(fontSize: 20),
              ),
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
                ElevatedButton(
                  onPressed: _togglePause,
                  style: ElevatedButton.styleFrom(minimumSize: Size(100, 45)),
                  child: Text(isPaused ? 'Resume' : 'Pause'),
                ),
                ElevatedButton(
                  onPressed: _quitMeditation,
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