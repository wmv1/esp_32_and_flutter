import 'package:esp_32_monitor/views/nav_drawer.dart';
import 'package:flutter/material.dart';

import 'dart:async';
import 'package:flutter/services.dart';

class FromAndroid extends StatefulWidget {
  @override
  _FromAndroidState createState() => _FromAndroidState();
}

class _FromAndroidState extends State<FromAndroid> {
  static const platform = const MethodChannel('samples.flutter.dev/battery');

  String _batteryLevel = 'Unknown battery level.';
   String _responseFromNativeCode = 'Waiting for Response...';

  Future<void> _getBatteryLevel() async {
    String batteryLevel;
    try {
      final int result = await platform.invokeMethod('getBatteryLevel');
      batteryLevel = 'Battery level at $result % .';
    } on PlatformException catch (e) {
      batteryLevel = "Failed to get battery level: '${e.message}'.";
    }

    setState(() {
      _batteryLevel = batteryLevel;
    });
  }

   Future<void> responseFromNativeCode() async {
    String response = "";
    try {
      final String result = await platform.invokeMethod('helloFromNativeCode');
      response = result;
    } on PlatformException catch (e) {
      response = "Failed to Invoke: '${e.message}'.";
    }
    setState(() {
      _responseFromNativeCode = response;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(title: Text("Temperatura")),
      body: new Container(
        padding: new EdgeInsets.all(32.0),
        child: new Center(
          child: new Column(
            children: <Widget> [
            RaisedButton(
              color: Colors.green,
              child: Text('Get Battery Level'),
              onPressed: _getBatteryLevel,
            ),
            Text(_batteryLevel),
            RaisedButton(
              color: Colors.green,
              child: Text('Get Message from android'),
              onPressed: responseFromNativeCode,
            ),
            Text(_responseFromNativeCode),
          ],
        ),
      ),
    )
    );
  }
}
