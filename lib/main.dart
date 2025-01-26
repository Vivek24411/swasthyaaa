import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'login_page.dart';
import 'nutrition_plan.dart';
import 'profile_page.dart';
import 'utils/routes.dart';
import 'registration_page.dart';
import 'home_page.dart';
import 'workout_overview_page.dart';
import 'water_tracker.dart';
import 'calories_counter.dart';
import 'splash_screen.dart';
import 'motivational_page.dart';
import 'exercise_tips.dart';
import 'bmi_calculator.dart';
import 'calorie_burned_estimator.dart';
import 'to_do.dart';
import 'yoga_overview_page.dart';
import 'meditation_overview_page.dart';
import 'activity_page.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Initialize Firebase
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.light,
      initialRoute: "/",
      routes: {
        "/": (context) => SplashScreen(),
        MyRoutes.homeRoute: (context) => HomePage(),
        MyRoutes.loginRoute: (context) => LoginPage(),
        MyRoutes.registrationRoute: (context) => RegistrationPage(),
        MyRoutes.workoutoverviewRoute: (context) => WorkoutOverviewPage(),
        MyRoutes.watertrackerRoute: (context) => WaterTrackerPage(),
        "/calories_counter": (context) => CalorieCounterPage(),
        "/nutrition_plan": (context) => NutritionPlanPage(),
        "/profile_page": (context) => ProfilePage(),
        "/splash_screen": (context) => SplashScreen(),
        "/motivational_page": (context) => MotivationalQuotesPage(),
        "/exercise_tips": (context) => ExerciseTipsPage(),
        "/bmi_calculator": (context) => BMICalculatorPage(),
        "/calorie_burned_estimator.dart": (context) => CalorieBurnEstimatorPage(),
        "/to_do": (context) => ToDoPage(),
        "/yoga_overview_page": (context) => YogaOverviewPage(),
        MyRoutes.meditationRoute: (context) => MeditationOverviewPage(),
        MyRoutes.activityRoute: (context) => ActivityPage(),
        MyRoutes.caloriesburnedRoute: (context) => CalorieBurnEstimatorPage(),
        MyRoutes.todoRoute: (context) => ToDoPage(),
      },
    );
  }
}