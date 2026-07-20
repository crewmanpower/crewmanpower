import 'package:flutter/foundation.dart';

class MarketingProvider extends ChangeNotifier {
  List<Map<String, String>> testimonials = [];
  List<Map<String, String>> faqs = [];

  void loadData() {
    testimonials = [
      {
        'client': 'City Hospital HR',
        'review': 'Excellent service! Provided qualified staff in 48 hours.',
      },
      {
        'client': 'Apex Tech CEO',
        'review': 'Very professional corporate facility management providers.',
      },
    ];
    faqs = [
      {
        'q': 'How do you verify staff background?',
        'a':
            'We conduct thorough criminal and qualification checks before deployment.',
      },
      {
        'q': 'What sectors do you cover?',
        'a':
            'We specialize in Healthcare, Security, Corporate, and Logistics staffing.',
      },
    ];
    notifyListeners();
  }
}
