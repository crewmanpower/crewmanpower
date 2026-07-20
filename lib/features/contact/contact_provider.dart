import 'package:flutter/foundation.dart';

class ContactProvider extends ChangeNotifier {
  bool isSubmitting = false;
  bool lastSubmitSuccess = false;
  String? error;

  Future<bool> submitInquiry({
    required String type,
    required Map<String, String> data,
  }) async {
    isSubmitting = true;
    lastSubmitSuccess = false;
    error = null;
    notifyListeners();

    try {
      await Future.delayed(const Duration(milliseconds: 600));
      lastSubmitSuccess = true;
      return true;
    } catch (e) {
      error = 'Submission failed';
      return false;
    } finally {
      isSubmitting = false;
      notifyListeners();
    }
  }
}
