import 'package:flutter/material.dart';
import 'lessons_screen.dart';
import 'vocabulary_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('آموزش زبان انگلیسی')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LessonsScreen()),
                );
              },
              child: const Text('آموزش گرامر و مکالمه'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const VocabularyScreen()),
                );
              },
              child: const Text('لغات جدید'),
            ),
          ],
        ),
      ),
    );
  }
}