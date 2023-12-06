import 'dart:io';

import 'package:flutter_core/flutter_core.dart';

class AppStorage {
  static final shared = AppStorage._();
  AppStorage._();

  Future<String?> getFCMToken() async {
    // final localStorage = GetIt.I.get<BaseLocalStorage>();
    // String? token = await localStorage.read("fcm_token");
    // if (token == null) {
    //   final fcmToken = await FirebaseMessaging.instance.getToken();
    //   await localStorage.write("fcm_token", fcmToken ?? "");
    //   print("FCN TOKEN ====== $fcmToken");
    //   token = fcmToken;
    // }
    // print("FCN TOKEN ==== $token");
    // return token ?? "TOKEN-NOT-FOUND";
    return "";
  }

  Future<String?> getDeviceUUID() async {
    final localStorage = GetIt.I.get<BaseLocalStorage>();
    String? deviceId = await localStorage.read("device_id");
    if (deviceId == null) {
      final dID = await Generate.timeBasedUniqueString();
      await localStorage.write("device_id", dID);
      print("Device ID ====== $dID");
      deviceId = dID;
    }
    print("Device ID ==== $deviceId");
    return deviceId;
  }

  String getDeviceType() {
    if (Platform.isIOS) {
      return "IOS";
    } else if (Platform.isAndroid) {
      return "ANDROID";
    } else {
      return "OTHER";
    }
  }
}
