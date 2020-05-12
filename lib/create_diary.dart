import 'package:awesome_diary/diary_provider.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class CreateDiary extends StatelessWidget {

  final _titleEditController = TextEditingController();
  final _bodyEditController = TextEditingController();

  Future<void> _save(BuildContext context) async {
    final provider = DiaryProvider();
    await provider.open();
    final insertedDiary = await provider.insert(Diary(
      title: _titleEditController.text,
      body: _bodyEditController.text,
      createdAt: DateTime.now(),
    ));

    if (insertedDiary.id != null) {
      Toast.show('日記を保存しました', context);
      Navigator.pop(context);
    } else {
      Toast.show('日記の保存に失敗しました', context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('日記を書く'),
            const SizedBox(height: 32),
            Text(
              'タイトル',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            TextField(
              controller: _titleEditController,
            ),
            const SizedBox(height: 16),
            Text(
              '本文',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            TextField(
              controller: _bodyEditController,
              maxLines: 10,
            ),
            const SizedBox(height: 32),
            Center(
              child: RaisedButton(
                child: Text('保存'),
                onPressed: () => _save(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
