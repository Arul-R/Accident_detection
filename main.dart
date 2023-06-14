import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/contact_collect.dart';
import 'package:flutter_application_1/views/timer_screen.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:location/location.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

void main() {
  runApp(MyApp());
}
//final bluetooth = FlutterBlue.instance;


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Accident Alert',
      theme: ThemeData(
        colorScheme: const ColorScheme.dark(),
        primarySwatch: Colors.blue,
      ),
      home: AccidentDetection(),
    );
  }
}

class AccidentDetection extends StatefulWidget {
  @override
  _AccidentDetectionState createState() => _AccidentDetectionState();
}

class _AccidentDetectionState extends State<AccidentDetection> {
  FlutterBluePlus flutterBlue = FlutterBluePlus.instance;
  bool isBluetoothConnected = false;

  void connectToBluetoothDevice() async {
  //   // Scan for Bluetooth devices
  //   flutterBlue.scanResults.listen((List<ScanResult> scanResults) {
  //     for (ScanResult scanResult in scanResults) {
  //       if (scanResult.device.name == 'HW-013') {
  //         // Connect to your Bluetooth device
  //         scanResult.device.connect();
  //         setState(() {
  //           isBluetoothConnected = true;
  //         });
  //         break;
  //       }
  //     }
  //   });


  }

  Future<void> permissions() async {
    Location location = new Location();
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
  }

  // void startTimer() {
  //   setState(() {
  //     // Start your timer here
  //     // You can use any timer package or write your own timer logic
  //     // For demonstration purposes, let's just print a countdown to the console
  //     int countdown = 10;
  //     print('Timer started for $countdown seconds');
  //   });
  // }

  @override
  void initState() {
    super.initState();
    connectToBluetoothDevice();
    permissions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Accident Alert system'),
      ),
      body: Center(
        child: Text(
          isBluetoothConnected
              ? 'Bluetooth Connected'
              : 'Bluetooth Disconnected',
          style: const TextStyle(fontSize: 24),
        ),
      ),
      floatingActionButton: Row(
        //mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(70.0),
            child: FloatingActionButton(
              onPressed: () {
                Navigator.push(context, CupertinoPageRoute(builder: (context) {
                  return const TimerScreen();
                }));
              },
              child: const Icon(Icons.access_alarms),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: FloatingActionButton(
              onPressed: () {
                Navigator.push(context, CupertinoPageRoute(builder: (context) {
                  return const ContactCollect();
                }));
              },
              child: const Icon(Icons.add),
            ),
          )
        ],
      ),
    );
  }
}
