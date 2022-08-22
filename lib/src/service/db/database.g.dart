// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: type=lint
class Time extends DataClass implements Insertable<Time> {
  final int id;
  final String descript;
  final DateTime start;
  final DateTime end;
  final DateTime createAt;
  final DateTime updateAt;
  Time(
      {required this.id,
      required this.descript,
      required this.start,
      required this.end,
      required this.createAt,
      required this.updateAt});
  factory Time.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Time(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      descript: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}descript'])!,
      start: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}start'])!,
      end: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}end'])!,
      createAt: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}create_at'])!,
      updateAt: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}update_at'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['descript'] = Variable<String>(descript);
    map['start'] = Variable<DateTime>(start);
    map['end'] = Variable<DateTime>(end);
    map['create_at'] = Variable<DateTime>(createAt);
    map['update_at'] = Variable<DateTime>(updateAt);
    return map;
  }

  TimesCompanion toCompanion(bool nullToAbsent) {
    return TimesCompanion(
      id: Value(id),
      descript: Value(descript),
      start: Value(start),
      end: Value(end),
      createAt: Value(createAt),
      updateAt: Value(updateAt),
    );
  }

  factory Time.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Time(
      id: serializer.fromJson<int>(json['id']),
      descript: serializer.fromJson<String>(json['descript']),
      start: serializer.fromJson<DateTime>(json['start']),
      end: serializer.fromJson<DateTime>(json['end']),
      createAt: serializer.fromJson<DateTime>(json['createAt']),
      updateAt: serializer.fromJson<DateTime>(json['updateAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'descript': serializer.toJson<String>(descript),
      'start': serializer.toJson<DateTime>(start),
      'end': serializer.toJson<DateTime>(end),
      'createAt': serializer.toJson<DateTime>(createAt),
      'updateAt': serializer.toJson<DateTime>(updateAt),
    };
  }

  Time copyWith(
          {int? id,
          String? descript,
          DateTime? start,
          DateTime? end,
          DateTime? createAt,
          DateTime? updateAt}) =>
      Time(
        id: id ?? this.id,
        descript: descript ?? this.descript,
        start: start ?? this.start,
        end: end ?? this.end,
        createAt: createAt ?? this.createAt,
        updateAt: updateAt ?? this.updateAt,
      );
  @override
  String toString() {
    return (StringBuffer('Time(')
          ..write('id: $id, ')
          ..write('descript: $descript, ')
          ..write('start: $start, ')
          ..write('end: $end, ')
          ..write('createAt: $createAt, ')
          ..write('updateAt: $updateAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, descript, start, end, createAt, updateAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Time &&
          other.id == this.id &&
          other.descript == this.descript &&
          other.start == this.start &&
          other.end == this.end &&
          other.createAt == this.createAt &&
          other.updateAt == this.updateAt);
}

class TimesCompanion extends UpdateCompanion<Time> {
  final Value<int> id;
  final Value<String> descript;
  final Value<DateTime> start;
  final Value<DateTime> end;
  final Value<DateTime> createAt;
  final Value<DateTime> updateAt;
  const TimesCompanion({
    this.id = const Value.absent(),
    this.descript = const Value.absent(),
    this.start = const Value.absent(),
    this.end = const Value.absent(),
    this.createAt = const Value.absent(),
    this.updateAt = const Value.absent(),
  });
  TimesCompanion.insert({
    this.id = const Value.absent(),
    required String descript,
    required DateTime start,
    required DateTime end,
    required DateTime createAt,
    required DateTime updateAt,
  })  : descript = Value(descript),
        start = Value(start),
        end = Value(end),
        createAt = Value(createAt),
        updateAt = Value(updateAt);
  static Insertable<Time> custom({
    Expression<int>? id,
    Expression<String>? descript,
    Expression<DateTime>? start,
    Expression<DateTime>? end,
    Expression<DateTime>? createAt,
    Expression<DateTime>? updateAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (descript != null) 'descript': descript,
      if (start != null) 'start': start,
      if (end != null) 'end': end,
      if (createAt != null) 'create_at': createAt,
      if (updateAt != null) 'update_at': updateAt,
    });
  }

  TimesCompanion copyWith(
      {Value<int>? id,
      Value<String>? descript,
      Value<DateTime>? start,
      Value<DateTime>? end,
      Value<DateTime>? createAt,
      Value<DateTime>? updateAt}) {
    return TimesCompanion(
      id: id ?? this.id,
      descript: descript ?? this.descript,
      start: start ?? this.start,
      end: end ?? this.end,
      createAt: createAt ?? this.createAt,
      updateAt: updateAt ?? this.updateAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (descript.present) {
      map['descript'] = Variable<String>(descript.value);
    }
    if (start.present) {
      map['start'] = Variable<DateTime>(start.value);
    }
    if (end.present) {
      map['end'] = Variable<DateTime>(end.value);
    }
    if (createAt.present) {
      map['create_at'] = Variable<DateTime>(createAt.value);
    }
    if (updateAt.present) {
      map['update_at'] = Variable<DateTime>(updateAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TimesCompanion(')
          ..write('id: $id, ')
          ..write('descript: $descript, ')
          ..write('start: $start, ')
          ..write('end: $end, ')
          ..write('createAt: $createAt, ')
          ..write('updateAt: $updateAt')
          ..write(')'))
        .toString();
  }
}

class $TimesTable extends Times with TableInfo<$TimesTable, Time> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TimesTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _descriptMeta = const VerificationMeta('descript');
  @override
  late final GeneratedColumn<String?> descript = GeneratedColumn<String?>(
      'descript', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _startMeta = const VerificationMeta('start');
  @override
  late final GeneratedColumn<DateTime?> start = GeneratedColumn<DateTime?>(
      'start', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _endMeta = const VerificationMeta('end');
  @override
  late final GeneratedColumn<DateTime?> end = GeneratedColumn<DateTime?>(
      'end', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _createAtMeta = const VerificationMeta('createAt');
  @override
  late final GeneratedColumn<DateTime?> createAt = GeneratedColumn<DateTime?>(
      'create_at', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _updateAtMeta = const VerificationMeta('updateAt');
  @override
  late final GeneratedColumn<DateTime?> updateAt = GeneratedColumn<DateTime?>(
      'update_at', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, descript, start, end, createAt, updateAt];
  @override
  String get aliasedName => _alias ?? 'times';
  @override
  String get actualTableName => 'times';
  @override
  VerificationContext validateIntegrity(Insertable<Time> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('descript')) {
      context.handle(_descriptMeta,
          descript.isAcceptableOrUnknown(data['descript']!, _descriptMeta));
    } else if (isInserting) {
      context.missing(_descriptMeta);
    }
    if (data.containsKey('start')) {
      context.handle(
          _startMeta, start.isAcceptableOrUnknown(data['start']!, _startMeta));
    } else if (isInserting) {
      context.missing(_startMeta);
    }
    if (data.containsKey('end')) {
      context.handle(
          _endMeta, end.isAcceptableOrUnknown(data['end']!, _endMeta));
    } else if (isInserting) {
      context.missing(_endMeta);
    }
    if (data.containsKey('create_at')) {
      context.handle(_createAtMeta,
          createAt.isAcceptableOrUnknown(data['create_at']!, _createAtMeta));
    } else if (isInserting) {
      context.missing(_createAtMeta);
    }
    if (data.containsKey('update_at')) {
      context.handle(_updateAtMeta,
          updateAt.isAcceptableOrUnknown(data['update_at']!, _updateAtMeta));
    } else if (isInserting) {
      context.missing(_updateAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Time map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Time.fromData(data, attachedDatabase,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $TimesTable createAlias(String alias) {
    return $TimesTable(attachedDatabase, alias);
  }
}

abstract class _$Database extends GeneratedDatabase {
  _$Database(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $TimesTable times = $TimesTable(this);
  late final TimeDao timeDao = TimeDao(this as Database);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [times];
}
