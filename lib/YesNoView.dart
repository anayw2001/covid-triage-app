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
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                    child: Text("Yes", style: TextStyle(color: Colors.white, fontSize: 36.0)),
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => positiveDestination));
                  }
              ),
              Spacer(),
              RaisedButton(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                    child: Text("No", style: TextStyle(color: Colors.white, fontSize: 36.0)),
                  ),
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