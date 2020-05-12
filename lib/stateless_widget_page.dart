import 'package:flutter/material.dart';

class StatelessWidgetPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          'hello world!',
          style: TextStyle(
            fontSize: 32,
            color: Colors.blue,
          ),
        ),
      ),
    );
  }
}
