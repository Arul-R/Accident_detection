import 'package:flutter/material.dart';

class ContactCollect extends StatefulWidget {
  const ContactCollect({super.key});

  @override
  State<ContactCollect> createState() => _ContactCollectState();
}

class _ContactCollectState extends State<ContactCollect> {
  List<String> phoneNumbers = [];
  void addPhoneNumb(String phonenumber) {
    phoneNumbers.add(phonenumber);
  }

  TextEditingController phonenumb = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          var phonenumber = phonenumb.text;
          //debugPrint(phonenumber);
          addPhoneNumb(phonenumber);
          print(phoneNumbers);
        },
        child: const Text("Add"),
      ),
      appBar: AppBar(title: const Text("Emergency contacts")),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(children: <Widget>[
            TextField(
                controller: phonenumb,
                decoration: const InputDecoration(
                  labelText: "Add Phone Numbers",
                )), //ListView.separated(itemBuilder: itemBuilder, separatorBuilder: separatorBuilder, itemCount: itemcount: )
          ])),
    );
  }
}
