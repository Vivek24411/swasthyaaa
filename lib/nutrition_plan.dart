import 'package:flutter/material.dart';

class NutritionPlanPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Nutrition Plans',
          style: TextStyle(fontSize: 24), // Increased text size
        ),
        backgroundColor: Colors.deepPurple,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPlanCategory(
              context,
              "Calorie Deficit",
              [
                {
                  "Meal": "Breakfast",
                  "Food": "Poha with vegetables and peanuts",
                  "Calories": 250,
                  "Protein": 8,
                  "Carbs": 40,
                  "Fats": 5
                },
                {
                  "Meal": "Lunch",
                  "Food": "Dal (lentils) with roti and mixed vegetable sabzi",
                  "Calories": 350,
                  "Protein": 15,
                  "Carbs": 45,
                  "Fats": 8
                },
                {
                  "Meal": "Snacks",
                  "Food": "Sprouts chaat with lemon and spices",
                  "Calories": 150,
                  "Protein": 10,
                  "Carbs": 20,
                  "Fats": 3
                },
                {
                  "Meal": "Dinner",
                  "Food": "Quinoa khichdi with cucumber raita",
                  "Calories": 300,
                  "Protein": 12,
                  "Carbs": 50,
                  "Fats": 6
                },
              ],
            ),
            const SizedBox(height: 20),
            _buildPlanCategory(
              context,
              "Bulking",
              [
                {
                  "Meal": "Breakfast",
                  "Food": "Paratha with curd and a side of boiled eggs",
                  "Calories": 400,
                  "Protein": 20,
                  "Carbs": 50,
                  "Fats": 15
                },
                {
                  "Meal": "Lunch",
                  "Food": "Rajma (kidney beans) with brown rice and salad",
                  "Calories": 500,
                  "Protein": 25,
                  "Carbs": 60,
                  "Fats": 12
                },
                {
                  "Meal": "Snacks",
                  "Food": "Paneer tikka with mint chutney",
                  "Calories": 300,
                  "Protein": 20,
                  "Carbs": 10,
                  "Fats": 18
                },
                {
                  "Meal": "Dinner",
                  "Food": "Chicken curry with jeera rice and steamed vegetables",
                  "Calories": 550,
                  "Protein": 35,
                  "Carbs": 50,
                  "Fats": 20
                },
              ],
            ),
            const SizedBox(height: 20),
            _buildPlanCategory(
              context,
              "Normal",
              [
                {
                  "Meal": "Breakfast",
                  "Food": "Upma with vegetables and coconut chutney",
                  "Calories": 300,
                  "Protein": 10,
                  "Carbs": 40,
                  "Fats": 8
                },
                {
                  "Meal": "Lunch",
                  "Food": "Palak paneer with roti and salad",
                  "Calories": 400,
                  "Protein": 20,
                  "Carbs": 45,
                  "Fats": 15
                },
                {
                  "Meal": "Snacks",
                  "Food": "Fruit chaat with chaat masala",
                  "Calories": 200,
                  "Protein": 5,
                  "Carbs": 30,
                  "Fats": 5
                },
                {
                  "Meal": "Dinner",
                  "Food": "Moong dal khichdi with ghee and papad",
                  "Calories": 350,
                  "Protein": 15,
                  "Carbs": 50,
                  "Fats": 10
                },
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlanCategory(BuildContext context, String title, List<Map<String, dynamic>> meals) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ExpansionTile(
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 22, // Increased text size
            fontWeight: FontWeight.bold,
            color: Colors.deepPurple,
          ),
        ),
        children: meals.map((meal) {
          return ListTile(
            title: Text(
              meal['Meal'],
              style: const TextStyle(
                fontSize: 20, // Increased text size
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  meal['Food'],
                  style: const TextStyle(fontSize: 18), // Increased text size
                ),
                const SizedBox(height: 5),
                Text(
                  'Calories: ${meal['Calories']} | Protein: ${meal['Protein']}g | Carbs: ${meal['Carbs']}g | Fats: ${meal['Fats']}g',
                  style: const TextStyle(
                    fontSize: 16, // Increased text size
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}