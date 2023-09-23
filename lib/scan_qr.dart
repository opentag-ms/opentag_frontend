import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:flutter/services.dart';
import 'package:opentag_frontend/app.dart';
import 'package:opentag_frontend/data/settings_service.dart';

class QRScanner extends StatelessWidget {
  const QRScanner({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text("Visitenkarte scannen"),
        foregroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarBrightness: Brightness.dark,
        ),
      ),
      body: MobileScanner(
        allowDuplicates: false,
        onDetect: (barcode, args) {
          if (barcode.rawValue == null) {
            debugPrint('Failed to scan Barcode');
          } else {
            final String code = barcode.rawValue!;

            Map<String, dynamic> json = jsonDecode(code);

            List<String> temp = SettingsService().ownedTags;
            temp.add(json["id"]);
            SettingsService().ownedTags = temp;
            SettingsService().storeTagName(json["id"], json["n"]);

            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const App()), (route) => false);
          }
        },
      ),
    );
  }
}
