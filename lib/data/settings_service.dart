//Is Bluetooth on?

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:opentag_frontend/data/tag.dart';
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
    _password = _prefs.getString("password") ?? Random().nextInt(300).toString();
    _ownedTags = _prefs.getStringList("ownedTags") ?? [];
  }

  late SharedPreferences _prefs;
  bool _killSwitch = false;
  bool _collectPeerData = false;
  String _password = "init";
  List<String> _ownedTags = [];

  List<Tag> tags = [
    Tag("hi", "ids", const LatLng(51.951475, 7.638)),
  ];

  set killSwitch(bool killSwitch) {
    _killSwitch = killSwitch;
    _prefs.setBool("killSwitch", killSwitch);
  }

  set collectPeerData(bool collectPeerData) {
    _collectPeerData = collectPeerData;
    _prefs.setBool("collectPeerData", collectPeerData);
  }

  set ownedTags(List<String> ownedTags) {
    _ownedTags = ownedTags;
    _prefs.setStringList("ownedTags", _ownedTags);
  }

  bool get collectPeerData => _collectPeerData;
  bool get killSwitch => _killSwitch;
  String get password => _password;
  List<String> get ownedTags => _ownedTags;

  Future storeTagName(String tagId, String name) async {
    await _prefs.setString(tagId, name);
  }

  String getTagName(String tagId) {
    return _prefs.getString(tagId) ?? "Unbekannt";
  }
}
