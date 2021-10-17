import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_schedule/src/service/db/database.dart';

class AddTimeCard extends HookWidget {
  const AddTimeCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dayDate = useState(DateTime.now());
    final startTime = useState(DateTime.now());
    final endTime = useState(DateTime.now().add(const Duration(hours: 1)));

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 4),
      child: Card(
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(
                        onPressed: () {
                          showDialog<DateTime>(
                            context: context,
                            builder: (c) => DatePickerDialog(
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now()
                                  .add(const Duration(days: -365)),
                              lastDate:
                                  DateTime.now().add(const Duration(days: 365)),
                            ),
                          ).then((value) => dayDate.value = value!);
                        },
                        child: Text(
                          '${dayDate.value.year}-${dayDate.value.month}-${dayDate.value.day}',
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            showDialog<TimeOfDay>(
                              context: context,
                              builder: (c) => TimePickerDialog(
                                initialTime:
                                    TimeOfDay.fromDateTime(startTime.value),
                              ),
                            ).then((value) {
                              value!;

                              startTime.value =
                                  DateTime(0, 0, 0, value.hour, value.minute);
                            });
                          },
                          child: Text(
                            TimeOfDay.fromDateTime(startTime.value)
                                .format(context)
                                .toString(),
                          ),
                        ),
                      ),
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            showDialog<TimeOfDay>(
                              context: context,
                              builder: (c) => TimePickerDialog(
                                initialTime:
                                    TimeOfDay.fromDateTime(endTime.value),
                              ),
                            ).then((value) {
                              value!;

                              endTime.value =
                                  DateTime(0, 0, 0, value.hour, value.minute);
                            });
                          },
                          child: Text(TimeOfDay.fromDateTime(endTime.value)
                              .format(context)
                              .toString()),
                        ),
                      ),
                      const Spacer(),
                      Text(
                        endTime.value
                            .difference(startTime.value)
                            .toString()
                            .substring(0, 8),
                      ),
                      const Spacer(),
                    ],
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                final db = context.read(dbProvider);

                final dd = dayDate.value;
                final startT = startTime.value;
                final endT = endTime.value;

                db.timeDao.add(
                  DateTime(
                    dd.year,
                    dd.month,
                    dd.day,
                    startT.hour,
                    startT.minute,
                  ),
                  DateTime(
                    dd.year,
                    dd.month,
                    dd.day,
                    endT.hour,
                    endT.minute,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
