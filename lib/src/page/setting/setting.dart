import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SettingPage extends HookWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final hourTextController = useTextEditingController();
    final priceTextController = useTextEditingController();

    final message = useState('');

    useEffect(() {
      final box = Hive.box('config');

      hourTextController.text = box.get('hpd');
      priceTextController.text = box.get('ppm');
    }, []);

    useEffect(
      () {
        Future.delayed(const Duration(seconds: 1))
            .then((value) => message.value = '');
      },
      [message.value],
    );

    return Scaffold(
      backgroundColor: Colors.grey[400],
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: const [
                BackButton(),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const Text('Hour Per Day'),
                              const Spacer(),
                              Expanded(
                                  child: TextField(
                                      controller: hourTextController)),
                            ],
                          ),
                          Row(
                            children: [
                              const Text('Price Per Mounth'),
                              const Spacer(),
                              Expanded(
                                  child: TextField(
                                      controller: priceTextController)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          final box = Hive.box('config');

                          await box.put('hpd', hourTextController.text);
                          await box.put('ppm', priceTextController.text);

                          message.value = 'save';
                        },
                        child: const Text('Save'),
                      ),
                      Text(message.value),
                    ],
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
