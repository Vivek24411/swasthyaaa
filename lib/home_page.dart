import 'package:flutter/material.dart';
import 'package:swaraksha/calorie_burned_estimator.dart';
import 'package:swaraksha/to_do.dart';
import 'activity_page.dart';
import 'meditation_overview_page.dart';



class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Fitness App",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.deepPurple,
      ),
      body: Container(
        color: Colors.black,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                _buildCard(
                  context,
                  "Workout",
                  Icons.fitness_center,
                  Colors.blue,
                      () {
                    Navigator.pushNamed(context, "/workout_overview");
                  },
                ),
            _buildCard(
              context,
              "Yoga",
              Icons.fast_forward_sharp,
              Colors.deepPurple,
                  () {
                Navigator.pushNamed(context, "/yoga_overview_page");
              },
            ),
                _buildCard(
              context,
              "Meditation",
              Icons.calculate_outlined,
              Colors.pink,
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MeditationOverviewPage()),
                    );
              },
            ),
                _buildCard(
                  context,
                  "Nutrition Plan",
                  Icons.restaurant_menu,
                  Colors.green,
                      () {
                    Navigator.pushNamed(context, "/nutrition_plan");
                  },
                ),
                _buildCard(
                  context,
                  "Calories Counter",
                  Icons.calculate,
                  Colors.orange,
                      () {
                    Navigator.pushNamed(context, "/calories_counter");
                  },
                ),
                _buildCard(
                  context,
                  "Profile",
                  Icons.person,
                  Colors.purple,
                      () {
                    Navigator.pushNamed(context, "/profile_page");
                  },
                ),
                _buildCard(
                  context,
                  "My Activity",
                  Icons.timeline,
                  Colors.red,
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ActivityPage()),
                        );
                  },
                ),
                _buildCard(
                  context,
                  "Water Tracker",
                  Icons.local_drink,
                  Colors.cyan,
                      () {
                    Navigator.pushNamed(context, "/water_tracker");
                  },

                ),
                _buildCard(
                  context,
                  "Kitni Calories",
                  Icons.calculate_outlined,
                  Colors.brown,
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => CalorieBurnEstimatorPage()),
                        );
                  },
                ),
                _buildCard(
                  context,
                  "BMI nikalte hain!!",
                  Icons.calculate_outlined,
                  Colors.yellow,
                      () {
                    Navigator.pushNamed(context, "/bmi_calculator");
                  },
                ),
            _buildCard(
              context,
              "To Do Activity",
              Icons.calculate_outlined,
              Colors.indigo,
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ToDoPage()),
                    );
              },
            ),
                _buildCard(
                  context,
                  "Exercise Tips",
                  Icons.account_circle_sharp,
                  Colors.red,
                      () {
                    Navigator.pushNamed(context, "/exercise_tips");
                  },
                ),
                _buildCard(
                  context,
                  "Motivational Quotes",
                  Icons.radio,
                  Colors.blueGrey,
                      () {
                    Navigator.pushNamed(context, "/motivational_page");
                  },
                ),
                _buildCard(
                  context,
                  "Workout Tracker",
                  Icons.track_changes,
                  Colors.teal,
                      () {
                    print("Workout Tracker section clicked");
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCard(
      BuildContext context,
      String title,
      IconData icon,
      Color color,
      VoidCallback onTap,
      ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 400,
        height: 150,
        margin: EdgeInsets.symmetric(vertical: 10),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: color.withOpacity(0.05),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: color, width: 2),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: color.withOpacity(0.3),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 50, color: color),
            ),
            SizedBox(width: 20),
            Text(
              title,
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}