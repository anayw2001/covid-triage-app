import 'package:flutter/material.dart';
import 'YesNoView.dart';

class hcwStrings {
  static List<String> scenarios = [
    "No symptoms",
    "If the patient has the slightest signs of illness",
    "If symptoms for <= 24 hours (no fever and URI Sx (sore throat and/or rhinorrhea and/or cough))",
    "If symptoms for >= 24 hours (fever and ILI (cough or SOB and/or myalgia and/or sore throat))"
  ];

  static List<String> advice = [
    "Self-monitor and continue working, notify employee health.",
    "Stay at home, and report to manager/chief. If symptoms resolve in <24 hours, then may return to work 72 hours after symptom resolution",
    "Stay at home, self-isolate. If symptoms improve, may return to work after symptom resolution for 72 hours.",
    "Stay at home, self-isolate, and get tested."
  ];

  static List<String> advice_test_results = [
    "Self isolate at home for 7 days from onset of symptoms or 72 hours after resolution of symptoms, whichever is longer",
    "Remain isolated until resolution of symptoms for 72 hours",
    "Return to work after resolution of symptoms for 48 hours"
  ];
}

class nonHcwStrings {
  static List<String> confirmed = [
    "Self-quarantine and actively monitor for 14 days",
    "Self-quarantine for 7 days after symptom onset and 3 days after symptom resolution, whichever is longer."
  ];
  static List<String> at_risk_travel = [
    "Self-quarantine for 14 days from date of departure",
    "Self-quarantine for 7 days after symptom onset and 3 days after symptom resolution, whichever is longer. (also, need minimum of 14 days from return)"
  ];
  static List<String> at_risk_living = [
    "Self-quarantine for 14 days from date of last contact",
    "Self-quarantine for 7 days after symptom onset and 3 days after symptom resolution (also need a minimum of 14 days from last exposure to sick person), whichever is longer."
  ];
  static List<String> at_risk_high_risk = [
    "Home isolation",
    "Self-quarantine for 3 days after symptom resolution"
  ];
  static List<String> at_risk_high_transmission = [
    "Home isolation vs social distancing depending on workplace policy",
    "Self-quarantine for 3 days after symptom resolution"
  ];
}

class IsolationGridFilter extends StatelessWidget {
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
        child: Container(
          child: Column(
            children: <Widget>[
              SizedBox(height: 10),
              Text("Is your patient a healthcare worker?", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 25.0)),
              Spacer(),
              Expanded(
                child: YesNoView(QuestionTwo(true), QuestionTwo(false)),
              )
            ],
          )
        )
      )
    );
  }
}

class QuestionTwo extends StatelessWidget {
  bool result1;
  QuestionTwo(this.result1);
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
              Text("Is your patient symptomatic?", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 25.0)),
              Spacer(),
              Expanded(
                child: YesNoView(QuestionThree(result1, true), QuestionThree(result1, false)),
              )
            ],
          ),
        )
    );
  }
}

class QuestionThree extends StatelessWidget {
  bool result1;
  bool result2;
  QuestionThree(this.result1, this.result2);
  String getText() {
    if (result1) {
      return "Has your patient gotten tested?";
    } else {
      return "Is your patient a laboratory-confirmed case?";
    }
  }
  Widget getPositiveDestination() {
    if (!result1 && result2) {
      return FinishingView(nonHcwStrings.confirmed[1]);
    } else if (!result1 && !result2) {
      return FinishingView(nonHcwStrings.confirmed[0]);
    } else {
      return QuestionFourHCWTested();
    }
  }
  Widget getNegativeDestination() {
    if (result1) {
      return QuestionFourHCWUntested(result1, result2, false);
    } else {
      return QuestionFourNonHCW(result1, result2, false);
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
              Text(getText(), style: TextStyle(fontWeight: FontWeight.w600, fontSize: 25.0), textAlign: TextAlign.center),
              Spacer(),
              Expanded(
                child: YesNoView(getPositiveDestination(), getNegativeDestination()),
              )
            ],
          ),
        )
    );
  }
}

class QuestionFourNonHCW extends StatelessWidget {
  bool result1, result2, result3;
  QuestionFourNonHCW(this.result1, this.result2, this.result3);
  Widget getFinalView(List<String> from) {
    if (result2) {
      return FinishingView(from[1]);
    } else {
      return FinishingView(from[0]);
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
            Text("Pick the option that most accurately describes the patient."),
            SizedBox(height: 10),
            ListView(
              shrinkWrap: true,
              children: <Widget>[
                ListTile(
                  title: Text("Travel from level 3 country"),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => getFinalView(nonHcwStrings.at_risk_travel)));
                  },
                ),
                ListTile(
                  title: Text("Living in the same household as an intimate partner of, or caring for a person in a nonhealthcare setting to a person with symptomatic laboratory-confirmed COVID-19 infection for home care and home isolation"),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => getFinalView(nonHcwStrings.at_risk_living)));
                  },
                ),
                ListTile(
                  title: Text("Persons at high risk of COVID \n" +
                      "- Age 65+ \n" +
                      "Persons aged 18-65 with comorbidities"),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => getFinalView(nonHcwStrings.at_risk_high_risk)));
                  },
                ),
                ListTile(
                  title: Text("Persons living in areas with community transmission"),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => getFinalView(nonHcwStrings.at_risk_high_transmission)));
                  },
                ),
              ],
            ),
          ],
        )
      )
    );
  }
}

class QuestionFourHCWUntested extends StatelessWidget {
  bool result1, result2, result3;
  QuestionFourHCWUntested(this.result1, this.result2, this.result3);
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
            Text("Choose the option that most accurately describes your patient.", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 25.0), textAlign: TextAlign.center),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: hcwStrings.scenarios.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(hcwStrings.scenarios[index]),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => FinishingView(hcwStrings.advice[index])));
                    },
                  );
                },
              ),
            )
          ],
        )
      )
    );
  }
}

class QuestionFourHCWTested extends StatelessWidget {
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
                Text("Did your patient test positive?", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 25.0), textAlign: TextAlign.center),
                Spacer(),
                Expanded(
                  child: YesNoView(FinishingView(hcwStrings.advice_test_results[0]), FinishingView(hcwStrings.advice_test_results[2]))
                )
              ],
            )
        )
    );
  }
}

class FinishingView extends StatelessWidget {
  String advice;
  FinishingView(this.advice);
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
              SizedBox(height: 50),
              Text(advice, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 25.0), textAlign: TextAlign.center),
              SizedBox(height: 60),
              RaisedButton(
                color: Colors.red,
                child: Text("Go back to main screen.", style: TextStyle(color: Colors.white)),
                onPressed: () {
                  Navigator.popUntil(context, (Route<dynamic> route) => route.isFirst);
                },
              )
            ],
          ),
        )
    );
  }
}
