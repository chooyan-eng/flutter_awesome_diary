import 'package:sqflite/sqflite.dart';

final String tableDiary = 'diary';
final String columnId = '_id';
final String columnTitle = 'title';
final String columnBody = 'body';
final String columnCreatedAt = 'created_at';

class Diary {
  int id;
  final String title;
  final String body;
  final DateTime createdAt;

  Diary({
    this.id,
    this.title,
    this.body,
    this.createdAt,
  });

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnTitle: title,
      columnBody: body,
      columnCreatedAt: createdAt.millisecondsSinceEpoch,
    };
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }

  factory Diary.fromMap(Map<String, dynamic> map) {
    return Diary(
      id: map[columnId],
      title: map[columnTitle],
      body: map[columnBody],
      createdAt: DateTime.fromMillisecondsSinceEpoch(map[columnCreatedAt]),
    );
  }

  factory Diary.sample() {
    return Diary(
      id: -1,
      title: 'Flutterはじめました',
      body: 'TechPitでFlutterの勉強をスタートしました。まずは宣言的UIから勉強中。',
      createdAt: DateTime.now(),
    );
  }
}

class DiaryProvider {
  Database db;

  Future open(String path) async {
    db = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
          '''
            create table $tableDiary ( 
              $columnId integer primary key autoincrement, 
              $columnTitle text not null,
              $columnBody text not null,
              $columnCreatedAt integer not null,
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
        columnCreatedAt,
      ],
      where: '$columnId = ?',
      whereArgs: [id],
    );
    if (maps.length > 0) {
      return Diary.fromMap(maps.first);
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
        columnCreatedAt,
      ],
    );
    return maps.map<Diary>((diaryMap) => Diary.fromMap(diaryMap)).toList();
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
