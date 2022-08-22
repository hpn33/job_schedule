import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:job_schedule/src/page/calculator/calculate_page.dart';
import 'package:job_schedule/src/page/home/comp/add_time_card.dart';
import 'package:job_schedule/src/page/setting/setting.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';

import 'comp/day_record_card.dart';
import 'home_p.dart';

class HomePage extends HookConsumerWidget {
  static final selectedDateP =
      StateProvider<DateTime?>((ref) => DateTime.now());

  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    useEffect(() {
      Future.delayed(const Duration(seconds: 3)).then((value) {
        final box = Hive.box('config');

        if (box.get('firstTime', defaultValue: true)) {
          box.put('firstTime', false);

          Navigator.push(
            context,
            MaterialPageRoute(builder: (c) => const SettingPage()),
          );
        }
      });

      return null;
    }, []);

    final selectedDay = ref.watch(selectedDateP.state).state;

    return Scaffold(
      backgroundColor: Colors.grey[400],
      body: SafeArea(
        child: Column(
          children: [
            appBar(context),
            Expanded(
              child: Column(
                children: [
                  status(),
                  TableCalendar(
                    calendarFormat: CalendarFormat.week,
                    firstDay: DateTime.utc(2010, 10, 16),
                    lastDay: DateTime.utc(2030, 3, 14),
                    focusedDay: selectedDay ?? DateTime.now(),
                    onDaySelected: (selected, focused) {
                      ref.read(selectedDateP.state).state = selected;
                    },
                    selectedDayPredicate: (d) {
                      return selectedDay!.isAtSameMomentAs(d);
                    },
                  ),
                  Expanded(child: SingleChildScrollView(child: showRecords())),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget appBar(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.settings),
              // child: const Text('Setting'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (c) => const SettingPage()),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.calculate),
              // child: const Text('Calculator'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (c) => const CalculatePage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget showRecords() {
    return HookConsumer(
      builder: (context, ref, child) {
        final dayGroup = ref.watch(sortedTimesP.state).state;

        return Column(
          children: [
            const AddTimeCard(),
            for (final i in dayGroup.entries) DayRecordCard(i.key, i.value),
          ],
        );
      },
    );
  }

  Widget status() {
    return HookConsumer(
      builder: (context, ref, child) {
        final timeCounter = ref.watch(dayCounterP.state).state;
        final sumOfTimes = ref.watch(sumOfTimesP.state).state;
        final midHPD = ref.watch(midOfHPD.state).state;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 4),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  /// days
                  Column(
                    children: [
                      Text(timeCounter.toString()),
                      const Text('days'),
                    ],
                  ),

                  /// hour
                  Column(
                    children: [
                      Text(sumOfTimes.toString().substring(0, 5)),
                      const Text('hours'),
                    ],
                  ),

                  /// midlle of hour per day
                  Column(
                    children: [
                      Text(midHPD.toStringAsFixed(2)),
                      const Text('m hpd'),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
