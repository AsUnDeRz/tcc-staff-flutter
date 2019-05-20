import 'package:app/color_config.dart';
import 'package:app/model/concert_entity.dart';
import 'package:app/model/concert_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ConcertScreen extends StatefulWidget {
  static String routeName = "/concert";
  @override
  State<StatefulWidget> createState() => new ConcertScreenState();
}

class ConcertScreenState extends State<ConcertScreen> {
  @override
  void initState() {
    super.initState();
  }

  Widget list(List<ConcertDataRecord> concertList) => ListView.builder(
        itemBuilder: (context, position) {
          return ListTile(
              title: Padding(child: CardConcert(concertList[position]), padding: EdgeInsets.all(2)),
              onTap: () => {onClickCard("Concert $position")});
        },
        itemCount: concertList.length,
      );
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ConcertRepository>(
        builder: (_) => ConcertRepository.instance(),
        child: Consumer(builder: (context, ConcertRepository concert, _) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: ColorGuide.colorPrimary,
              title: Text("TCC Gate Agent"),
            ),
            body: SafeArea(child: list(concert.concertList)),
            resizeToAvoidBottomPadding: false,
          );
        }));
  }

  void onClickCard(String name) {
    Navigator.push(context, new MaterialPageRoute(builder: (__) => new ConcertDetail(name)));
  }
}

class CardConcert extends StatelessWidget {
  ConcertDataRecord concertDataRecord;

  CardConcert(this.concertDataRecord);

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
                          child: Image.network(concertDataRecord.images.first.url),
                        ))),
                Expanded(
                    child: Padding(
                        padding: EdgeInsets.only(top: 12, bottom: 12, left: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                              flex: 3,
                              child: Text(concertDataRecord.name,
                                  maxLines: 3, style: TextStyle(fontSize: 16)),
                            ),
                            Expanded(
                                child: Text(
                              "จำนวนบัตรทั้งหมด ${concertDataRecord.ticketCount}",
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
