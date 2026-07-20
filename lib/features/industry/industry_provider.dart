import 'package:flutter/foundation.dart';

class IndustryProvider extends ChangeNotifier {
  List<Map<String, dynamic>> _industries = [];

  List<Map<String, dynamic>> get industries => List.unmodifiable(_industries);

  void loadIndustries([List<Map<String, dynamic>>? initial]) {
    _industries = initial ?? [];
    notifyListeners();
  }

  void setIndustries(List<Map<String, dynamic>> items) {
    _industries = items;
    notifyListeners();
  }
}
