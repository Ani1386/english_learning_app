import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class VocabularyScreen extends StatefulWidget {
  const VocabularyScreen({Key? key}) : super(key: key);

  @override
  _VocabularyScreenState createState() => _VocabularyScreenState();
}

class _VocabularyScreenState extends State<VocabularyScreen> {
  late Database _database;
  List<Map<String, dynamic>> _vocabList = [];

  @override
  void initState() {
    super.initState();
    _initDatabase();
  }

  Future<void> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'vocabulary.db');

    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute('''
          CREATE TABLE vocabulary (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            word TEXT NOT NULL,
            meaning TEXT NOT NULL
          )
        ''');
      },
    );

    _loadVocabulary();
  }

  Future<void> _loadVocabulary() async {
    final List<Map<String, dynamic>> words = await _database.query('vocabulary');
    setState(() {
      _vocabList = words;
    });
  }

  Future<void> _addWord(String word, String meaning) async {
    await _database.insert('vocabulary', {'word': word, 'meaning': meaning});
    _loadVocabulary();
  }

  Future<void> _deleteWord(int id) async {
    await _database.delete('vocabulary', where: 'id = ?', whereArgs: [id]);
    _loadVocabulary();
  }

  void _showAddWordDialog() {
    final TextEditingController wordController = TextEditingController();
    final TextEditingController meaningController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('اضافه کردن لغت جدید'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: wordController,
                decoration: const InputDecoration(labelText: 'لغت'),
              ),
              TextField(
                controller: meaningController,
                decoration: const InputDecoration(labelText: 'معنی'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('لغو'),
            ),
            ElevatedButton(
              onPressed: () {
                if (wordController.text.isNotEmpty && meaningController.text.isNotEmpty) {
                  _addWord(wordController.text, meaningController.text);
                }
                Navigator.of(context).pop();
              },
              child: const Text('افزودن'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('واژگان')),
      body: ListView.builder(
        itemCount: _vocabList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_vocabList[index]['word']),
            subtitle: Text(_vocabList[index]['meaning']),
            trailing: IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () => _deleteWord(_vocabList[index]['id']),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddWordDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}