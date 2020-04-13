import 'package:flutter/material.dart';

class TestView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(),
      body:  new Container(
        alignment: AlignmentDirectional.center,
        padding: const EdgeInsets.all(8.0),
        height: 500.0,
        width: 500.0,
        // alignment: FractionalOffset.center,
        child: Column(
          children: <Widget>[
            new Stack(
              alignment: AlignmentDirectional.center,
              children: <Widget>[
                new Circle(Colors.green),
                Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 200.0,
                )
              ],
            ),
            Text("Test this patient, according to current guidelines."),
            Spacer(),
            RaisedButton(
              child: Text("Go back to main screen"),
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