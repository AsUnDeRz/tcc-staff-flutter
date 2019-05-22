import 'package:app/color_config.dart';
import 'package:app/model/concert_entity.dart';
import 'package:app/model/concert_repository.dart';
import 'package:app/model/user_repository.dart';
import 'package:app/screen/concert_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';

class ConcertScreen extends StatefulWidget {
  static String routeName = "/concert";
  @override
  State<StatefulWidget> createState() => new ConcertScreenState();
}

class ConcertScreenState extends State<ConcertScreen> {
  final GlobalKey<InnerDrawerState> _innerDrawerKey = GlobalKey<InnerDrawerState>();

  @override
  void initState() {
    super.initState();
  }

  void _open() {
    _innerDrawerKey.currentState.open();
  }

  void _close() {
    _innerDrawerKey.currentState.close();
  }

  Widget drawerMenu(UserRepository user) => ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Center(
                child: Image.asset(
                  'asset/logo.png',
                  width: 100,
                  height: 100,
                ),
              ),
              decoration: BoxDecoration(
                color: ColorGuide.colorPrimary,
              ),
            ),
            ListTile(
              title: Text('ออกจากระบบ'),
              onTap: () {
                user.logout();
                _close();
              },
            ),
          ]);
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
    final user = Provider.of<UserRepository>(context);
    return InnerDrawer(
      key: _innerDrawerKey,
      position: InnerDrawerPosition.start, // required
      onTapClose: true, // default false
      swipe: true, // default true
      offset: 0.6, // default 0.4
      colorTransition: Colors.red, // default Color.black54
      animationType: InnerDrawerAnimation.linear, // default static
      innerDrawerCallback: (a) => print(a), // return bool
      child: Material(child: drawerMenu(user)),
      scaffold: ChangeNotifierProvider<ConcertRepository>(
          builder: (_) => ConcertRepository.instance(),
          child: Consumer(builder: (context, ConcertRepository concert, _) {
            return Scaffold(
              appBar: AppBar(
                leading: new IconButton(
                    icon: new Icon(Icons.menu),
                    onPressed: () {
                      _open();
                    }),
                automaticallyImplyLeading: false,
                backgroundColor: ColorGuide.colorPrimary,
                title: Text("TCC Gate Agent"),
              ),
              body: SafeArea(child: list(concert.concertList)),
              resizeToAvoidBottomPadding: false,
            );
          })),
    );
  }

  void onClickCard(String name) {
//    _openNewPage();
    Navigator.push(context, new MaterialPageRoute(builder: (__) => new ConcertDetail(name)));
  }

  static const channel = const MethodChannel("flutter.theconcert/scan");

  Future<Null> _openNewPage() async {
    final response = await channel.invokeMethod("openCamera", ["Hi From Flutter"]);
    print(response);
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
