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
  List<String> content = [];
  int x = 0;
  void getNumbers() {
    int count = -1;
    List<Number> tmpList = [];
    ref.child('users').onChildAdded.listen((event) {
      x++;
      var number =
          Number.fromJson(event.snapshot.value as Map<dynamic, dynamic>);
      if (!event.snapshot.exists) {
        return;
      }
      tmpList.add(number);
      nums.add(number.number);
      content.add(number.content);
      setState(() {
        numbers = tmpList;
      });
      //  print(numbers.last.number.toString());
      if (numbers.last.number.isNotEmpty) {
        if (numbers.last.number.length < 6) {
          count = int.parse(numbers.last.number);
        }
        print("x=$x - count = ${count + 1}");
        sendSms(nums, content).then((value) => null);
        if (count + 1 == x) {
          count = -1;
          x = 0;
        }
      }
    });
  }

  Future sendSms(List<String> list, List<String> content) async {
    var rc = const MethodChannel("sms");
    await rc.invokeMethod("sendSMS", {"nums": list, "contents": content});
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
