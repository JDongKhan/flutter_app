import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// @author jd
class TimePickerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Time Picker'),
      ),
      body: ListView(
        children: [
          Row(
            children: [
              TextButton(
                onPressed: () async {
                  var time = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000, 1, 1),
                    lastDate: DateTime(2028, 1, 1),
                  );
                  print(time);
                },
                child: Text('显示日历弹框'),
              ),
              TextButton(
                onPressed: () async {
                  var time = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.fromDateTime(
                      DateTime.now(),
                    ),
                  );
                  print(time);
                },
                child: Text('显示时间弹框'),
              ),
            ],
          ),
          CalendarDatePicker(
            initialDate: DateTime.now(),
            // currentDate: DateTime(2022, 1, 1),
            firstDate: DateTime(2000, 1, 1),
            lastDate: DateTime(2028, 1, 1),
            onDateChanged: (DateTime time) {},
          ),
          const Text('  iOS 风格'),
          Container(
            height: 200,
            child:
                CupertinoDatePicker(onDateTimeChanged: (DateTime dateTime) {}),
          ),
          CupertinoTimerPicker(onTimerDurationChanged: (Duration duration) {}),
        ],
      ),
    );
  }
}
