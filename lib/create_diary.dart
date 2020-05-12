import 'dart:io';

import 'package:awesome_diary/diary_provider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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

  File _imageFile;

  Future<void> _pickupImage() async {
    final pickupImageFile = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _imageFile = pickupImageFile;
    });
  }

  Future<void> _save(BuildContext context) async {
    final provider = DiaryProvider();
    await provider.open();
    final insertedDiary = await provider.insert(Diary(
      title: _titleEditController.text,
      body: _bodyEditController.text,
      imageFile: _imageFile,
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
      imageFile: _imageFile,
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
      setState(() {
        _imageFile = widget.baseDiary.imageFile;
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
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
                child: Container(
                  width: MediaQuery.of(context).size.width / 2,
                  child: _imageFile == null ? SizedBox.shrink() : Image.file(_imageFile),
                ),
              ),
              const SizedBox(height: 8),
              InkWell(
                onTap: _pickupImage,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('画像を選択する'),
                      const SizedBox(width: 16),
                      Icon(Icons.photo_library),
                    ],
                  ),
                ),
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
      ),
    );
  }
}
