import 'package:flutter/material.dart';

class DoNotTestView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(),
      body:  new Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8.0),
        height: 500.0,
        width: 500.0,
        child: Column(
          children: <Widget>[
            SizedBox(height: 10),
            Align(
              alignment: Alignment.center,
              child: new Stack(
                alignment: AlignmentDirectional.center,
                children: <Widget>[
                  new Circle(Colors.red),
                  Icon(
                      Icons.clear,
                      color: Colors.white,
                      size: 200.0
                  )
                ],
              ),
            ),
            SizedBox(height: 20),
            Text("Test is NOT indicated at this time per current guidelines.",
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center),
            Spacer(),
            RaisedButton(
              color: Colors.red,
              child: Text("Go back to main screen", style: TextStyle(color: Colors.white)),
              onPressed: () {
                Navigator.popUntil(context, (Route<dynamic> route) => route.isFirst);
              },
            )
          ],
        )
      ),
    );
  }
}

class Circle extends StatelessWidget {
  Color circleColor;
  Circle(this.circleColor);
  @override
  Widget build(BuildContext context) {
    double size = 250.0;
    return new InkResponse(
      child: new Container(
        width: size,
        height: size,
        decoration: new BoxDecoration(
          color: circleColor,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}