import 'package:flutter/material.dart';
import 'package:levelink_guru/account_page.dart';
import 'package:levelink_guru/activity_page.dart';

import '../dashboard_page.dart';
import '../class_page.dart';
import '../transaction_page.dart';

class TabProvider extends ChangeNotifier {
  int? currentTab;
  Widget? currentScreen;

  getScreen() {
    currentTab = 0;
    currentScreen = const DashboardPage();
    // notifyListeners();
  }

  changeScreen(int index) {
    currentTab = index;
    if (currentTab == 0) {
      currentScreen = const DashboardPage();
      notifyListeners();
    } else if (currentTab == 1) {
      currentScreen = const ActivityPage();
      notifyListeners();
    } else if (currentTab == 2) {
      currentScreen = const FindPage();
      notifyListeners();
    } else if (currentTab == 3) {
      currentScreen = const TransactionPage();
      notifyListeners();
    } else {
      currentScreen = const AccountPage();
      notifyListeners();
    }
    notifyListeners();
  }
}
