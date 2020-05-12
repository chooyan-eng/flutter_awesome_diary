import 'package:awesome_diary/create_diary.dart';
import 'package:awesome_diary/diary.dart';
import 'package:awesome_diary/diary_detail.dart';
import 'package:awesome_diary/diary_list.dart';
import 'package:awesome_diary/diary_list_item.dart';
import 'package:awesome_diary/stateful_widget_page.dart';
import 'package:awesome_diary/stateless_widget_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: DiaryList(),
    );
  }
}
