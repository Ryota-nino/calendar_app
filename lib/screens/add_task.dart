import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddTask extends StatelessWidget {
  final hours = List<String>.generate(12, (index) => '$index');
  final minutes = List<String>.generate(59, (index) => '$index');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New Task"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: ListView(
          children: [
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Task Name',
                border: OutlineInputBorder(),
              ),
              maxLength: 12,
              autofocus: true,
            ),
            SizedBox(height: 10.0),
            TextFormField(
              decoration: InputDecoration(
                labelText: '忘れたくないもの',
                border: OutlineInputBorder(),
              ),
              maxLength: 20,
            ),
            SizedBox(height: 10.0),
            ElevatedButton(
              child: Text('Add'),
              onPressed: () => {
                Navigator.pop(context),
              },
            ),
          ],
        ),
      ),
    );
  }
}
