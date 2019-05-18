import 'package:app/color_config.dart';
import 'package:flutter/material.dart';

class ConcertScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new ConcertScreenState();
}

class ConcertScreenState extends State<ConcertScreen> {
  Widget card() => Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 2,
        child: Container(
            height: 120,
            child: Row(
              children: <Widget>[
                Expanded(
                    flex: 0,
                    child: Padding(
                        padding: EdgeInsets.only(left: 16, top: 12, bottom: 12),
                        child: SizedBox(
                          child: Image.network(
                              "https://alpha-res.theconcert.co.th/w_350,h_470,c_crop/0e06483f4e34f1c1d606bdbc38c9aa16d/55d670d43e5511e9911101117567899b.png"),
                        ))),
                Expanded(
                    child: Padding(
                        padding: EdgeInsets.only(top: 12, bottom: 12, left: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                              flex: 3,
                              child: Text('ทดสอบคอนเสิร์ต', style: TextStyle(fontSize: 16)),
                            ),
                            Expanded(
                                child: Text(
                              'จำนวนบัตร : 5000',
                              style: TextStyle(fontSize: 14, color: Colors.black.withOpacity(0.5)),
                            ))
                          ],
                        )))
              ],
            )),
      );
  Widget list() => ListView.builder(
        itemBuilder: (context, position) {
          return Padding(
              child: card(), padding: EdgeInsets.only(left: 8, right: 8, top: 4, bottom: 4));
        },
        itemCount: 10,
      );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorGuide.colorPrimary,
        title: Text("TCC Gate Agent"),
      ),
      body: SafeArea(child: list()),
      resizeToAvoidBottomPadding: false,
    );
  }
}
