import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'add_task.dart';

import 'package:calendar_app/screens/task_screen.dart';

import '../widgets/date.dart';
import '../models/task_data.dart';

class CalendarScreen extends StatefulWidget {
  @override
  _CalendarScreen createState() => _CalendarScreen();
}

class _CalendarScreen extends State<CalendarScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  Map<DateTime, List> _eventsList = {};
  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    //サンプルのイベントリスト
    _eventsList = {
      DateTime.now().subtract(Duration(days: 2)): ['Event A6', 'Event B6'],
      DateTime.now(): ['Event A7', 'Event B7', 'Event C7', 'Event D7'],
      DateTime.now().add(Duration(days: 1)): [
        'Event A8',
        'Event B8',
        'Event C8',
        'Event D8'
      ],
      DateTime.now().add(Duration(days: 3)):
          Set.from(['Event A9', 'Event A9', 'Event B9']).toList(),
      DateTime.now().add(Duration(days: 7)): [
        'Event A10',
        'Event B10',
        'Event C10'
      ],
      DateTime.now().add(Duration(days: 11)): ['Event A11', 'Event B11'],
      DateTime.now().add(Duration(days: 17)): [
        'Event A12',
        'Event B12',
        'Event C12',
        'Event D12'
      ],
      DateTime.now().add(Duration(days: 22)): ['Event A13', 'Event B13'],
      DateTime.now().add(Duration(days: 26)): [
        'Event A14',
        'Event B14',
        'Event C14'
      ],
    };
  }

  @override
  Widget build(BuildContext context) {
    final _events = LinkedHashMap<DateTime, List>(
      equals: isSameDay,
      hashCode: getHashCode,
    )..addAll(_eventsList);

    List _getEventForDay(DateTime day) {
      return _events[day] ?? [];
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('カレンダー'),
      ),
      body: Column(
        children: [
          TableCalendar(
            headerStyle: const HeaderStyle(
              formatButtonVisible: false,
            ),
            firstDay: kFirstDay,
            lastDay: kLastDay,
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            eventLoader: _getEventForDay,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              if (!isSameDay(_selectedDay, selectedDay)) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                  // _calendarFormat = CalendarFormat.week;
                });
                showModalBottomSheet(
                  context: context,
                  // isDismissible: false,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (context) => Container(
                    height: MediaQuery.of(context).size.height * 0.70,
                    child: Container(
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
                          padding: const EdgeInsets.symmetric(
                              horizontal: 25, vertical: 25),
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
                                  children: [
                                    ListView(
                                      shrinkWrap: true,
                                      children: _getEventForDay(_selectedDay!)
                                          .map((event) => ListTile(
                                                title: Text(event.toString()),
                                              ))
                                          .toList(),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ).whenComplete(() => {_calendarFormat = CalendarFormat.month});
              }
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
            locale: 'ja_JP',
          ),
        ],
      ),
    );
  }
}
