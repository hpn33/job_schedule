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

  await Hive.openBox('config');
}
