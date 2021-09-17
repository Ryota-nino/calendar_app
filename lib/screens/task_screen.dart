import 'dart:collection';

import 'package:calendar_app/screens/add_task.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/task_data.dart';
import '../widgets/date.dart';

class TaskScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff7C7C7C).withOpacity(1),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              spreadRadius: 1.0,
              blurRadius: 10.0,
              offset: Offset(10, 10),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: [
                  Text(
                    'Task',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 200),
                  ),
                  FloatingActionButton(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.black,
                    onPressed: () {
                      // Provider.of<TaskData>(context, listen: false).addTasks(newTask);
                      // Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddTask(),
                          ));
                    },
                    child: Icon(Icons.add),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Container(
                child: Column(
                  children: [],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
