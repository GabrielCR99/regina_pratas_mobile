import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'home_controller.g.dart';

class HomeController = HomeControllerBase with _$HomeController;

abstract class HomeControllerBase with Store {
  @readonly
  int _selectedTab = 0;

  final tabs = const ['home', 'cart', 'orders', 'profile'];

  @action
  void changeCurrentIndex(int value) {
    _selectedTab = value;
    Modular.to.navigate('${tabs[value]}/');
  }
}
