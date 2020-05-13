import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

final String tableDiary = 'diary';
final String columnId = '_id';
final String columnTitle = 'title';
final String columnBody = 'body';
final String columnImageFile = 'image_file';
final String columnCreatedAt = 'created_at';

class Diary {
  int id;
  final String title;
  final String body;
  final File imageFile;
  final DateTime createdAt;

  Diary({
    this.id,
    this.title,
    this.body,
    this.imageFile,
    this.createdAt,
  });

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnTitle: title,
      columnBody: body,
      columnImageFile: imageFile?.path?.split('/')?.last,
      columnCreatedAt: createdAt.millisecondsSinceEpoch,
    };
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }

  factory Diary.fromMap(Map<String, dynamic> map, String documentDirectoryPath) {
    return Diary(
      id: map[columnId],
      title: map[columnTitle],
      body: map[columnBody],
      imageFile: map[columnImageFile] != null ? File('$documentDirectoryPath/${map[columnImageFile]}') : null,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map[columnCreatedAt]),
    );
  }

  factory Diary.sample() {
    return Diary(
      id: -1,
      title: 'Flutterはじめました',
      body: 'TechPitでFlutterの勉強をスタートしました。まずは宣言的UIから勉強中。',
      imageFile: null,
      createdAt: DateTime.now(),
    );
  }
}

class DiaryProvider {
  Database db;

  Future open() async {
    db = await openDatabase(
      'awesome_diary',
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
          '''
            create table $tableDiary ( 
              $columnId integer primary key autoincrement, 
              $columnTitle text not null,
              $columnBody text not null,
              $columnImageFile text,
              $columnCreatedAt integer not null
            )
          ''',
        );
      },
    );
  }

  Future<Diary> insert(Diary diary) async {
    diary.id = await db.insert(tableDiary, diary.toMap());
    return diary;
  }

  Future<Diary> getDiary(int id) async {
    List<Map> maps = await db.query(
      tableDiary,
      columns: [
        columnId,
        columnTitle,
        columnBody,
        columnImageFile,
        columnCreatedAt,
      ],
      where: '$columnId = ?',
      whereArgs: [id],
    );
    if (maps.length > 0) {
      return Diary.fromMap(maps.first, (await getApplicationDocumentsDirectory()).path);
    }
    return null;
  }

  Future<List<Diary>> getAll() async {
    List<Map> maps = await db.query(
      tableDiary,
      columns: [
        columnId,
        columnTitle,
        columnBody,
        columnImageFile,
        columnCreatedAt,
      ],
    );
    final documentDirectoryPath = (await getApplicationDocumentsDirectory()).path;
    return maps.map<Diary>((diaryMap) => Diary.fromMap(diaryMap, documentDirectoryPath)).toList();
  }

  Future<int> delete(int id) async {
    return await db.delete(tableDiary, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> update(Diary diary) async {
    return await db.update(tableDiary, diary.toMap(),
        where: '$columnId = ?', whereArgs: [diary.id]);
  }

  Future close() async => db.close();
}
