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
    "Self-quarantine for 7 days and may discontinue quarantine 7 days or longer since the date of their first positive COVID-19 diagnostic test (provided they remain asymptomatic). \n\n" +
    "However, for 3 days (72hrs) following discontinuation of quarantine, these persons should continue to limit contact (stay 6 feet away from others) and limit potential of dispersal of respiratory secretions by wearing a covering for their nose and mouth whenever they are in settings where other people are present.\n\n" +
    "In community settings, this covering may be a barrier mask, such as a bandana, scarf, or cloth mask. The covering does not refer to a medical mask or respirator",
    "In All counties except for Santa Clara COVID+ patients are no longer considered contagious if the following criteria are fulfilled: " +
    "A. At least 7 days have passed since symptoms first appeared\n" +
    "B. At least 3 days (72 hours) have passed since recovery (defined as resolution of fever without the use of fever-reducing medications and improvement in respiratory symptoms= cough, shortness of breath) AND\n" +
    "C. Must remain quarantined for whichever period (A or A+B) is longer\n\n" +
    "In Santa Clara County, COVID + patients are no longer considered contagious if the following criteria are fulfilled: \n"
    "A. 14 days after the date of their positive test result OR\n"
    "B. Until 7 days after fever is gone and other symptoms are improving AND\n"
    "C.  Must remain quarantined for whichever period (A or A+B) is longer\n\n"
    "Caveat: In Fresno County, COVID+  patients in sensitive occupations or situations(EMS, residents in LTCF, hospice patients, dialysis patients, caring for infants ( < 6 months of age), immunocompromised patients, patients required hospitalization):  are no longer considered contagious if the following criteria are fulfilled: \n" +
    "A. At least 14 days have passed since symptoms first appeared\n" +
    "B. At least 7 days have passed since recovery defined as resolution of fever without the use of fever-reducing medications and improvement in respiratory symptoms (e.g., cough, shortness of breath); and,\n" +
    "C. And must remain quarantine for whichever period (A or A+B) is longer"
  ];
  static List<String> at_risk_travel = [
    "Self-quarantine for 14 days from date of departure and actively monitor twice a day for fever.",
    "Self-quarantine until the following conditions are met:\n"+
    "A. At least 7 days have passed since symptoms first appeared\n" +
    "B. At least 3 days (72 hours) have passed since recovery (defined as resolution of fever without the use of fever-reducing medications and improvement in respiratory symptoms= cough, shortness of breath) AND\n" +
    "C. Must remain quarantined for whichever period (A or A+B) is longer"
  ];
  static List<String> at_risk_living = [
    "Non-household close contact, self-quarantine for 14 days since the last (finite) exposure to the ill contact. \n\n" +
    "Household close contact: the isolation recommendation is less clear as the close contact with the COVID + case can be going.  In this scenario, use the period of time the COVID + person is no longer contagious. This depends on county. See ISO GRID above.\n\n" +
    "Caveat: caretaker for COVID+ patients including those discharged from the hospital. These patients need caretaking; if close contact is a caretaker of a COVID + patient, then home isolate to the degree possible, and can leave the home to get medications, supplies, etc",
    "A. At least 7 days have passed since symptoms first appeared\n" +
    "B. At least 3 days (72 hours) have passed since recovery (defined as resolution of fever without the use of fever-reducing medications and improvement in respiratory symptoms= cough, shortness of breath) AND\n" +
    "C. Must remain quarantined for whichever period (A or A+B) is longer"
  ];
  static List<String> at_risk_high_risk = [
    "Home isolation",
    "If not tested but high clinical suspicion for COVID19, then quarantine for:\n" +
    "A. At least 7 days have passed since symptoms first appeared" +
    "B. At least 3 days (72 hours) have passed since recovery (defined as resolution of fever without the use of fever-reducing medications and improvement in respiratory symptoms= cough, shortness of breath) AND\n" +
    "C. Must remain quarantined for whichever period (A or A+B) is longer"
  ];
  static List<String> at_risk_high_transmission = [
    "Home isolation vs social distancing depending on workplace policy",
    "Self-quarantine. At least 3 days (72 hours) have passed since recovery (defined as resolution of fever without the use of fever-reducing medications and improvement in respiratory symptoms= cough, shortness of breath)."
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
//            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 50),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                child: Text(advice, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 25.0), textAlign: TextAlign.left),
              ),
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
