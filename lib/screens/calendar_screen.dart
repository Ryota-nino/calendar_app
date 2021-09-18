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
  bool isDone = false;
  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    //サンプルのイベントリスト
    _eventsList = {
      DateTime.now().subtract(Duration(days: 2)): [
        [
          true,
          '課題提出',
          ['資料', '12時まで']
        ],
        [
          true,
          'プレゼン日',
          ['パソコン', 'やる気']
        ]
      ],
      DateTime.now(): [
        [true, '誕生日プレゼント買う'],
        [true, '会議'],
        [false, 'ジム'],
        [false, 'お風呂洗う']
      ],
      DateTime.now().add(Duration(days: 1)): [
        [false, 'バイト'],
        [false, 'Loft行く'],
        [false, '資料室行く'],
        [false, '参考書買う']
      ],
      DateTime.now().add(Duration(days: 7)): [
        [false, '散髪'],
        [false, 'おばあちゃんの家行く'],
        [false, '漫画返す']
      ],
      DateTime.now().add(Duration(days: 11)): [
        [false, 'シフト提出'],
        [false, '面接']
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
                                          .map((event) => Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(5),
                                                    ),
                                                    color: Colors.blue,
                                                  ),
                                                  child: ListTile(
                                                    leading: Checkbox(
                                                      value: event[0],
                                                      onChanged: (value) {
                                                        event[0] = value;
                                                        setState(() {});
                                                      },
                                                    ),
                                                    title: Text(
                                                      event[1].toString(),
                                                    ),
                                                  ),
                                                ),
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
                );
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
