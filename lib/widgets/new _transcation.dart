import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTranscation extends StatefulWidget {
  final Function addnew;
  NewTranscation(this.addnew);

  @override
  _NewTranscationState createState() => _NewTranscationState();
}

class _NewTranscationState extends State<NewTranscation> {
  final titlecontroller = TextEditingController();

  final dcontroller = TextEditingController();

  final amountcontroller = TextEditingController();

  DateTime _selectdate;

  void _add() {
    if (amountcontroller.text.isEmpty) return;
    final enterv = titlecontroller.text;
    final dval = dcontroller.text;
    final amv = double.parse(amountcontroller.text);

    if (enterv.isEmpty || dval.isEmpty || amv <= 0 || _selectdate == null)
      return;

    widget.addnew(
      enterv,
      dval,
      amv,
      _selectdate,
    );
    Navigator.of(context).pop();
  }

  void _showchoosedate() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    ).then(
      (sd) {
        if (sd == null) return;

        setState(
          () {
            _selectdate = sd;
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: titlecontroller,
              onSubmitted: (_) => _add(),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Description'),
              controller: dcontroller,
              onSubmitted: (_) => _add(),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: amountcontroller,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => _add(),
            ),
            Container(
              height: 70,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      _selectdate == null
                          ? 'No Date Choosen'
                          : 'Date:' + DateFormat.yMMMd().format(_selectdate),
                      style: TextStyle(
                          color: Colors.teal,
                          fontFamily: 'Opensand',
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  FlatButton(
                    textColor: Theme.of(context).primaryColor,
                    child: Text(
                      'Choose Date',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontFamily: 'OpenSans'),
                    ),
                    onPressed: _showchoosedate,
                  ),
                ],
              ),
            ),
            RaisedButton(
              color: Theme.of(context).primaryColor,
              child: Text(
                'Add Item ',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onPressed: _add,
            ),
          ],
        ),
      ),
    );
  }
}
