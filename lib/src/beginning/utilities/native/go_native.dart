// Dart imports:
import 'dart:developer';

// Flutter imports:
import 'package:flutter/services.dart';

// Package imports:
import 'package:permission_handler/permission_handler.dart';

// Project imports:
import 'package:phoenix/src/beginning/utilities/visualizer_notification.dart';

bool activeSession = false;
var platform = const MethodChannel("com.Phoenix.project/kotlin");

kotlinVisualizer() async {
  try {
    if (await Permission.microphone.request().isGranted) {
      await platform.invokeMethod("KotlinVisualizer");
      activeSession = true;
      await startVisualizerNotification();
    }
  } catch (e) {
    throw Exception(e);
  }
}

stopkotlinVisualizer() async {
  try {
    await platform.invokeMethod("ResetKot");
    activeSession = false;
    await stopVisualizerNotification();
  } catch (e) {
    throw Exception(e);
  }
}

goSensitivity(value) async {
  try {
    var data = <String, double>{"valueFromFlutter": value};
    await platform.invokeMethod("sensitivityKot", data);
  } catch (e) {
    throw Exception(e);
  }
}

checkWallpaperSupport() async {
  try {
    await platform.invokeMethod("wallpaperSupport?");
  } catch (e) {
    throw Exception(e);
  }
}

setHomeScreenWallpaper() async {
  try {
    await platform.invokeMethod("homescreen");
  } catch (e) {
    throw Exception(e);
  }
}

returnToOld() async {
  try {
    await platform.invokeMethod("returnToOld");
  } catch (e) {
    throw Exception(e);
  }
}

deleteAFile(path) async {
  try {
    var data = <String, String>{"fileToDelete": path};
    await platform.invokeMethod("deleteFile", data);
  } catch (e) {
    throw Exception(e);
  }
}

broadcastFileChange(String path) async {
  try {
    var data = <String, String>{"filePath": path};
    await platform.invokeMethod("broadcastFileChange", data);
  } catch (e) {
    throw Exception(e);
  }
}

setRingtone(String path) async {
  try {
    var data = <String, String>{'path': path};
    await platform.invokeMethod("setRingtone", data);
  } catch (e) {
    throw Exception(e);
  }
}

getSettingPermission() async {
  try {
    await platform.invokeMethod("checkSettingPermission");
  } catch (e) {
    throw Exception(e);
  }
}

Future<String?> getExternalDirectory() async {
  try {
    return (await platform.invokeMethod("externalStorage"));
  } catch (e) {
    log(e.toString());
  }
  return null;
}
