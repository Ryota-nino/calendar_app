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
      DateTime.utc(2021, 9, 18): [
        [true, '課題提出', '資料', '10:00'],
        [true, 'プレゼン日', 'パソコン', '14:00']
      ],
      DateTime.now(): [
        [true, '誕生日プレゼント買う', '予算1万', '11:00'],
        [true, '会議', '資料', '13:00'],
        [false, 'ジム', 'プロテイン', '16:00'],
        [false, 'お風呂洗う', '予算1万', '20:00']
      ],
      DateTime.now().add(Duration(days: 1)): [
        [false, 'バイト', '', '9:00'],
        [false, 'Loft行く', '', '15:00'],
        [false, '図書館行く', 'サピエンス全史', '16:00']
      ],
      DateTime.now().add(Duration(days: 7)): [
        [false, '散髪', '5000円', '10:00'],
        [false, 'ばあちゃんの家行く', 'お土産', '12:00'],
        [false, '漫画返す', '', '20:00']
      ],
      DateTime.now().add(Duration(days: 11)): [
        [false, 'シフト提出', '', ''],
        [false, '面接', 'やる気', '14:00'],
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
                  // backgroundColor: Colors.transparent,
                  builder: (BuildContext context) {
                    return StatefulBuilder(
                      builder: (BuildContext context, setState) {
                        return Container(
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
                                          'タスク',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 190),
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
                                                builder: (context) =>
                                                    AddTask(_eventsList),
                                              ),
                                            );
                                          },
                                          child: Icon(Icons.add),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    TaskList(_getEventForDay),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
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

  Container TaskList(List<dynamic> _getEventForDay(DateTime day)) {
    return Container(
      child: Column(
        children: [
          ListView(
            shrinkWrap: true,
            children: _getEventForDay(_selectedDay!)
                .map((event) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                          color: Colors.blue,
                        ),
                        child: ListTile(
                          onTap: () {
                            setState(() {
                              event[0] = !event[0];
                            });
                          },
                          onLongPress: () {},
                          leading: Checkbox(
                            value: event[0],
                            onChanged: (bool? value) {
                              setState(() {
                                event[0] = value;
                              });
                            },
                          ),
                          title: Text(
                            event[1].toString(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                          ),
                          subtitle: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(5),
                              ),
                            ),
                            child: Container(
                              child: Card(
                                color: Colors.white,
                                child: Text(
                                  event[2].toString(),
                                ),
                              ),
                            ),
                          ),
                          trailing: Text(
                            event[3].toString(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                            ),
                          ),
                        ),
                      ),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}
