import 'package:app/color_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class ConcertDetail extends StatefulWidget {
  final String concertName;

  ConcertDetail(this.concertName);

  @override
  State<StatefulWidget> createState() => new ConcertDetailState();
}

class ConcertDetailState extends State<ConcertDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorGuide.colorPrimary,
        title: Text(widget.concertName),
      ),
    );
  }
}
