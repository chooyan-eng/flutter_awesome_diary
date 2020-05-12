import 'package:flutter/material.dart';

class CreateDiary extends StatelessWidget {
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
            TextField(),
            const SizedBox(height: 16),
            Text(
              '本文',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            TextField(
              maxLines: 10,
            ),
            const SizedBox(height: 32),
            Center(
              child: RaisedButton(
                child: Text('保存'),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
