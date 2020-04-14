class TierConstants {
  List<int> tier1a = [1, 2, 3];
  List<int> tier1b = [4, 5, 6, 7];
  List<int> tier1c = [8];
  List<int> tier2a = [9];
  List<int> tier2b = [10, 11, 12, 13, 14, 15, 16];
  List<int> tier2c = [17, 18, 19, 20, 21, 22];
  List<int> tier3 = [23];
  List<String> jobs = [
    // T1A
    "Patient-facing HCW or EMS or Non EMS First Responders (Police or Fire)", // 1
    "Dialysis patients.", // 2
    "Resident of SNF, shelter, group home, jail", // 3
    // T1B
    "Non patient-facing HCW/Medical facility EVS", // 4
    "Work in common areas of prisons/jails, as bus driver", // 5
    "Bus driver/flight attendant, school/daycare teachers, postal workers", // 6
    "Pregnant women over 24 weeks (not in labor, not being induced)", // 7
    // T1C
    "Caretaker of child less than 6 months of age", // 8
    // T2A
    "Pregnant women at 36 weeks or later", // 9
    // T2B
    "Any surgical procedure for which delay would cause harm", // 10
    "Symptoms in someone who needs to continue cancer therapy", // 11
    "Neutropenia", // 12
    "Chemotherapy for solid organ tumor or other malignancy less than 3 months ago", // 13
    "Hematologic malignancy not in remission", // 14
    "S/P autologous HSCT x 1 year, allogeneic HSCT until off immunosuppresion x 1 year", // 15
    "Solid organ transplant recipient", // 16
    // T2C
    "Urgent ENT surgeries", // 17
    "Urgent neurosurgical procedures requiring a trans-sphenoidal approach", // 18
    "Urgent cardiac surgery", // 19
    "Urgent thoracic surgery", // 20
    "Patients coming from SNFs who will be undergoing surgery", // 21
    "Patients scheduled for induction or c-section testing can be ordered w/o COVID triage approval", // 22
    // T3
    "Other" // 23
  ];

  List<String> times = ["Less than 24h", "24-48h", "48h+", "None"];
}

bool is_tier1a(int i) {
  return TierConstants().tier1a.contains(i);
}

bool is_tier1b(int i) {
  return TierConstants().tier1b.contains(i);
}

bool is_tier1c(int i) {
  return TierConstants().tier1c.contains(i);
}

bool is_tier2a(int i) {
  return TierConstants().tier2a.contains(i);
}

bool is_tier2b(int i) {
  return TierConstants().tier2b.contains(i);
}

bool is_tier2c(int i) {
  return TierConstants().tier2c.contains(i);
}

bool is_tier3(int i) {
  return TierConstants().tier3.contains(i);
}

String which_tier(int i) {
  if (is_tier1a(i)) {
    return "1A";
  } else if (is_tier1b(i)) {
    return "1B";
  } else if (is_tier1c(i)) {
    return "1C";
  } else if (is_tier2a(i)) {
    return "2A";
  } else if (is_tier2b(i)) {
    return "2B";
  } else if (is_tier2c(i)) {
    return "2C";
  } else {
    return "3";
  }
}