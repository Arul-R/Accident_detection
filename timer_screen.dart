import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/sms_send.dart';

class TimerScreen extends StatefulWidget {
  const TimerScreen({super.key});

  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  int count = 3;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() async {
    await Future.delayed(const Duration(seconds: 1));

    count = count - 1;

    if (mounted) {
      setState(() {});
    }

    if (count == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) {
          return const SendSms();
        }),
      );
      return;
    }

    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.redAccent,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Press Stop if false ararm!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              count.toString(),
              style: const TextStyle(
                fontSize: 70,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
              style: const ButtonStyle(
                  foregroundColor: MaterialStatePropertyAll(Colors.white),
                  backgroundColor: MaterialStatePropertyAll(
                      Color.fromARGB(255, 11, 39, 220))),
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: Text(
                  "Stop",
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
