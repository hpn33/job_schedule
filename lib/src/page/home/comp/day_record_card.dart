import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:job_schedule/src/service/db/database.dart';

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
          Column(
            children: [for (final time in times) timeCard(time)],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(sumOfTimes(times)),
            ],
          ),
        ],
      ),
    );
  }

  Widget timeCard(Time time) {
    return Row(
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
          child: Text(
              (time.end.difference(time.start)).toString().substring(0, 8)),
        ),
      ],
    );
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
