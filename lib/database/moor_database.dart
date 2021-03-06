import 'package:moor_flutter/moor_flutter.dart';
part 'moor_database.g.dart';

class TreesTable extends Table {
  // autoincrement sets this to the primary key
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 5, max: 50)();
  TextColumn get image => text()();
  TextColumn get description => text()();
}

class GardeningTable extends Table {
  // autoincrement sets this to the primary key
  IntColumn get id => integer().autoIncrement()();
  TextColumn get description => text()();
  TextColumn get alarmTime => text()();
}

class NotifyTable extends Table {
  // autoincrement sets this to the primary key
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().withLength(min: 5, max: 50)();
  TextColumn get name => text().withLength(min: 1, max: 50)();
  TextColumn get image => text()();
  TextColumn get description => text()();
}

@UseMoor(tables: [TreesTable, GardeningTable, NotifyTable])
class AppDatabase extends _$AppDatabase {
  AppDatabase()
      : super(FlutterQueryExecutor.inDatabaseFolder(
      path: 'db.sqlite', logStatements: true));

  @override
  int get schemaVersion => 1;

  Future<List<TreesTableData>> getAllMedicines() => select(treesTable).get();
  Future insertTree(TreesTableData medicine) =>
      into(treesTable).insert(medicine);
  Future updateTree(TreesTableData medicine) =>
      update(treesTable).replace(medicine);
  Future deleteTree(TreesTableData medicine) =>
      delete(treesTable).delete(medicine);

  Future<List<GardeningTableData>> getAllGardening() =>
      select(gardeningTable).get();
  Future insertGarden(GardeningTableData garden) =>
      into(gardeningTable).insert(garden);
  Future updateGarden(GardeningTableData garden) =>
      update(gardeningTable).replace(garden);
  Future deleteGarden(GardeningTableData garden) =>
      delete(gardeningTable).delete(garden);

  Future<List<NotifyTableData>> getAllNotification() => select(notifyTable).get();
  Future insertNotification(NotifyTableData notify) =>
      into(notifyTable).insert(notify);
  Future updateNotification(NotifyTableData notify) =>
      update(notifyTable).replace(notify);
  Future deleteNotification(NotifyTableData notify) =>
      delete(notifyTable).delete(notify);
}
