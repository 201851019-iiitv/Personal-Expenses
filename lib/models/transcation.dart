import 'package:flutter/foundation.dart';

class Transcation {
  final String id;
  final String title;
  final String description;
  final double amount;
  final DateTime date;

  Transcation({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.amount,
    @required this.date,
  });
}
