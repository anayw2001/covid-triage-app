import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'DoNotTestView.dart';
import 'TestView.dart';
import 'TierUtilities.dart';
import 'YesNoView.dart';

class QuestionOne extends StatelessWidget {
  List<String> jobs_table = TierConstants().jobs;
  @override Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        title: Text(""),
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: Container(
          child: Column(
            children: <Widget>[
              SizedBox(height: 10),
              Text("Choose the option that most accurately describes your patient.", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 25.0), textAlign: TextAlign.center),
              SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: jobs_table.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(jobs_table[index]),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => QuestionTwo(index + 1)));
                      },
                    );
                  },
                ),
              )
            ],
          ),
        )
      ),
    );
  }
}

class QuestionTwo extends StatelessWidget {
  int result1;
  QuestionTwo(this.result1);
  List<String> time_table = TierConstants().times;
  Widget get_destination_one() {
    if (is_tier1a(this.result1) || is_tier2b(this.result1)) {
      return QuestionThree(result1, 2);
    } else {
      return DoNotTestView();
    }
  }

  Widget get_destination_two() {
    if (is_tier1c(result1) || is_tier2a(result1)) { // t1c
      return QuestionFive(result1, 3);
    } else if (is_tier1a(result1) || is_tier2b(result1)) {
      return QuestionThree(result1, 3);
    } else { // t1b/t2
      return QuestionFour(result1, 3);
    }
  }

  Widget get_destination_three() {
    if (is_tier2c(result1)) { // t1c
      return TestView(result1);
    } else { // t1b/t2
      return DoNotTestView();
    }
  }

  @override Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Text(""),
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: Container(
          child: Column(
            children: <Widget>[
              SizedBox(height: 10),
              Text("How long have symptoms been present?",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 25.0),
                textAlign: TextAlign.center),
              SizedBox(height: 10),
              ListView(
                shrinkWrap: true,
                children: <Widget>[
                  ListTile(
                    title: Text(time_table[0]),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => DoNotTestView()));
                    },
                  ),
                  ListTile(
                    title: Text(time_table[1]),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => get_destination_one()));
                    },
                  ),
                  ListTile(
                    title: Text(time_table[2]),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => get_destination_two()));
                    },
                  ),
                  ListTile(
                    title: Text(time_table[3]),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => get_destination_three()));
                    },
                  ),
                ],
              ),
            ],
          ),
        )
      ),
    );
  }
}

class QuestionThree extends StatelessWidget {
  int result1;
  int result2;
  QuestionThree(this.result1, this.result2);
  Widget get_positive_destination() {
    if (is_tier1a(result1) || is_tier2b(result1)) {
      return TestView(result1);
    } else if (is_tier3(result1)) {
      return QuestionNine(result1, result2);
    } else {
      return DoNotTestView();
    }
  }

  Widget get_negative_destination() {
    if (is_tier2b(result1)) {
      return QuestionFour(result1, result2);
    } else {
      return DoNotTestView();
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          title: Text(""),
          backgroundColor: Colors.white,
        ),
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(height:10),
            Text("Does the patient have a sore throat, runny nose, pernio, or cough?",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 25.0),
                textAlign:TextAlign.center),
            SizedBox(height: 10),
            Expanded(
              child: YesNoView(get_positive_destination(), get_negative_destination()),
            )
          ],
        ),
      )
    );
  }
}

class QuestionFour extends StatelessWidget {
  int result1;
  int result2;
  QuestionFour(this.result1, this.result2);
  Widget get_positive_destination() {
    if (is_tier3(result1)) {
      return QuestionThree(result1, result2);
    } else if (is_tier2b(result1)) {
      return TestView(result1);
    } else {
      return QuestionFive(result1, result2);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          backgroundColor: Colors.white,
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              SizedBox(height: 10),
              Text("Does the patient have a fever? (Subjective/100.4 degrees/night sweats/chills)",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 25.0),
                textAlign: TextAlign.center),
              Expanded(
                child: YesNoView(get_positive_destination(), DoNotTestView()),
              )
            ],
          ),
        )
    );
  }
}

class QuestionFive extends StatelessWidget {
  int result1;
  int result2;
  QuestionFive(this.result1, this.result2);
  Widget get_negative_destination() {
    if (is_tier1c(result1) || is_tier2a(result1)) {
      return DoNotTestView();
    } else {
      return QuestionSix(false, result1);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
          backgroundColor: Colors.white,
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              SizedBox(height: 10),
              Text("Does the patient have a cough?",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 25.0)),
              Expanded(
                child: YesNoView(TestView(result1), get_negative_destination()),
              )
            ],
          ),
        )
    );
  }
}

class QuestionSix extends StatelessWidget {
  int result1;
  bool result5;
  QuestionSix(this.result5, this.result1);
  Widget get_negative_destination() {
    if (result5) {
      return TestView(result1);
    } else {
      return DoNotTestView();
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
          backgroundColor: Colors.white,
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              SizedBox(height: 10),
              Text("Does the patient have SOB or myalgias?",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 25.0),
                  textAlign: TextAlign.center),
              Expanded(
                child: YesNoView(TestView(result1), get_negative_destination()),
              )
            ],
          ),
        )
    );
  }
}

class QuestionSeven extends StatefulWidget {
  int result1;
  QuestionSeven(this.result1);
  @override
  _QuestionSevenState createState() => _QuestionSevenState();
}

class _QuestionSevenState extends State<QuestionSeven> {
  int _currentAge = 60;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
          backgroundColor: Colors.white,
        ),
        body: Center(
            child: Column(
              children: <Widget>[
                SizedBox(height: 10),
                Text("How old is your patient?",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 25.0)),
                SizedBox(height: 50),
                new NumberPicker.integer(
                    initialValue: 60,
                    minValue: 1,
                    maxValue: 100,
                    onChanged: (newValue) =>
                        setState(() => _currentAge = newValue)),
                SizedBox(height: 10),
                Text("Current age: $_currentAge", style: TextStyle(fontSize: 20)),
                SizedBox(height: 30),
                RaisedButton(
                  color: Colors.red,
                  child: Text("Continue", style: TextStyle(color: Colors.white)),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder:(context) => QuestionEight(_currentAge, widget.result1)));
                  }
                )
              ],
            )
        )
    );
  }
}

class QuestionEight extends StatelessWidget {
  int result1;
  int result7;
  QuestionEight(this.result7, this.result1);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
          backgroundColor: Colors.white,
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                child: Text("Does the patient have diabetes or asthma/COPD/chronic lung disease, or heart disease CAD or CHF), or BMI >= 35?",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 25.0),
                    textAlign: TextAlign.center),
              ),
              Expanded(
                child: YesNoView(TestView(result1), DoNotTestView()),
              )
            ],
          ),
        )
    );
  }
}

class QuestionNine extends StatelessWidget {
  int result1;
  int result2;
  var clarifications = [
    "- Steroids >20mg (or > 0.5mg/kg/day in pediatrics) for > 2 weeks",
    "- On biologics or other steroid sparing immunomodulators (other than Plaquenil)",
    "- Chemotherapy for solid organ tumor or other malignancy less than 3 months ago",
    "- Hematologic malignancy not in remission",
    "- S/P autologous HSCT x 1 year, allogeneic HSCT until off immunosuppression x 1 year",
    "- Solid organ transplant recipient",
    "- Others: CVID, uncontrolled HIV, primary immunodeficiency"];
  List<Widget> _clarifications() {
    List<Widget> ret = <Widget>[];
    for (String clarification in clarifications) {
      ret.add(Text(clarification, textAlign: TextAlign.start, style: TextStyle(fontSize: 18)));
      ret.add(SizedBox(height:10));
    }
    return ret;
  }
  QuestionNine(this.result1, this.result2);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
          backgroundColor: Colors.white,
        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 10),
              Text("Is this patient immunocompromised?",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 25.0)),
              SizedBox(height:10),
              Expanded(
                flex: 0,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Column(
                    children: _clarifications(),
                  ),
                )
              ),
              Expanded(
                flex: 1,
                child: YesNoView(TestView(result1), QuestionSeven(result1)),
              )
            ],
          ),
        )
    );
  }
}