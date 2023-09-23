import 'package:flutter/material.dart';
import 'package:opentag_frontend/data/settings_service.dart';

class ServerService {
  static final ServerService _instance = ServerService._private();
  factory ServerService() => _instance;
  ServerService._private() {
    debugPrint("Starting ServerService Service");
  }

  Future updateDevices() async {}

  Future registerDevice(String tagId, String name) async {
    //####

    //### ok
    if (SettingsService().ownedTags.contains(tagId)) {
      debugPrint("Komisch");
    } else {
      SettingsService().ownedTags.add(tagId);
      List<String> tempTags = SettingsService().ownedTags;
      SettingsService().ownedTags = tempTags;
    }

    SettingsService().storeTagName(tagId, name);
  }

  Future startSharing(String tagId) async {}

  Future stopSharing(String tagId) async {}

  Future getDeviceUpdate() async {}

  Future unregisterDevice(String tagId) async {
    //####

    //### ok
    SettingsService().ownedTags.remove(tagId);
  }
}
