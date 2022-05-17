import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class SendDataPage extends StatefulWidget {
  const SendDataPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<SendDataPage> createState() => _SendDataPageState();
}

class _SendDataPageState extends State<SendDataPage> {
  final rd = FirebaseDatabase.instance.reference();

  // final String baseUrl =
  //     'https://sendsms-2ad22-default-rtdb.firebaseio.com/users/3';
  // final Map<String, String> headers = {'Content-Type': 'application/json'};

  // Future<String> login(String content, String number) async {
  //   try {
  //     var request = http.Request('POST', Uri.parse(baseUrl));
  //
  //     Map<String, String> body = {
  //       "content": content.trim(),
  //       "number": number.trim(),
  //     };
  //     request.body = jsonEncode(body);
  //     print(request.body);
  //     request.headers.addAll(headers);
  //     http.StreamedResponse response = await request.send();
  //     print(response.stream.bytesToString());
  //     return await response.stream.bytesToString();
  //   } catch (e) {
  //     print("AuthApi login ERROR: $e");
  //     return "null";
  //   }
  // }
  int x = 0;
  void addToFirebase(String content, number) {
    Map<String, String> body = {
      "content": content.trim(),
      "number": number.trim(),
    };
    rd
        .child("users")
        .child(rd.push().key.toString())
        .set(body)
        .then((value) => null);
  }

  void _incrementCounter() {
    addToFirebase("Hello my friend", '+96277763799');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
