
import 'package:flutter/cupertino.dart';

enum NavigationItem{
  MyAccount,
  Language,
  AddDriver,
  BuyGps,
  ContactUs,
  Default
}

class  NavigationProvider extends ChangeNotifier{
  NavigationItem _navigationItem = NavigationItem.Default;

  NavigationItem get navigationItem => _navigationItem;

  void setNavigationItem(NavigationItem navigationItem){
    _navigationItem = navigationItem;
    notifyListeners();
  }
}
