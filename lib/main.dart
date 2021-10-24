import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'app.dart';

Future<void> main() async {
  await hiveInit();

  runApp(const ProviderScope(child: MyApp()));
}

hiveInit() async {
  await Hive.initFlutter('job_schedule_data');

  final box = await Hive.openBox('config');

  if (box.containsKey('firstTime')) {
    return;
  }

  await box.put('firstTime', true);
  await box.put('hpd', '8');
  await box.put('ppm', '10000000');
}
