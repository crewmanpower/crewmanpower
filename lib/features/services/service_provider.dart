import 'package:flutter/foundation.dart';

class ServiceProvider extends ChangeNotifier {
  List<String> _services = [];

  List<String> get services => List.unmodifiable(_services);

  void loadServices([List<String>? initial]) {
    _services = initial ?? [];
    notifyListeners();
  }

  void setServices(List<String> items) {
    _services = items;
    notifyListeners();
  }
}
