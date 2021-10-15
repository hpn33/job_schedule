import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:job_schedule/src/page/calculator/calculate_page.dart';
import 'package:job_schedule/src/page/home/comp/add_time_card.dart';
import 'package:job_schedule/src/page/setting/setting.dart';
import 'package:job_schedule/src/service/db/database.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'comp/day_record_card.dart';

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
      body: SafeArea(
        child: Column(
          children: [
            appBar(context),
            Expanded(
              child: Column(
                children: [
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

  Row appBar(BuildContext context) {
    return Row(
      children: [
        const TextButton(
          child: Text('Detail Page'),
          onPressed: null, // TODO:
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
      ],
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

            final dayGroupTemp = <String, List<Time>>{};

            for (final i in snapshot.data!) {
              final date = i.start.toString().substring(0, 10);

              if (!dayGroupTemp.containsKey(date)) {
                dayGroupTemp[date] = [];
              }

              dayGroupTemp[date]!.add(i);
            }

            final sort = dayGroupTemp.keys.toList()
              ..sort((a, b) => b.compareTo(a));

            final dayGroup = <String, List<Time>>{};

            for (final i in sort) {
              dayGroup[i] = dayGroupTemp[i]!;
            }

            return Column(
              children: [
                for (final i in dayGroup.entries) DayRecordCard(i.key, i.value),
              ],
            );
          },
        );
      },
    );
  }
}
