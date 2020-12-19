import './widgets/chart.dart';
import 'package:flutter/material.dart';
import './widgets/transaction_list.dart';
import './models/transcation.dart';
import './widgets/new _transcation.dart';

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Planner',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        accentColor: Colors.teal,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
              headline1: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
        ),
      ),
      home: MyAppHomePage(),
    );
  }
}

class MyAppHomePage extends StatefulWidget {
  @override
  _MyAppHomePageState createState() => _MyAppHomePageState();
}

class _MyAppHomePageState extends State<MyAppHomePage> {
  final List<Transcation> trans = [
    // Transcation(
    //   id: 't1',
    //   title: 'WiFiAdapter',
    //   description: 'This is wifi product',
    //   amount: 499.50,
    //   date: DateTime.now(),
    // ),
    // Transcation(
    //   id: 't2',
    //   title: 'Watch',
    //   description: 'This is my favourite watch ',
    //   amount: 155.75,
    //   date: DateTime.now(),
    // ),
  ];

  List<Transcation> get recenttrans {
    return trans.where(
      (txn) {
        return txn.date.isAfter(
          DateTime.now().subtract(
            Duration(days: 7),
          ),
        );
      },
    ).toList();
  }

  void _AddNew(String newtitle, String newDescription, double newAmount,
      DateTime choosen) {
    final newtxn = Transcation(
      id: DateTime.now().toString(),
      title: newtitle,
      description: newDescription,
      amount: newAmount,
      date: choosen,
    );

    setState(() {
      trans.add(newtxn);
    });
  }

  void _deletetxn(String id) {
    setState(() {
      trans.removeWhere((txn) => txn.id == id);
    });
  }

  void _addNew(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return NewTranscation(_AddNew);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expense Planner'),
        actions: <Widget>[],
      ),
      body: SingleChildScrollView(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Chart(recenttrans),
            TranscationList(trans, _deletetxn),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _addNew(context),
      ),
    );
  }
}
