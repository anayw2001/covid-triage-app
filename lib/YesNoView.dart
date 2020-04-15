import 'package:flutter/material.dart';

class YesNoView extends StatelessWidget {
  Widget positiveDestination;
  Widget negativeDestination;
  YesNoView(this.positiveDestination, this.negativeDestination);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Row(
            children: <Widget>[
              Spacer(),
              RaisedButton(
                  color: Colors.red,
                  child: Text("Yes", style: TextStyle(color: Colors.white)),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => positiveDestination));
                  }
              ),
              Spacer(),
              RaisedButton(
                  color: Colors.red,
                  child: Text("No", style: TextStyle(color: Colors.white)),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => negativeDestination));
                  }
              ),
              Spacer(),
            ],
          ),
        )
    );
  }
}