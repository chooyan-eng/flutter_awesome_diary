import 'package:awesome_diary/diary_provider.dart';
import 'package:flutter/material.dart';

class DiaryListItem extends StatelessWidget {
  final Diary diary;

  const DiaryListItem({
    Key key,
    this.diary,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            diary.title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(diary.body),
        ],
      ),
    );
  }
}
