import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class CalorieCounterPage extends StatefulWidget {
  @override
  _CalorieCounterPageState createState() => _CalorieCounterPageState();
}

class _CalorieCounterPageState extends State<CalorieCounterPage> {
  String? selectedFood;
  int quantity = 1;
  double totalCalories = 0;
  double totalProtein = 0;
  double totalCarbs = 0;
  double totalFat = 0;
  List<Map<String, dynamic>> foodList = [];
  List<Map<String, dynamic>> history = [];

  final DateFormat _dateFormat = DateFormat('yyyy-MM-dd');
  String _currentDate = '';

  @override
  void initState() {
    super.initState();
    _loadFoodItems();
    _loadCurrentDate();
    _loadData();
  }

  // Load common Indian foods
  void _loadFoodItems() {
    setState(() {
      foodList = [
        {"name": "Poha", "calories": 250, "protein": 8, "carbs": 40, "fat": 5},
        {"name": "Upma", "calories": 300, "protein": 10, "carbs": 45, "fat": 8},
        {"name": "Idli", "calories": 50, "protein": 2, "carbs": 10, "fat": 1},
        {"name": "Dosa", "calories": 150, "protein": 5, "carbs": 25, "fat": 3},
        {"name": "Paratha", "calories": 200, "protein": 6, "carbs": 30, "fat": 8},
        {"name": "Dal", "calories": 150, "protein": 8, "carbs": 20, "fat": 5},
        {"name": "Rajma", "calories": 300, "protein": 15, "carbs": 40, "fat": 10},
        {"name": "Chole", "calories": 350, "protein": 12, "carbs": 50, "fat": 12},
        {"name": "Paneer Tikka", "calories": 200, "protein": 15, "carbs": 10, "fat": 12},
        {"name": "Grilled Chicken", "calories": 250, "protein": 30, "carbs": 0, "fat": 15},
        {"name": "Quinoa Khichdi", "calories": 300, "protein": 12, "carbs": 50, "fat": 6},
        {"name": "Sprouts Chaat", "calories": 150, "protein": 10, "carbs": 20, "fat": 3},
        {"name": "Fruit Chaat", "calories": 200, "protein": 5, "carbs": 30, "fat": 5},
        {"name": "Roti", "calories": 100, "protein": 3, "carbs": 20, "fat": 2},
        {"name": "Rice", "calories": 200, "protein": 4, "carbs": 45, "fat": 1},
        {"name": "Khichdi", "calories": 250, "protein": 10, "carbs": 40, "fat": 5},
        {"name": "Samosa", "calories": 300, "protein": 5, "carbs": 35, "fat": 15},
        {"name": "Pakora", "calories": 200, "protein": 4, "carbs": 20, "fat": 10},
        {"name": "Lassi", "calories": 150, "protein": 6, "carbs": 20, "fat": 5},
        {"name": "Curd", "calories": 100, "protein": 4, "carbs": 10, "fat": 5},
        {"name": "Buttermilk", "calories": 50, "protein": 2, "carbs": 5, "fat": 2},
        {"name": "Aloo Gobi", "calories": 200, "protein": 5, "carbs": 30, "fat": 8},
        {"name": "Palak Paneer", "calories": 300, "protein": 15, "carbs": 20, "fat": 20},
        {"name": "Bhindi Masala", "calories": 150, "protein": 5, "carbs": 20, "fat": 8},
        {"name": "Egg Curry", "calories": 250, "protein": 20, "carbs": 10, "fat": 15},
        {"name": "Fish Curry", "calories": 300, "protein": 25, "carbs": 10, "fat": 20},
        {"name": "Chicken Biryani", "calories": 500, "protein": 30, "carbs": 60, "fat": 20},
        {"name": "Vegetable Biryani", "calories": 400, "protein": 10, "carbs": 70, "fat": 15},
        {"name": "Gulab Jamun", "calories": 150, "protein": 2, "carbs": 25, "fat": 5},
        {"name": "Jalebi", "calories": 200, "protein": 1, "carbs": 40, "fat": 8},
        {"name": "Pav Bhaji", "calories": 350, "protein": 10, "carbs": 50, "fat": 15},
        {"name": "Vada Pav", "calories": 300, "protein": 8, "carbs": 40, "fat": 12},
        {"name": "Misal Pav", "calories": 400, "protein": 15, "carbs": 60, "fat": 20},
        {"name": "Pani Puri", "calories": 100, "protein": 2, "carbs": 20, "fat": 3},
        {"name": "Bhel Puri", "calories": 200, "protein": 5, "carbs": 30, "fat": 5},
        {"name": "Sev Puri", "calories": 250, "protein": 6, "carbs": 35, "fat": 8},
        {"name": "Dhokla", "calories": 150, "protein": 6, "carbs": 25, "fat": 3},
        {"name": "Khandvi", "calories": 200, "protein": 8, "carbs": 30, "fat": 5},
        {"name": "Thepla", "calories": 250, "protein": 7, "carbs": 40, "fat": 8},
        {"name": "Undhiyu", "calories": 300, "protein": 10, "carbs": 50, "fat": 12},
        {"name": "Khaman", "calories": 200, "protein": 8, "carbs": 30, "fat": 5},
        {"name": "Pongal", "calories": 300, "protein": 10, "carbs": 50, "fat": 8},
        {"name": "Medu Vada", "calories": 150, "protein": 5, "carbs": 25, "fat": 5},
        {"name": "Rava Dosa", "calories": 200, "protein": 6, "carbs": 35, "fat": 6},
        {"name": "Masala Dosa", "calories": 250, "protein": 8, "carbs": 40, "fat": 8},
        {"name": "Uttapam", "calories": 200, "protein": 7, "carbs": 35, "fat": 5},
        {"name": "Appam", "calories": 150, "protein": 5, "carbs": 30, "fat": 3},
        {"name": "Puttu", "calories": 200, "protein": 6, "carbs": 40, "fat": 4},
        {"name": "Kadala Curry", "calories": 250, "protein": 10, "carbs": 30, "fat": 10},
        {"name": "Sambar", "calories": 150, "protein": 5, "carbs": 25, "fat": 5},
        {"name": "Rasam", "calories": 100, "protein": 3, "carbs": 20, "fat": 2},
        {"name": "Coconut Chutney", "calories": 100, "protein": 2, "carbs": 10, "fat": 8},
        {"name": "Tomato Chutney", "calories": 80, "protein": 2, "carbs": 15, "fat": 3},
        {"name": "Mint Chutney", "calories": 50, "protein": 1, "carbs": 10, "fat": 2},
        {"name": "Tandoori Roti", "calories": 150, "protein": 5, "carbs": 30, "fat": 3},
        {"name": "Naan", "calories": 200, "protein": 6, "carbs": 35, "fat": 5},
        {"name": "Kulcha", "calories": 250, "protein": 7, "carbs": 40, "fat": 8},
        {"name": "Baingan Bharta", "calories": 200, "protein": 6, "carbs": 30, "fat": 10},
        {"name": "Aloo Paratha", "calories": 300, "protein": 8, "carbs": 50, "fat": 12},
        {"name": "Gobi Paratha", "calories": 250, "protein": 7, "carbs": 40, "fat": 10},
        {"name": "Paneer Paratha", "calories": 350, "protein": 15, "carbs": 45, "fat": 15},
        {"name": "Methi Paratha", "calories": 200, "protein": 6, "carbs": 35, "fat": 8},
        {"name": "Malai Kofta", "calories": 400, "protein": 10, "carbs": 50, "fat": 20},
        {"name": "Navratan Korma", "calories": 350, "protein": 12, "carbs": 45, "fat": 18},
        {"name": "Dal Makhani", "calories": 300, "protein": 15, "carbs": 40, "fat": 15},
        {"name": "Chana Masala", "calories": 250, "protein": 10, "carbs": 35, "fat": 10},
        {"name": "Aloo Matar", "calories": 200, "protein": 6, "carbs": 30, "fat": 8},
        {"name": "Jeera Rice", "calories": 250, "protein": 5, "carbs": 50, "fat": 5},
        {"name": "Vegetable Pulao", "calories": 300, "protein": 8, "carbs": 55, "fat": 8},
        {"name": "Kheer", "calories": 200, "protein": 5, "carbs": 35, "fat": 6},
        {"name": "Rasgulla", "calories": 150, "protein": 3, "carbs": 30, "fat": 2},
        {"name": "Rasmalai", "calories": 200, "protein": 6, "carbs": 35, "fat": 5},
      ];
    });
  }

  void _loadCurrentDate() {
    setState(() {
      _currentDate = _dateFormat.format(DateTime.now());
    });
  }

  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    final historyData = prefs.getStringList('history') ?? [];
    setState(() {
      history = historyData.map((e) => Map<String, dynamic>.from(e as Map)).toList();
      totalCalories = prefs.getDouble('$_currentDate-calories') ?? 0;
      totalProtein = prefs.getDouble('$_currentDate-protein') ?? 0;
      totalCarbs = prefs.getDouble('$_currentDate-carbs') ?? 0;
      totalFat = prefs.getDouble('$_currentDate-fat') ?? 0;
    });
  }

  Future<void> _saveData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('$_currentDate-calories', totalCalories);
    await prefs.setDouble('$_currentDate-protein', totalProtein);
    await prefs.setDouble('$_currentDate-carbs', totalCarbs);
    await prefs.setDouble('$_currentDate-fat', totalFat);
    final historyData = history.map((e) => e.toString()).toList();
    await prefs.setStringList('history', historyData);
  }

  void addCalories() {
    if (selectedFood != null) {
      final foodItem = foodList.firstWhere((food) => food['name'] == selectedFood);
      final calories = foodItem['calories'] ?? 0;
      final protein = foodItem['protein'] ?? 0.0;
      final carbs = foodItem['carbs'] ?? 0.0;
      final fat = foodItem['fat'] ?? 0.0;

      setState(() {
        totalCalories += calories * quantity;
        totalProtein += protein * quantity;
        totalCarbs += carbs * quantity;
        totalFat += fat * quantity;
      });
      _saveData();
    }
  }

  void resetCalories() {
    setState(() {
      totalCalories = 0;
      totalProtein = 0;
      totalCarbs = 0;
      totalFat = 0;
      selectedFood = null;
      quantity = 1;
    });
    _saveData();
  }

  Widget _buildFoodDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.deepPurple, width: 2),
      ),
      child: DropdownButton<String>(
        value: selectedFood,
        hint: const Text('Choose food', style: TextStyle(fontSize: 18, color: Colors.deepPurple)),
        items: foodList.map((food) {
          return DropdownMenuItem<String>(
            value: food['name'],
            child: Text(food['name'], style: const TextStyle(fontSize: 18, color: Colors.deepPurple)),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            selectedFood = value;
            quantity = 1;
          });
        },
        isExpanded: true,
        underline: const SizedBox(), // Remove the default underline
      ),
    );
  }

  Widget _buildHistory() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Last 7 Days History:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.deepPurple),
            ),
            const SizedBox(height: 10),
            ...history.map((entry) {
              return ListTile(
                title: Text(entry['date'], style: const TextStyle(fontSize: 18, color: Colors.black87)),
                subtitle: Text(
                  'Calories: ${entry['calories']} kcal | Protein: ${entry['protein']}g | Carbs: ${entry['carbs']}g | Fat: ${entry['fat']}g',
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Calorie Counter',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blueGrey, Colors.blueAccent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Select Food:',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                      const SizedBox(height: 10),
                      _buildFoodDropdown(),
                      const SizedBox(height: 20),
                      const Text(
                        'Select Quantity:',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove, size: 30, color: Colors.black),
                            onPressed: quantity > 1
                                ? () {
                              setState(() {
                                quantity--;
                              });
                            }
                                : null,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            decoration: BoxDecoration(
                              color: Colors.deepPurple,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              quantity.toString(),
                              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.add, size: 30, color: Colors.deepPurple),
                            onPressed: () {
                              setState(() {
                                quantity++;
                              });
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Center(
                        child: ElevatedButton(
                          onPressed: addCalories,
                          child: const Text(
                            'Add Calories',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepPurple,
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Total Calories:',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.deepPurple),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        '$totalCalories kcal',
                        style: const TextStyle(fontSize: 30, color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Total Protein: $totalProtein g',
                        style: const TextStyle(fontSize: 20, color: Colors.black),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Total Carbs: $totalCarbs g',
                        style: const TextStyle(fontSize: 20, color: Colors.black),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Total Fat: $totalFat g',
                        style: const TextStyle(fontSize: 20, color: Colors.black),
                      ),
                      const SizedBox(height: 20),
                      Center(
                        child: ElevatedButton(
                          onPressed: resetCalories,
                          child: const Text(
                            'Reset All',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              _buildHistory(),
            ],
          ),
        ),
      ),
    );
  }
}