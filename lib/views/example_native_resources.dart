import 'package:esp_32_monitor/channels/native_resource.dart';
import 'package:esp_32_monitor/views/nav_drawer.dart';
import 'package:flutter/material.dart';

class ExampleNativeResources extends StatefulWidget {
  @override
  _ExampleNativeResourcesState createState() => _ExampleNativeResourcesState();
}

class _ExampleNativeResourcesState extends State<ExampleNativeResources> {
  NativeResource _platformResources = NativeResource();
  String _batteryLevel = "Não verificado";
  String _responseFromNativeCode = "Aguardando resposta";

  _setResponseFromPlatform() async {
    _responseFromNativeCode = await _platformResources.responseFromNativeCode();
  }

  _setBatteryLevel() async {
    _batteryLevel = await _platformResources.getBatteryLevel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: NavDrawer(),
        appBar: AppBar(title: Text("Method Channel Example")),
        body: new Container(
          padding: new EdgeInsets.all(80.0),
          child: new Center(
            child: new Column(
              children: <Widget>[
                RaisedButton(
                  color: Colors.green,
                  child: Text('Verificar nível da bateria'),
                  onPressed: () {
                    setState(() {
                      _setBatteryLevel();
                    });
                  },
                ),
                Text(_batteryLevel),
                RaisedButton(
                  color: Colors.green,
                  child: Text('Ver mensagem do Android'),
                  onPressed: () {
                    setState(() {
                      _setResponseFromPlatform();
                    });
                  },
                ),
                Text(_responseFromNativeCode),
              ],
            ),
          ),
        ));
  }
}
