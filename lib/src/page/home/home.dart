import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:job_schedule/src/page/calculator/calculate_page.dart';
import 'package:job_schedule/src/page/home/comp/add_time_card.dart';
import 'package:job_schedule/src/page/setting/setting.dart';
import 'package:job_schedule/src/service/db/database.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'comp/day_record_card.dart';

final timesP = StreamProvider((ref) => ref.read(dbProvider).timeDao.watching());
final timesStateP = StateProvider<List<Time>>(
  (ref) => ref.watch(timesP).when(
        data: (data) => data,
        loading: () => [],
        error: (s, o) => [],
      ),
);
final sortedTimesP = StateProvider<Map<String, List<Time>>>((ref) {
  final times = ref.watch(timesP);

  return times.when(
    data: (data) {
      /// group by day
      final dayGroupTemp = <String, List<Time>>{};

      for (final i in data..sort((a, b) => b.start.compareTo(a.start))) {
        final date = i.start.toString().substring(0, 10);

        if (!dayGroupTemp.containsKey(date)) {
          dayGroupTemp[date] = [];
        }

        dayGroupTemp[date]!.add(i);
      }

      /// sort day
      final sort = dayGroupTemp.keys.toList()..sort((a, b) => b.compareTo(a));

      final dayGroup = <String, List<Time>>{};

      for (final i in sort) {
        dayGroup[i] = dayGroupTemp[i]!;
      }

      return dayGroup;
    },
    loading: () => {},
    error: (s, o) => {},
  );
});

final dayCounterP = StateProvider<int>(
  (ref) => ref
      .watch(timesStateP)
      .state
      .map((e) => e.start.toString().substring(0, 10))
      .toList()
      .uniqe()
      .length,
);

final sumOfTimesP = StateProvider<Duration>(
  (ref) => ref
      .watch(timesStateP)
      .state
      .map((e) => e.end.difference(e.start))
      .reduce((value, element) => value + element),
);

final midOfHPD = StateProvider(
  (ref) {
    final days = ref.watch(dayCounterP).state;
    final allTime = ref.watch(sumOfTimesP).state;

    return (allTime.inMinutes / 60.0) / days;
  },
);

class HomePage extends HookWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      final box = Hive.box('config');

      if (box.get('firstTime', defaultValue: true)) {
        box.put('firstTime', false);

        Navigator.push(
          context,
          MaterialPageRoute(builder: (c) => const SettingPage()),
        );
      }
    }, []);

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
                  const AddTimeCard(),
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
            const TextButton(
              child: Text('Detail Page'),
              onPressed: null, // TODO:
            ),
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
    return HookBuilder(
      builder: (context) {
        final dayGroup = useProvider(sortedTimesP).state;

        return Column(
          children: [
            for (final i in dayGroup.entries) DayRecordCard(i.key, i.value),
          ],
        );
      },
    );
  }

  Widget status() {
    return HookBuilder(
      builder: (context) {
        final timeCounter = useProvider(dayCounterP).state;
        final sumOfTimes = useProvider(sumOfTimesP).state;
        final midHPD = useProvider(midOfHPD).state;

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

extension CollectionUtil<T> on List<T> {
  List<T> uniqe() {
    final temp = <T>[];

    for (final item in this) {
      if (!temp.contains(item)) {
        temp.add(item);
      }
    }

    return temp;
  }
}
