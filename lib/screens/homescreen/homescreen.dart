import 'package:flutter/material.dart';
import 'package:ip_car/screens/controlscreen/controlscreen.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Home Screen'),
        ),
        body: Center(
          child: ElevatedButton(
            child: Text("Start"),
            style: ElevatedButton.styleFrom(primary: Colors.red, elevation: 0),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ControlScreen()),
              );
            },
          ),
        ));
  }
}
