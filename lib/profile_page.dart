import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();
  late SharedPreferences _prefs;

  String _username = '';
  String _gender = '';
  String _height = '';
  String _weight = '';
  String _dob = '';
  bool _isFirstTime = true;

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  Future<void> _loadProfileData() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      _username = _prefs.getString('username') ?? '';
      _gender = _prefs.getString('gender') ?? '';
      _height = _prefs.getString('height') ?? '';
      _weight = _prefs.getString('weight') ?? '';
      _dob = _prefs.getString('dob') ?? '';
      _isFirstTime = _username.isEmpty; // Check if profile data exists
    });
  }

  Future<void> _saveProfileData() async {
    await _prefs.setString('username', _username);
    await _prefs.setString('gender', _gender);
    await _prefs.setString('height', _height);
    await _prefs.setString('weight', _weight);
    await _prefs.setString('dob', _dob);
    setState(() {
      _isFirstTime = false; // Mark setup as complete
    });
  }

  Future<void> _logout() async {
    await _prefs.clear();
    Navigator.pushReplacementNamed(context, '/login'); // Redirect to login page
  }

  Future<void> _showFeedbackDialog() async {
    final feedbackController = TextEditingController();
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Feedback'),
          content: TextField(
            controller: feedbackController,
            decoration: const InputDecoration(hintText: 'Enter your feedback'),
            maxLines: 3,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Thank you for your feedback!'),
                    backgroundColor: Colors.green,
                  ),
                );
              },
              child: const Text('Submit'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showProfileSetupDialog() async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Set Up Your Profile'),
          content: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: _usernameController,
                    decoration: const InputDecoration(labelText: 'Username'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your username';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _genderController,
                    decoration: const InputDecoration(labelText: 'Gender'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your gender';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _heightController,
                    decoration: const InputDecoration(labelText: 'Height (cm)'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your height';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _weightController,
                    decoration: const InputDecoration(labelText: 'Weight (kg)'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your weight';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _dobController,
                    decoration: const InputDecoration(labelText: 'Date of Birth (YYYY-MM-DD)'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your date of birth';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  setState(() {
                    _username = _usernameController.text;
                    _gender = _genderController.text;
                    _height = _heightController.text;
                    _weight = _weightController.text;
                    _dob = _dobController.text;
                  });
                  _saveProfileData();
                  Navigator.pop(context);
                }
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (_isFirstTime)
              Column(
                children: [
                  const Text(
                    'Welcome! Please set up your profile.',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _showProfileSetupDialog,
                    child: const Text('Set Up Profile'),
                  ),
                ],
              )
            else
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hello, $_username!',
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  _buildProfileInfo('Gender', _gender),
                  _buildProfileInfo('Height', '$_height cm'),
                  _buildProfileInfo('Weight', '$_weight kg'),
                  _buildProfileInfo('Date of Birth', _dob),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _showProfileSetupDialog,
                    child: const Text('Edit Profile'),
                  ),
                ],
              ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Share with Friends - Under Development'),
                    backgroundColor: Colors.blue,
                  ),
                );
              },
              child: const Text('Share with Friends'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Rate Us - Under Development'),
                    backgroundColor: Colors.blue,
                  ),
                );
              },
              child: const Text('Rate Us'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _showFeedbackDialog,
              child: const Text('Feedback'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _logout,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileInfo(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 16, color: Colors.grey),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}