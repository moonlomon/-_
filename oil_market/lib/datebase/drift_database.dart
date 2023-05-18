import 'package:oil_market/models/schedule.dart';

import 'dart:io';
import 'package:drift/drift.dart'; // dart언어로 sql 작성
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart'; // 앱 내에 자동배정된 파일(폴더)경로를 가져옴
import 'package:path/path.dart' as p; // 경로를 숏컷으로 합칠 수 있음

// private값까지 불러올 수 있음.
part 'drift_database.g.dart'; // part 파일 지정(생성)

@DriftDatabase( // 사용할 테이블 등록
  tables: [
    Schedules,
  ],
)

class LocalDataBase extends _$LocalDataBase {
  LocalDataBase() : super(_openConnection());

  // SELECT
  Stream<List<Schedule>> watchSchedules(DateTime date) =>
      (select(schedules)..where((tbl) => tbl.date.equals(date))).watch(); //get->일회성 가져오기, watch->업데이트마다 가져오기

  // INSERT : 자동으로 만들어진 Companion클래스를 통해서 값들을 넣어줘야 함
  Future<int> createSchedule(SchedulesCompanion data) =>
      into(schedules).insert(data);

  Future<int> removeSchedule(int id) =>
      (delete(schedules)..where((tbl) => tbl.id.equals(id))).go();

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {

    final dbFolder = await getApplicationDocumentsDirectory(); // 앱내에 자동배정된 폴더의 경로를 가져옴
    final file = File(p.join(dbFolder.path, 'db.splite'));
    return NativeDatabase(file); // ??
  });
}