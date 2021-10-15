import 'package:job_schedule/src/service/db/table/times.dart';
import 'package:moor/moor.dart';

import '../database.dart';

part 'time_dao.g.dart';

@UseDao(tables: [Times])
class TimeDao extends DatabaseAccessor<Database> with _$TimeDaoMixin {
  final Database db;

  // Called by the AppDatabase class
  TimeDao(this.db) : super(db);

  // Stream<List<Time>> watching() => select(contents).watch();

  // Future<int> add(String title, String content) => into(contents)
  //     .insert(ContentsCompanion.insert(title: title, content: content));

  // Future<bool> updateData(Content content, String json) {
  //   return update(contents).replace(content.copyWith(data: json));
  // }
}