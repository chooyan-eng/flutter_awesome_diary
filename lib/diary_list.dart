import 'package:awesome_diary/create_diary.dart';
import 'package:awesome_diary/diary.dart';
import 'package:awesome_diary/diary_detail.dart';
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
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CreateDiary()
                  ),
                );
              },
              child: Icon(Icons.add),
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _diaryList.length,
        itemBuilder: (context, index) => InkWell(
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
          child: DiaryListItem(
            diary: _diaryList[index],
          ),
        ),
      ),
    );
  }
}
