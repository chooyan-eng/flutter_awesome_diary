import 'package:awesome_diary/diary_provider.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class CreateDiary extends StatefulWidget {

  final Diary baseDiary;

  CreateDiary({
    Key key,
    this.baseDiary,
  }) : super(key: key);

  @override
  _CreateDiaryState createState() => _CreateDiaryState();
}

class _CreateDiaryState extends State<CreateDiary> {

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
    await provider.close();

    if (insertedDiary.id != null) {
      Toast.show('日記を保存しました', context);
      Navigator.pop(context);
    } else {
      Toast.show('日記の保存に失敗しました', context);
    }
  }

  Future<void> _update(BuildContext context) async {
    final provider = DiaryProvider();
    await provider.open();
    final updatedCount = await provider.update(Diary(
      id: widget.baseDiary.id,
      title: _titleEditController.text,
      body: _bodyEditController.text,
      createdAt: widget.baseDiary.createdAt,
    ));
    await provider.close();

    if (updatedCount > 0) {
      Toast.show('日記を更新しました', context);
      Navigator.pop(context);
    } else {
      Toast.show('日記の更新に失敗しました', context);
    }
  }

  @override
  void initState() {
    if (widget.baseDiary != null) {
      _titleEditController.text = widget.baseDiary.title;
      _bodyEditController.text = widget.baseDiary.body;
    }
    super.initState();
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
                onPressed: () {
                  if (widget.baseDiary == null) {
                    _save(context);
                  } else {
                    _update(context);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
