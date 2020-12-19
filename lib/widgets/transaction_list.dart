import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transcation.dart';

class TranscationList extends StatelessWidget {
  final List<Transcation> trans;
  final Function deletetxn;
  TranscationList(this.trans, this.deletetxn);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: trans.isEmpty
          ? Column(
              children: <Widget>[
                Text(
                  'No transcation yet !!',
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'OpenSans',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 200,
                  margin: EdgeInsets.only(
                    top: 40,
                    left: 20,
                  ),
                  child: Image.asset(
                    'assest/images/emptybx.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            )
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 10,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: EdgeInsets.all(6),
                        child: FittedBox(
                          child: Text(
                            '₹${trans[index].amount.toStringAsFixed(2)}',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Opensand',
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      trans[index].title,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        fontFamily: 'OpenSand',
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(2),
                        ),
                        Text(
                          trans[index].description,
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            fontFamily: 'Opensans',
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              DateFormat.yMMMd().format(trans[index].date),
                              style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                fontFamily: 'Opensans',
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      color: Colors.red,
                      onPressed: () => deletetxn(trans[index].id),
                    ),
                  ),
                );
              },
              itemCount: trans.length,
            ),
    );
  }
}
