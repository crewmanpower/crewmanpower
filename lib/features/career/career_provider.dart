import 'package:flutter/foundation.dart';

class CareerProvider extends ChangeNotifier {
  List<Map<String, String>> jobs = [];
  bool isSubmitting = false;
  bool isLoading = false;
  bool isApplying = false;

  void loadJobs() {
    jobs = [
      {'id': '1', 'title': 'Staff Nurse', 'type': 'Healthcare'},
      {'id': '2', 'title': 'Security Guard', 'type': 'Security'},
      {'id': '3', 'title': 'Warehouse Supervisor', 'type': 'Logistics'},
    ];
    notifyListeners();
  }

  Future<bool> applyJob({
    required String name,
    required String email,
    required String filePath,
  }) async {
    isApplying = true;
    notifyListeners();
    await Future.delayed(const Duration(seconds: 1));
    isApplying = false;
    notifyListeners();
    return true;
  }
}
