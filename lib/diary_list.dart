import 'package:awesome_diary/diary.dart';
import 'package:awesome_diary/diary_list_item.dart';
import 'package:flutter/material.dart';

class DiaryList extends StatefulWidget {
  @override
  _DiaryListState createState() => _DiaryListState();
}

class _DiaryListState extends State<DiaryList> {
  final _diaryList = <Diary>[
    Diary.sample(),
    Diary.sample(),
    Diary.sample(),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _diaryList.length,
      itemBuilder: (context, index) => InkWell(
        onTap: () {
          
        },
        child: DiaryListItem(
          diary: _diaryList[index],
        ),
      ),
    );
  }
}
