import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'DoNotTestView.dart';
import 'TestView.dart';

class StrConstants {
  List<int> tier1a = [1];
  List<int> tier1b = [2, 3, 4, 5, 6, 7];
  List<int> tier1c = [8, 9, 10];
  List<int> tier1d = [11];
  List<int> tier2 = [12];
  List<String> jobs = [
    "Patient-facing HCW or EMS or Non EMS First Responders (Police or Fire)", // T1A 0
    "Non patient-facing HCW/Medical facility EVS", // T1B 1
    "Resident of SNF, shelter, group home, jail", // T1B 3
    "Work in common areas of prisons/jails, as bus driver", // T1B 4
    "Frequent healthcare contact (e.g. dialysis patients, pregnant patients in third trimester)", // T1B 5
    "Bus driver/flight attendant, school/daycare teachers, postal workers", // T1B 6
    "Pregnant women over 24 weeks (not in labor, not being induced)", // T1B 7
    "Pregnant women at 36 weeks or later", // T1C 8
    "Preoperative patients.", // T1C 9
    "Dialysis patients.", // T1C 10
    "Caretaker of child less than 6 months of age", // T1D 11
    "Other"]; // T2 12
  List<String> times = ["Less than 24h", "24-48h", "48h+"];
}
class QuestionOne extends StatelessWidget {
  List<String> jobs_table = StrConstants().jobs;
  @override Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: Container(
          child: Column(
            children: <Widget>[
              SizedBox(height: 10),
              Text("What is your patient?", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 25.0)),
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
  List<String> time_table = StrConstants().times;
  Widget get_destination_one() {
    if (is_tier1a(this.result1) || is_tier1d(this.result1)) {
      return QuestionThree(result1, 2);
    } else {
      return DoNotTestView();
    }
  }

  Widget get_destination_two() {
    if (is_tier1c(result1)) { // t1c
      return QuestionFive(result1, 3);
    } else if (is_tier1a(result1) || is_tier1d(result1)) { // t1a/t1d
      return QuestionThree(result1, 3);
    } else { // t1b/t2
      return QuestionFour(result1, 3);
    }
  }
  @override Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
    if (is_tier1a(result1) || is_tier1d(result1)) {
      return TestView();
    } else if (is_tier2(result1)) {
      return QuestionNine(result1, result2);
    } else {
      return DoNotTestView();
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(""),
          backgroundColor: Colors.white,
        ),
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(height:10),
            Text("Does the patient have a sore throat, runny nose, or cough?",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 25.0),
                textAlign:TextAlign.center),
            SizedBox(height: 10),
            Expanded(
              child: YesNoView(get_positive_destination(), DoNotTestView()),
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
    if (is_tier2(result1)) {
      return QuestionThree(result1, result2);
    } else {
      return QuestionFive(result1, result2);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(""),
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
    if (is_tier1c(result1)) {
      return DoNotTestView();
    } else {
      return QuestionSix(false);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(""),
          backgroundColor: Colors.white,
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              SizedBox(height: 10),
              Text("Does the patient have a cough?",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 25.0)),
              Expanded(
                child: YesNoView(TestView(), get_negative_destination()),
              )
            ],
          ),
        )
    );
  }
}

class QuestionSix extends StatelessWidget {
  bool result5;
  QuestionSix(this.result5);
  Widget get_negative_destination() {
    if (result5) {
      return TestView();
    } else {
      return DoNotTestView();
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              SizedBox(height: 10),
              Text("Does the patient have SOB or myalgias?",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 25.0)),
              Expanded(
                child: YesNoView(TestView(), get_negative_destination()),
              )
            ],
          ),
        )
    );
  }
}

class QuestionSeven extends StatefulWidget {
  @override
  _QuestionSevenState createState() => _QuestionSevenState();
}

class _QuestionSevenState extends State<QuestionSeven> {
  int _currentAge = 65;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(""),
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
                    initialValue: 65,
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
                    Navigator.push(context, MaterialPageRoute(builder:(context) => QuestionEight(_currentAge)));
                  }
                )
              ],
            )
        )
    );
  }
}

class QuestionEight extends StatelessWidget {
  int result7;
  QuestionEight(this.result7);
  Widget get_positive_destination() {
    if (result7 >= 65) {
      return TestView();
    } else {
      return DoNotTestView();
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(""),
          backgroundColor: Colors.white,
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                child: Text("Does the patient have diabetes or asthma/COPD/chronic lung disease, or heart disease CAD or CHF), or morbid obesity?",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 25.0),
                    textAlign: TextAlign.center),
              ),
              Expanded(
                child: YesNoView(get_positive_destination(), DoNotTestView()),
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
          title: Text(""),
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
                child: YesNoView(TestView(), QuestionSeven()),
              )
            ],
          ),
        )
    );
  }
}

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

bool is_tier1a(int i) {
  return StrConstants().tier1a.contains(i);
}

bool is_tier1b(int i) {
  return StrConstants().tier1b.contains(i);
}

bool is_tier1c(int i) {
  return StrConstants().tier1c.contains(i);
}

bool is_tier1d(int i) {
  return StrConstants().tier1d.contains(i);
}

bool is_tier2(int i) {
  return StrConstants().tier2.contains(i);
}