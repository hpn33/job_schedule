import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:job_schedule/src/service/db/database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DayRecordCard extends StatelessWidget {
  final String day;
  final List<Time> times;

  const DayRecordCard(this.day, this.times, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.green[200],
                ),
                padding: const EdgeInsets.all(6),
                child: Text(day),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Column(
                    children: [
                      for (final time in times) timeCard(context, time)
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(sumOfTimes(times)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget timeCard(BuildContext context, Time time) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Row(
        children: [
          PopupMenuButton<String>(
            onSelected: (String result) {
              if (result == 'delete') {
                context.read(dbProvider).timeDao.remove(time);
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'delete',
                child: Text('delete'),
              ),
            ],
          ),
          Expanded(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(DateFormat.Hms().format(time.start)),
                    Text(DateFormat.Hms().format(time.end)),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.lightGreen[100],
                      ),
                      padding: const EdgeInsets.all(3),
                      child: Text((time.end.difference(time.start))
                          .toString()
                          .substring(0, 8)),
                    ),
                  ],
                ),

                ///
                const SizedBox(height: 5),

                ///
                Row(
                  children: [
                    Expanded(
                      flex: getFlexOfTime(time.start),
                      child: Container(
                        color: Colors.grey,
                        height: 5,
                      ),
                    ),
                    Expanded(
                      flex: getFlexOfTime(time.end) - getFlexOfTime(time.start),
                      child: Container(
                        color: Colors.green,
                        height: 5,
                      ),
                    ),
                    Expanded(
                      flex: 1440 - getFlexOfTime(time.end),
                      child: Container(
                        color: Colors.grey,
                        height: 5,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  int getFlexOfTime(DateTime time) {
    return ((time.hour * 60) + time.minute + (time.second / 60)).toInt();
  }

  String sumOfTimes(List<Time> times) {
    final sumOfTime = times.fold<Duration>(
      const Duration(),
      (previousValue, element) =>
          element.end.difference(element.start) + previousValue,
    );

    return "${sumOfTime.inHours}:${sumOfTime.inMinutes.remainder(60)}:${(sumOfTime.inSeconds.remainder(60))}";
  }
}
