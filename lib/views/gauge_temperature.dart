import 'dart:async';
import 'package:esp_32_monitor/views/nav_drawer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:percent_indicator/percent_indicator.dart';

class GaugeTemperature extends StatefulWidget {
  @override
  _GaugeTemperatureState createState() => _GaugeTemperatureState();
}

class _GaugeTemperatureState extends State<GaugeTemperature> {
  double _maxTemperature = 100;
  double _minTemperature = 100;
  String futureAlbum;
  Map<String, dynamic> json;

  Timer _timer;
  double _value = 0.0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _updateTemperatures();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _updateTemperatures() {
    setState(() {
      initTemperatures();
    });
  }

  void initTemperatures() async {
    final response = await http.get('http://192.168.1.1/min-max-temperatures');
    Map<String, dynamic> json = jsonDecode(response.body);
    _maxTemperature = json["temperatures"]["max"].toDouble();

    _minTemperature = json["temperatures"]["min"].toDouble();
  }

  void _setLimitTemperatures() {
    var a = jsonEncode(<String, String>{
      'max-temperature': _maxTemperature.toString(),
      'min-temperature': _minTemperature.toString(),
    });

    http.post(
      'http://192.168.1.1/update-temperatures',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'max-temperature': _maxTemperature.toString(),
        'min-temperature': _minTemperature.toString(),
      }),
    );
    print(a);
  }

  Future<http.Response> setTemperature() async {
    final response = await http.get('http://192.168.1.1/temp');

    if (response.statusCode == 200) {
      try {
      _value = double.parse(response.body);

      } catch (e) {
        debugPrint("Erro ao realizar parse de value");
      }
    }



    return response;
  }

  _GaugeTemperatureState() {
    _timer = Timer.periodic(const Duration(milliseconds: 1000), (_timer) {
      setState(() {
        setTemperature();
      });
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
            children: <Widget>[
              CircularPercentIndicator(
                animationDuration: 100,
                animateFromLastPercent: true,
                arcType: ArcType.FULL,
                arcBackgroundColor: Colors.white24,
                backgroundColor: Colors.black26,
                progressColor: Colors.green,
                percent: _value / 100,
                center: new Text(
                  "${_value} Cº",
                  style: new TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20.0),
                ),
                animation: true,
                radius: 250.0,
                lineWidth: 12.0,
                circularStrokeCap: CircularStrokeCap.butt,
              ),
              new Text(
                  'Temperatura de acionamento: ${(_maxTemperature).round()}'),
              Slider(
                activeColor: Colors.green,
                inactiveColor: Colors.black26,
                value: _maxTemperature,
                min: 0,
                max: 100,
                divisions: 100,
                label: _maxTemperature.round().toString(),
                onChanged: (double value) {
                  setState(() {
                    _maxTemperature = value;
                  });
                },
              ),
              new Text('Temperatura de desarme: ${(_minTemperature).round()}'),
              Slider(
                activeColor: Colors.green,
                inactiveColor: Colors.black26,
                value: _minTemperature,
                min: 0,
                max: 100,
                divisions: 100,
                label: _minTemperature.round().toString(),
                onChanged: (double value) {
                  setState(() {
                    _minTemperature = value;
                  });
                },
              ),
              const SizedBox(height: 30),
              RaisedButton(
                color: Colors.green,
                onPressed: () {
                  _setLimitTemperatures();
                  print("Persinted");
                },
                child: const Text(
                  'Salvar',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
