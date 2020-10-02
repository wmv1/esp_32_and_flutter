import 'dart:async';
import 'package:flutter/services.dart';

class NativeResource {
  static const platform = const MethodChannel('samples.flutter.dev/battery');

  NativeResource();

  Future<String> getBatteryLevel() async {
    String batteryLevel;
    try {
      final int result = await platform.invokeMethod('getBatteryLevel');
      batteryLevel = 'Nivel da baterila $result % .';
    } on PlatformException catch (e) {
      batteryLevel = "Falha ao buscar nível: '${e.message}'.";
    }

    return batteryLevel;
  }

  Future<String> responseFromNativeCode() async {
    String response;
    try {
      final String result = await platform.invokeMethod('helloFromNativeCode');
      response = result;
    } on PlatformException catch (e) {
      response = "Falha: '${e.message}'.";
    }

    return response;
  }
}
