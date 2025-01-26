import 'package:flutter/material.dart';
import 'dart:async';

class YogaSessionPage extends StatefulWidget {
  final int day;
  final List<Map<String, dynamic>> yogaPlan;

  const YogaSessionPage({
    Key? key,
    required this.yogaPlan,
    required this.day,
  }) : super(key: key);

  @override
  State<YogaSessionPage> createState() => _YogaSessionPageState();
}

class _YogaSessionPageState extends State<YogaSessionPage> {
  int currentPoseIndex = 0;
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
        timerValue = 30; // 30-second rest
      } else {
        timerValue = widget.yogaPlan[currentPoseIndex]['duration'];
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
        if (currentPoseIndex < widget.yogaPlan.length - 1) {
          currentPoseIndex++;
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

  void _quitYoga() {
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
    final currentPose = widget.yogaPlan[currentPoseIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text('Day ${widget.day} Yoga'),
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
              Icon(Icons.spa, size: 100, color: Colors.deepPurple),
              const SizedBox(height: 20),
              Text(
                'Time Left: $timerValue seconds',
                style: const TextStyle(fontSize: 20),
              ),
            ] else ...[
              Text(
                currentPose['name'],
                style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Icon(Icons.spa, size: 100, color: Colors.deepPurple),
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
                  onPressed: _quitYoga,
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