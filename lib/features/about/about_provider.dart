import 'package:flutter/foundation.dart';

class AboutProvider extends ChangeNotifier {
  String companyMission = '';
  String companyVision = '';
  String directMessage = '';
  List<Map<String, String>> timelineMilestones = [];
  List<String> certificationsList = [];

  void loadAboutData() {
    companyMission =
        "To connect exceptional talent with premier global industries through seamless tracking, ethical vetting, and unmatched service execution.";
    companyVision =
        "To become the absolute global benchmark in enterprise facility workforce management and professional placement systems by 2030.";
    directMessage =
        "At Crewmanpower, we believe that human capital is an organization's ultimate competitive edge. We don't just supply laborers; we deliver dedicated operational partners.";
    timelineMilestones = [
      {
        "year": "2020",
        "detail":
            "Company establishment and initial healthcare sector breakthrough.",
      },
      {
        "year": "2022",
        "detail":
            "Expanded network footprints into industrial security and elite housekeeping setups.",
      },
      {
        "year": "2024",
        "detail":
            "Crossed over 500+ premium commercial client integrations successfully.",
      },
      {
        "year": "2026",
        "detail":
            "Launching advanced automated labor allocation systems across corporate nodes.",
      },
    ];
    certificationsList = [
      "ISO 9001:2015 Certified Management System",
      "National Skill Development Corporation (NSDC) Partner",
      "Certified Elite Corporate Staffing Compliance Authority",
    ];
    notifyListeners();
  }
}
