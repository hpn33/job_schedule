import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CalculatePage extends HookWidget {
  const CalculatePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ppmController = useTextEditingController();
    final hpdController = useTextEditingController();

    useListenable(ppmController);
    useListenable(hpdController);

    useEffect(
      () {
        setDefault(ppmController, hpdController);
      },
      [],
    );

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                setDefault(ppmController, hpdController);
              },
              child: const Text('Default'),
            ),
            TextField(controller: ppmController),
            TextField(controller: hpdController),
            const Divider(),
            Text(hpm(hpdController)),
            Text(pph(ppmController, hpdController)),
          ],
        ),
      ),
    );
  }

  void setDefault(
    TextEditingController ppmController,
    TextEditingController hpdController,
  ) {
    final box = Hive.box('config');

    ppmController.text = box.get('ppm');
    hpdController.text = box.get('hpd');
  }

  String hpm(TextEditingController hpdController) {
    final hpd = int.tryParse(hpdController.text);

    if (hpd == null) {
      return 'hpd not true';
    }

    return (hpd * 30).toString() + ' (hour per mounth)';
  }

  String pph(
    TextEditingController ppmController,
    TextEditingController hpdController,
  ) {
    final hpd = int.tryParse(hpdController.text);
    final ppm = int.tryParse(ppmController.text);

    if (hpd == null) {
      return 'hpd not true';
    }

    if (ppm == null) {
      return 'ppm not true';
    }

    return (ppm / (hpd * 30)).toStringAsFixed(2) + ' (price per hour)';
  }
}
