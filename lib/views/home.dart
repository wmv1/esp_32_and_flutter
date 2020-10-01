// import 'package:esp_32_monitor/views/gauge_temperature.dart';
import 'package:esp_32_monitor/views/gauge_temperature.dart';
import 'package:flutter/material.dart';

import 'nav_drawer.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      // appBar: AppBar(
      //   title: Text('Home'),
      // ),
      body: GaugeTemperature(),
    );
  }
}
