import 'package:awesome_diary/create_diary.dart';
import 'package:awesome_diary/diary_provider.dart';
import 'package:awesome_diary/diary_detail.dart';
import 'package:awesome_diary/diary_list_item.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class DiaryList extends StatefulWidget {
  @override
  _DiaryListState createState() => _DiaryListState();
}

class _DiaryListState extends State<DiaryList> {
  final _diaryList = [];

  @override
  void initState() {
    _updateList();
    super.initState();
  }

  Future<void> _updateList() async {
    _diaryList.clear();

    final provider = DiaryProvider();
    await provider.open();
    final savedDiaryList = await provider.getAll();
    await provider.close();
    setState(() {
      _diaryList.addAll(savedDiaryList);
    });
  }

  Future<void> _edit(Diary diary) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => CreateDiary(
                baseDiary: diary,
              )),
    );
    await _updateList();
  }

  Future<void> _delete(Diary diary) async {
    final provider = DiaryProvider();
    await provider.open();
    final deletedItemCount = await provider.delete(diary.id);
    await provider.close();

    if (deletedItemCount > 0) {
      Toast.show('日記を削除しました。', context);
      await _updateList();
    } else {
      Toast.show('日記を削除できませんでした。', context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('日記一覧'),
      ),
      body: ListView.builder(
        itemCount: _diaryList.length,
        itemBuilder: (context, index) => DiaryListItem(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DiaryDetail(
                  diary: _diaryList[index],
                ),
              ),
            );
          },
          onLongPress: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text('日記のメニュー'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                        _edit(_diaryList[index]);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: double.infinity,
                          child: Text(
                            '変更',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                        _delete(_diaryList[index]);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: double.infinity,
                          child: Text(
                            '削除',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          diary: _diaryList[index],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateDiary()),
          );
          await _updateList();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
