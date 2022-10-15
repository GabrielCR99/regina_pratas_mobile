// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeController on HomeControllerBase, Store {
  late final _$_selectedTabAtom =
      Atom(name: 'HomeControllerBase._selectedTab', context: context);

  int get selectedTab {
    _$_selectedTabAtom.reportRead();
    return super._selectedTab;
  }

  @override
  int get _selectedTab => selectedTab;

  @override
  set _selectedTab(int value) {
    _$_selectedTabAtom.reportWrite(value, super._selectedTab, () {
      super._selectedTab = value;
    });
  }

  late final _$HomeControllerBaseActionController =
      ActionController(name: 'HomeControllerBase', context: context);

  @override
  void changeCurrentIndex(int value) {
    final _$actionInfo = _$HomeControllerBaseActionController.startAction(
        name: 'HomeControllerBase.changeCurrentIndex');
    try {
      return super.changeCurrentIndex(value);
    } finally {
      _$HomeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
