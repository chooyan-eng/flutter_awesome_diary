import 'package:flutter/material.dart';

class StatefulWidgetPage extends StatefulWidget {
  @override
  _StatefulWidgetPageState createState() => _StatefulWidgetPageState();
}

class _StatefulWidgetPageState extends State<StatefulWidgetPage> {
  var text = 'Hello World!';
  var textColor = Colors.black;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Text(
              text,
              style: TextStyle(color: textColor),
            ),
            RaisedButton(
              child: Text('Button'),
              onPressed: () {
                setState(() {
                  text = 'Button is pressed!';
                  textColor = Colors.blue;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
