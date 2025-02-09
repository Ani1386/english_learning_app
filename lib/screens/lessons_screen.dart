import 'package:flutter/material.dart';
import '../database/database_helper.dart';

class LessonsScreen extends StatefulWidget {
  const LessonsScreen({Key? key}) : super(key: key);

  @override
  _LessonsScreenState createState() => _LessonsScreenState();
}

class _LessonsScreenState extends State<LessonsScreen> {
  late Future<List<Map<String, dynamic>>> lessons;

  @override
  void initState() {
    super.initState();
    lessons = DatabaseHelper.instance.database.then((db) => db.query('lessons'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('درس‌ها')),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: lessons,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final data = snapshot.data!;
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(data[index]['title']),
                subtitle: Text(data[index]['content']),
              );
            },
          );
        },
      ),
    );
  }
}