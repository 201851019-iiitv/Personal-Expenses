import './chart_bar.dart';

import '../models/transcation.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transcation> recenttrans;

  Chart(this.recenttrans);

  List<Map<String, Object>> get Transcationchart {
    return List.generate(
      7,
      (index) {
        final dayst = DateTime.now().subtract(Duration(days: index));

        var totalamn = 0.0;

        for (var i = 0; i < recenttrans.length; i++) {
          if (recenttrans[i].date.day == dayst.day &&
              recenttrans[i].date.month == dayst.month &&
              recenttrans[i].date.year == dayst.year) {
            totalamn += recenttrans[i].amount;
          }
        }
        return {
          'Day': DateFormat.E().format(dayst),
          'Amount': totalamn,
        };
      },
    ).reversed.toList();
  }

  double get totalspperc {
    return Transcationchart.fold(
      0.0,
      (sum, item) {
        return sum + item['Amount'];
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    //print(Transcationchart);
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: Transcationchart.map(
            (data) {
              return Flexible(
                fit: FlexFit.tight,
                child: ChartBar(
                    data['Amount'],
                    data['Day'],
                    totalspperc == 0.0
                        ? 0.0
                        : (data['Amount'] as double) / totalspperc),
              );
            },
          ).toList(),
        ),
      ),
    );
  }
}
