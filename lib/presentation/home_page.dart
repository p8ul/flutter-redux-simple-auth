import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Home Page'),
        ),
        body: Container(
          padding: EdgeInsets.all(23.2),
            child: Column(
          children: <Widget>[
            Text('Home page....'),
            SizedBox(
                width: double.infinity,
                child: OutlineButton(
                  child: new Text(
                    'OPEN PROTECTED',
                    style: TextStyle(color: Colors.black),
                  ),
                  borderSide: BorderSide(color: Colors.black),
                  color: Colors.transparent,
                  shape: StadiumBorder(),
                  onPressed: () {
                    Navigator.pushNamed(context, '/protected');
                  },
                ))
          ],
        )),
      ),
    );
  }
}
