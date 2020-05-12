import 'package:awesome_diary/diary_provider.dart';
import 'package:flutter/material.dart';

class DiaryDetail extends StatelessWidget {
  final Diary diary;

  const DiaryDetail({
    Key key,
    this.diary,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              diary.title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text(diary.body),
            const SizedBox(height: 16),
            Container(
              width: MediaQuery.of(context).size.width,
              child: diary.imageFile == null ? SizedBox.shrink() : Image.file(diary.imageFile),
            ),
          ],
        ),
      ),
    );
  }
}
