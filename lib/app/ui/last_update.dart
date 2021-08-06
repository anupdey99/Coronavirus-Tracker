import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LastUpdate extends StatelessWidget {
  const LastUpdate({Key? key, required this.text}) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 8.0, right: 8.0, top: 16.0, bottom: 8.0),
      child: Text(
        text,
        textAlign: TextAlign.center,
      ),
    );
  }
}
