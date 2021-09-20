import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

import '../main.dart';

// Future<void> _configureLocalTimeZone() async {
//   tz.initializeTimeZones();
//   final String timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
//   tz.setLocalLocation(tz.getLocation(timeZoneName));
// }

class AddTask extends StatefulWidget {
  Map<DateTime, List> eventsList;
  AddTask(this.eventsList);

  // final hours = List<String>.generate(12, (index) => '$index');
  // final minutes = List<String>.generate(59, (index) => '$index');
  // テキストフィールドの管理用コントローラを作成
  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final taskController = TextEditingController();
  final forgetController = TextEditingController();

  // List<Map<String, dynamic>> items = [
  //   {"id": 1, "content": "Content 1"},
  //   {"id": 2, "content": "Content 2"},
  //   {"id": 3, "content": "Content 3"}
  // ];

  int _counter = 0;

  void _addTask(String taskname, String forget) {
    setState(() {
      // DateTime.utc(2021, 9, 20): [
      //     true,
      //     '課題提出',
      //     '資料',
      //     '10:00',
      //   ],
      widget.eventsList[0]!.add(false);
      widget.eventsList[1]!.add(taskname);
      widget.eventsList[2]!.add(forget);
      widget.eventsList[3]!.add('12:00');
      setNotification();
    });
  }

  @override
  // widgetの破棄時にコントローラも破棄する
  void dispose() {
    taskController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("新規タスク"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(
                labelText: 'タスク名',
              ),
              controller: taskController,
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: '忘れたくないもの',
              ),
              controller: forgetController,
            ),
            // Expanded(
            //   child: ListView.builder(
            //     scrollDirection: Axis.vertical,
            //     shrinkWrap: true,
            //     itemCount: items.length,
            //     itemBuilder: (BuildContext context, int index) {
            //       final item = items[index];

            //       return new Card(
            //         child: ListTile(
            //           title: Text(
            //             item["content"],
            //           ),
            //         ),
            //       );
            //     },
            //   ),
            // ),
          ],
        ),
      ),
      // テキストフィールド送信用ボタン
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // myController.text で入力されたテキストフィールドの内容を取得
          // 以下の_addItemは自分で定義済の関数
          // _addTask(taskController.text, forgetController.text);
          setNotification();
          // テキストフィールドの内容をクリアする
          taskController.clear();
          forgetController.clear();

          Navigator.pop(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void setNotification() async {
    const IOSNotificationDetails iOSPlatformChannelSpecifics =
        IOSNotificationDetails(
            // sound: 'example.mp3',
            presentAlert: true,
            presentBadge: true,
            presentSound: true);
    NotificationDetails platformChannelSpecifics = const NotificationDetails(
      iOS: iOSPlatformChannelSpecifics,
      android: null,
    );
    await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      '筋トレの時間です',
      'プロテインを忘れないでください。',
      tz.TZDateTime.now(tz.UTC).add(const Duration(seconds: 10)),
      const NotificationDetails(
          android: AndroidNotificationDetails(
              'your channel id', 'Calendar_App', 'your channel description')),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }
}
