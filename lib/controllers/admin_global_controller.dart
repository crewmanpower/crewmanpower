import 'package:get/get.dart';

class AdminGlobalController extends GetxController {
  var selectedIndex = 0.obs; // Observable index for sidebar selection

  void setSelectedIndex(int index) {
    selectedIndex.value = index;
  }
}