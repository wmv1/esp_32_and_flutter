import 'package:esp_32_monitor/routes/app_routes.dart';
import 'package:esp_32_monitor/views/example_native_resources.dart';
import 'package:esp_32_monitor/views/gauge_temperature.dart';
import 'package:esp_32_monitor/views/home.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Leitor de Temperatura',
        theme: ThemeData(
          brightness: Brightness.dark,
          // theme: ThemeData(
          //   primarySwatch: Colors.teal,
          //   visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        routes: {
          AppRoutes.HOME: (_) => Home(),
          AppRoutes.TEMPERATURE:  (_) => GaugeTemperature(),
          AppRoutes.FROM_ANDROID: (_) => ExampleNativeResources()
        });
  }
}
