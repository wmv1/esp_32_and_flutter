import 'dart:io';

import 'package:esp_32_monitor/routes/app_routes.dart';
import 'package:flutter/material.dart';

class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              'Menu',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            decoration: BoxDecoration(
              color: Colors.teal,
              // image: DecorationImage(
              //   fit: BoxFit.fill,
              //   image: AssetImage('assets/images/lake.jpg'),
              // ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.input),
            title: Text('Welcome!'),
            onTap: () => {Navigator.pushNamed(context, AppRoutes.HOME)},
          ),
          ListTile(
            leading: Icon(Icons.input),
            title: Text('Temperature monitor'),
            onTap: () => {Navigator.pushNamed(context, AppRoutes.TEMPERATURE)},
          ),
          ListTile(
            leading: Icon(Icons.input),
            title: Text('From Android'),
            onTap: () => {Navigator.pushNamed(context, AppRoutes.FROM_ANDROID)},
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Exit'),
            onTap: () => {exit(0)},
          ),
        ],
      ),
    );
  }
}
