import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_sms/number_model.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ref = FirebaseDatabase.instance.reference();

  List<Number> numbers = [];
  List<String> nums = [];
  int x = 0;
  void getNumbers() {
    List<Number> tmpList = [];
    ref.child('users').onChildAdded.listen((event) {
      x++;
      var number =
          Number.fromJson(event.snapshot.value as Map<dynamic, dynamic>);
      if (!event.snapshot.exists) {
        return;
      }

      //print(event.snapshot.value);
      print(number.number + x.toString());

      tmpList.add(number);
      nums.add(number.number + x.toString());

      setState(() {
        numbers = tmpList;
      });
      if (x == 101) {
        sendSms(nums).then((value) => null);
      }
      // noteList = noteList.toSet().toList();
      // findNote = noteList;
    });
  }

  // Future sendSms(String num, content) async {
  //   var rc = const MethodChannel("sms");
  //   await rc.invokeMethod("sendSMS", [
  //     {'number': num, 'content': content}
  //   ]);
  // }

  Future sendSms(List<String> list) async {
    var rc = const MethodChannel("sms");
    await rc.invokeMethod("sendSMS", list);
  }

  @override
  void initState() {
    super.initState();
    getNumbers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hello"),
      ),
      body: ListView.builder(
        itemCount: numbers.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(numbers[index].number),
            subtitle: Text(numbers[index].content),
          );
        },
      ),
    );
  }
}
