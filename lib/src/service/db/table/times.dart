import 'package:moor/moor.dart';

class Times extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get descript => text()();
  DateTimeColumn get start => dateTime()();
  DateTimeColumn get end => dateTime()();
  DateTimeColumn get createAt => dateTime()();
  DateTimeColumn get updateAt => dateTime()();
}
