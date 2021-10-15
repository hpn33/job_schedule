import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:job_schedule/src/page/calculator/calculate_page.dart';
import 'package:job_schedule/src/page/setting/setting.dart';

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
                  const Placeholder(
                    fallbackHeight: 100,
                    fallbackWidth: double.infinity,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
