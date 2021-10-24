import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:job_schedule/src/page/home/home.dart';
import 'package:job_schedule/src/service/db/database.dart';

// final timesP = StreamProvider((ref) => ref.read(dbProvider).timeDao.watching());

final timesP = StreamProvider((ref) {
  final selectedDay = ref.watch(HomePage.selectedDateP).state;

  return ref.read(dbProvider).timeDao.watchingOn(selectedDay);
});

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
  (ref) {
    final maped =
        ref.watch(timesStateP).state.map((e) => e.end.difference(e.start));

    if (maped.isEmpty) {
      return const Duration();
    }

    return maped.reduce((value, element) => value + element);
  },
);

final midOfHPD = StateProvider(
  (ref) {
    final days = ref.watch(dayCounterP).state;
    final allTime = ref.watch(sumOfTimesP).state;

    return (allTime.inMinutes / 60.0) / days;
  },
);

/// util
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
