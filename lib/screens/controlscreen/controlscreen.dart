import 'package:flutter/material.dart';
import 'dart:developer';
import 'package:flutter/services.dart';
import 'connection.dart';

import 'package:ip_car/screens/homescreen/homescreen.dart';

class ControlScreen extends StatefulWidget {
  const ControlScreen({super.key});

  @override
  State<ControlScreen> createState() => _ControlScreenState();
}

class _ControlScreenState extends State<ControlScreen> {
  @override
  final connection1 = Connection();

  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  void videoStart() {
    //Connection.of(context)?.startVideo(); // Call videoStart function in WidgetB
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(children: [
        Expanded(
            flex: 2,
            child: Container(
              color: Colors.amber,
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                          margin: EdgeInsets.only(top: 24),
                          child: Text("IP-Car")),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        child: ElevatedButton(
                          onPressed: () {
                            // Connection.of(context)?.startVideo();
                            //connection1.startCamera();
                          },
                          child: Text('Connect'),
                        ),
                      )
                    ],
                  )
                ],
              ),
            )),
        const Expanded(
          flex: 4,
          child: Connection(),
        ),
      ]),
    );
  }
}
