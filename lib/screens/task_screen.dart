// import 'dart:collection';

// import 'package:calendar_app/screens/add_task.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:table_calendar/table_calendar.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../models/task_data.dart';
// import '../widgets/date.dart';

// class TaskScreen extends StatefulWidget {
//   @override
//   State<TaskScreen> createState() => _TaskScreenState();
// }

// class _TaskScreenState extends State<TaskScreen> {
//   DateTime _focusedDay = DateTime.now();
//   DateTime? _selectedDay;
//   Map<DateTime, List> _eventsList = {};
//   @override
//   void initState() {
//     super.initState();
//     _selectedDay = _focusedDay;
//     //サンプルのイベントリスト
//     _eventsList = {
//       DateTime.now().subtract(Duration(days: 2)): ['Event A6', 'Event B6'],
//       DateTime.now(): ['Event A7', 'Event B7', 'Event C7', 'Event D7'],
//       DateTime.now().add(Duration(days: 1)): [
//         'Event A8',
//         'Event B8',
//         'Event C8',
//         'Event D8'
//       ],
//       DateTime.now().add(Duration(days: 3)):
//           Set.from(['Event A9', 'Event A9', 'Event B9']).toList(),
//       DateTime.now().add(Duration(days: 7)): [
//         'Event A10',
//         'Event B10',
//         'Event C10'
//       ],
//       DateTime.now().add(Duration(days: 11)): ['Event A11', 'Event B11'],
//       DateTime.now().add(Duration(days: 17)): [
//         'Event A12',
//         'Event B12',
//         'Event C12',
//         'Event D12'
//       ],
//       DateTime.now().add(Duration(days: 22)): ['Event A13', 'Event B13'],
//       DateTime.now().add(Duration(days: 26)): [
//         'Event A14',
//         'Event B14',
//         'Event C14'
//       ],
//     };
//   }

//   @override
//   Widget build(BuildContext context) {
//     final _events = LinkedHashMap<DateTime, List>(
//       equals: isSameDay,
//       hashCode: getHashCode,
//     )..addAll(_eventsList);

//     List _getEventForDay(DateTime day) {
//       return _events[day] ?? [];
//     }

//     return Container(
//       color: Color(0xff7C7C7C).withOpacity(1),
//       child: Container(
//         decoration: const BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(20),
//             topRight: Radius.circular(20),
//           ),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black26,
//               spreadRadius: 1.0,
//               blurRadius: 10.0,
//               offset: Offset(10, 10),
//             ),
//           ],
//         ),
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
//           child: Column(
//             // crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               Row(
//                 children: [
//                   Text(
//                     'Task',
//                     textAlign: TextAlign.left,
//                     style: TextStyle(
//                       fontSize: 30,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.only(left: 200),
//                   ),
//                   FloatingActionButton(
//                     backgroundColor: Colors.blue,
//                     foregroundColor: Colors.black,
//                     onPressed: () {
//                       // Provider.of<TaskData>(context, listen: false).addTasks(newTask);
//                       // Navigator.pop(context);
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => AddTask(),
//                           ));
//                     },
//                     child: Icon(Icons.add),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 10),
//               Container(
//                 child: Column(
//                   children: [
//                     ListView(
//                       shrinkWrap: true,
//                       children: _getEventForDay(_selectedDay!)
//                           .map((event) => ListTile(
//                                 title: Text(event.toString()),
//                               ))
//                           .toList(),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
