import 'package:app/color_config.dart';
import 'package:flutter/material.dart';

class ConcertScreen extends StatefulWidget {
  static String routeName = "/concert";
  @override
  State<StatefulWidget> createState() => new ConcertScreenState();
}

class ConcertScreenState extends State<ConcertScreen> {
  Widget list() => ListView.builder(
        itemBuilder: (context, position) {
          return ListTile(
              title: Padding(
                  child: CardConcert(
                      "ทดสอบคอนเสิร์ต",
                      "https://alpha-res.theconcert.co.th/w_350,h_470,c_crop/0e06483f4e34f1c1d606bdbc38c9aa16d/55d670d43e5511e9911101117567899b.png",
                      "จำนวนบัตร : 500$position"),
                  padding: EdgeInsets.all(2)),
              onTap: () => {onClickCard("Concert $position")});
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

  void onClickCard(String name) {
    Navigator.push(context, new MaterialPageRoute(builder: (__) => new ConcertDetail(name)));
    print('Test onClick');
  }
}

class CardConcert extends StatelessWidget {
  final String concertName;
  final String concertImg;
  final String concertTickets;

  CardConcert(this.concertName, this.concertImg, this.concertTickets);

  @override
  Widget build(BuildContext context) => Card(
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
                          child: Image.network(concertImg),
                        ))),
                Expanded(
                    child: Padding(
                        padding: EdgeInsets.only(top: 12, bottom: 12, left: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                              flex: 3,
                              child: Text(concertName, style: TextStyle(fontSize: 16)),
                            ),
                            Expanded(
                                child: Text(
                              concertTickets,
                              style: TextStyle(fontSize: 14, color: Colors.black.withOpacity(0.5)),
                            ))
                          ],
                        )))
              ],
            )),
      );
}

class ConcertDetail extends StatelessWidget {
  final String concertName;

  ConcertDetail(this.concertName);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      backgroundColor: ColorGuide.colorPrimary,
      title: Text(concertName),
    ));
  }
}
