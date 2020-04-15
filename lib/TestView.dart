import 'package:flutter/material.dart';
import "TierUtilities.dart";

class TestView extends StatelessWidget {
  int result1;
  TestView(this.result1);
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.green,
      ),
      body:  new Container(
        alignment: AlignmentDirectional.center,
        padding: const EdgeInsets.all(8.0),
        height: 500.0,
        width: 500.0,
        // alignment: FractionalOffset.center,
        child: Column(
          children: <Widget>[
            SizedBox(height: 10),
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
            SizedBox(height: 20),
            Text("Testing is indicated according to current guidelines.",
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center),
            Text("This patient is Tier " + which_tier(result1) + ".",
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center),
            Spacer(),
            RaisedButton(
              color: Colors.green,
              child: Text("Go back to main screen", style: TextStyle(color: Colors.white),),
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