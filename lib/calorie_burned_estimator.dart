import 'package:flutter/material.dart';

class CalorieBurnEstimatorPage extends StatefulWidget {
  @override
  _CalorieBurnEstimatorPageState createState() =>
      _CalorieBurnEstimatorPageState();
}

class _CalorieBurnEstimatorPageState extends State<CalorieBurnEstimatorPage> {
  final Map<String, double> exercises = {
    'Running (6 mph)': 10.0,
    'Jumping Rope': 12.0,
    'Cycling (Moderate)': 8.0,
    'Swimming': 7.5,
    'Weightlifting': 5.0,
    'Yoga': 3.5,
    'Pilates': 4.0,
    'Walking (3 mph)': 4.5,
    'Hiking': 6.0,
    'Dancing': 6.0,
    'Rowing': 7.0,
    'Boxing': 10.0,
    'Kickboxing': 11.0,
    'High Intensity Interval Training (HIIT)': 15.0,
    'Jump Squats': 12.0,
    'Pushups': 6.0,
    'Pull-ups': 7.0,
    'Burpees': 13.0,
    'Mountain Climbers': 10.0,
    'Squats': 6.0,
    'Lunges': 5.5,
    'Plank': 3.0,
    'Crunches': 4.0,
    'Leg Raises': 4.5,
    'Side Lunges': 5.5,
    'Box Jumps': 12.0,
    'Deadlifts': 6.5,
    'Bench Press': 5.5,
    'Skipping (Jump Rope)': 12.5,
    'Cycling (Fast)': 9.0,
  };

  String? _selectedExercise;
  final TextEditingController _timeController = TextEditingController();
  double _caloriesBurned = 0;

  void _calculateCalories() {
    final String timeInput = _timeController.text;
    if (timeInput.isEmpty || _selectedExercise == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select an exercise and enter time')),
      );
      return;
    }

    final double time = double.tryParse(timeInput) ?? 0;
    if (time <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Enter a valid time')),
      );
      return;
    }

    setState(() {
      _caloriesBurned =
          exercises[_selectedExercise!]! * time; // Calories per minute * time
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calorie Burn Estimator'),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Select Exercise and Time',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            _buildExerciseDropdown(),
            const SizedBox(height: 16),
            _buildTextField(
              controller: _timeController,
              label: 'Time (in minutes)',
              hint: 'Enter time in minutes',
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calculateCalories,
              child: Text('Calculate Calories Burned'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: EdgeInsets.symmetric(vertical: 14),
                textStyle: TextStyle(fontSize: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 30),
            if (_caloriesBurned > 0)
              Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.green.shade200, Colors.green.shade600],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Calories Burned: ${_caloriesBurned.toStringAsFixed(1)} kcal',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildExerciseDropdown() {
    return DropdownButtonFormField<String>(
      value: _selectedExercise,
      decoration: InputDecoration(
        labelText: 'Exercise',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
        filled: true,
        fillColor: Colors.green.shade50,
      ),
      items: exercises.keys
          .map((exercise) => DropdownMenuItem<String>(
        value: exercise,
        child: Text(exercise),
      ))
          .toList(),
      onChanged: (value) {
        setState(() {
          _selectedExercise = value;
        });
      },
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    String? hint,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
        filled: true,
        fillColor: Colors.green.shade50,
      ),
    );
  }
}
