import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:job_schedule/src/page/calculator/calculate_page.dart';
import 'package:job_schedule/src/page/setting/setting.dart';
import 'package:job_schedule/src/service/db/database.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomePage extends HookWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      final box = Hive.box('config');

      if (box.get('firstTime', defaultValue: true)) {
        // if (true) {
        box.put('firstTime', false);

        Navigator.push(
          context,
          MaterialPageRoute(builder: (c) => const SettingPage()),
        );
      }
    }, []);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                TextButton(
                  child: const Text('Detail Page'),
                  onPressed: () {
                    // TODO:
                  },
                ),
                TextButton(
                  child: const Text('Setting Page'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (c) => const SettingPage()),
                    );
                  },
                ),
                TextButton(
                  child: const Text('Calculator Page'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (c) => const CalculatePage()),
                    );
                  },
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    // TODO: add new range time
                  },
                ),
              ],
            ),
            Expanded(
              child: Column(
                children: [
                  addCard(context),
                  showRecords(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget showRecords() {
    return HookBuilder(
      builder: (context) {
        final records = context.read(dbProvider).timeDao.watching();

        return StreamBuilder<List<Time>?>(
          stream: records,
          builder: (BuildContext context, snapshot) {
            if (!snapshot.hasData &&
                snapshot.connectionState != ConnectionState.done) {
              return const Center(child: Text('something wrong'));
            }

            final dayGroup = <DateTime, List<Time>>{};

            for (final i in snapshot.data!) {
              if (!dayGroup.containsKey(i.start)) {
                dayGroup[i.start] = [];
              }

              dayGroup[i.start]!.add(i);
            }

            return SingleChildScrollView(
              child: Column(
                children: [
                  for (final i in dayGroup.entries)
                    Text(
                      '${i.key.year}-${i.key.month}-${i.key.day}\n' +
                          i.value.map((e) => e.toString()).toString(),
                    )
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget addCard(BuildContext context) {
    return HookBuilder(
      builder: (BuildContext context) {
        final dayDate = useState(DateTime.now());
        final startTime = useState(DateTime.now());
        final endTime = useState(DateTime.now());

        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: Card(
            child: Column(
              children: [
                TextButton(
                  onPressed: () {
                    showDialog<DateTime>(
                      context: context,
                      builder: (c) => DatePickerDialog(
                        initialDate: startTime.value,
                        firstDate:
                            DateTime.now().add(const Duration(days: -365)),
                        lastDate: DateTime.now().add(const Duration(days: 365)),
                      ),
                    ).then((value) => dayDate.value = value!);
                  },
                  child: Text(
                    '${dayDate.value.year}-${dayDate.value.month}-${dayDate.value.day}',
                  ),
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
                            final dd = dayDate.value;
                            value!;

                            startTime.value = DateTime(
                              dd.year,
                              dd.month,
                              dd.day,
                              value.hour,
                              value.minute,
                            );
                          });
                        },
                        child: Text(
                          TimeOfDay.fromDateTime(startTime.value)
                              .format(context)
                              .toString(),
                        ),
                      ),
                    ),
                    const Spacer(),
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
                            final dd = dayDate.value;
                            value!;

                            endTime.value = DateTime(
                              dd.year,
                              dd.month,
                              dd.day,
                              value.hour,
                              value.minute,
                            );
                          });
                        },
                        child: Text(TimeOfDay.fromDateTime(endTime.value)
                            .format(context)
                            .toString()),
                      ),
                    ),
                  ],
                ),
                TextButton(
                  onPressed: () {
                    final db = context.read(dbProvider);

                    db.timeDao.add(startTime.value, endTime.value);
                  },
                  child: const Text('Add'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
