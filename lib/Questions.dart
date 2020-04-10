import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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
        title: Text("Question One"),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: jobs_table.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(jobs_table[index]),               
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => QuestionTwo(index)));
              },
            );
          },
        ),
      ),
    );
  }
}

class QuestionTwo extends StatelessWidget {
  int result1;
  QuestionTwo(this.result1);
  List<String> time_table = StrConstants().times;
  @override Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Question Two"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Text("How long have symptoms been present?"),
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
                    Navigator.push(context, MaterialPageRoute(builder: (context) => QuestionTwo(1)));
                  },
                ),
                ListTile(
                  title: Text(time_table[2]),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => QuestionTwo(2)));
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}