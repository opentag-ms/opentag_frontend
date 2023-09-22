//Is Bluetooth on?

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsService {
  static final SettingsService _instance = SettingsService._private();
  factory SettingsService() => _instance;
  SettingsService._private() {
    debugPrint("Starting SettingsService Service");

    _init();
  }

  Future _init() async {
    _prefs = await SharedPreferences.getInstance();

    _killSwitch = _prefs.getBool("killSwitch") ?? false;
    _collectPeerData = _prefs.getBool("collectPeerData") ?? false;
  }

  late SharedPreferences _prefs;
  bool _killSwitch = false;
  bool _collectPeerData = false;

  set killSwitch(bool killSwitch) {
    _killSwitch = killSwitch;
    _prefs.setBool("killSwitch", killSwitch);
  }

  set collectPeerData(bool collectPeerData) {
    _collectPeerData = collectPeerData;
    _prefs.setBool("collectPeerData", collectPeerData);
  }

  bool get collectPeerData => _collectPeerData;
  bool get killSwitch => _killSwitch;
}
