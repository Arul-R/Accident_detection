import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
//import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';
//import 'package:flutter_dotenv/flutter_dotenv.dart';
//import 'package:flutter_sms/flutter_sms.dart';
//import 'package:flutter_application_1/views/contact_collect.dart';


class SendSms extends StatefulWidget {
  const SendSms({super.key});

  @override
  State<SendSms> createState() => _SendSmsState();
}

class _SendSmsState extends State<SendSms> {
  @override
  void initState() {
    super.initState();
    loc();
    //sendingSMS();
  }

  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
      child: Text("SOS message sent to all emergency contacts!"),
    ));
  }
}

Future<void> loc() async {
  Location location = new Location();
  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  LocationData _locationData;
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

  _locationData = await location.getLocation();
  String latitude = _locationData.latitude.toString();
  String longitude = _locationData.longitude.toString();
  print(latitude);
  print(longitude);
  sendingSMS(latitude, longitude);
}

void sendingSMS(String latitude, String longitude) async {
  // Replace with your Twilio account SID, auth token, and phone numbers
  const String accountSid = 'ACb12e48d7e601f850f2c024100440d6b9';
  const String authToken = '9b3f03f02223dc8db8a19a68b012982d';
  const String fromNumber = '+1 361 339 2520';
  const String toNumber = '+917356694843';
  //'+916282140110'; // Replace with the recipient's phone number
  String locationUrl =
      'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
  String message =
      'Accident Warning!\nAccident location: $locationUrl'; // Replace with your desired message
  print(message);
  const String url =
      'https://api.twilio.com/2010-04-01/Accounts/$accountSid/Messages.json';

  final response = await http.post(
    Uri.parse(url),
    headers: {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization':
          'Basic ' + base64Encode(utf8.encode('$accountSid:$authToken')),
    },
    body: {
      'From': fromNumber,
      'To': toNumber,
      'Body': message,
    },
  );

  if (response.statusCode == 201) {
    print('SMS sent successfully');
  } else {
    print('Failed to send SMS: ${response.body}');
  }
}
