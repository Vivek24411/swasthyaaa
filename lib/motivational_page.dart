import 'package:flutter/material.dart';

class MotivationalQuotesPage extends StatelessWidget {
  final List<String> quotes = [
    "Push yourself, because no one else is going to do it for you.",
    "Success starts with self-discipline.",
    "Train insane or remain the same.",
    "Don’t wish for it. Work for it.",
    "Good things come to those who sweat.",
    "Your body can stand almost anything. It’s your mind that you have to convince.",
    "The harder the battle, the sweeter the victory.",
    "It’s not about being the best. It’s about being better than you were yesterday.",
    "What seems impossible today will one day become your warm-up.",
    "Work hard in silence. Let success be your noise.",
    "Dream it. Believe it. Achieve it.",
    "Your only limit is you.",
    "Do something today that your future self will thank you for.",
    "You don’t get what you wish for. You get what you work for.",
    "The pain you feel today will be the strength you feel tomorrow.",
    "Sweat is fat crying.",
    "No excuses. Just results.",
    "Strive for progress, not perfection.",
    "Fall seven times, stand up eight.",
    "If you want something you’ve never had, you must be willing to do something you’ve never done.",
    "Energy and persistence conquer all things.",
    "Fitness is not about being better than someone else. It’s about being better than you used to be.",
    "Believe in yourself and all that you are.",
    "Every day is another chance to get stronger.",
    "Strength doesn’t come from what you can do. It comes from overcoming the things you once thought you couldn’t.",
    "Don’t count the days, make the days count.",
    "Motivation is what gets you started. Habit is what keeps you going.",
    "Success isn’t always about greatness. It’s about consistency.",
    "Small steps every day lead to big results.",
    "The difference between wanting and achieving is discipline."
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Motivational Quotes"),
        backgroundColor: Colors.deepPurple,
      ),
      body: PageView.builder(
        itemCount: quotes.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.deepPurple.shade400, Colors.deepPurple.shade800],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      quotes[index],
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
