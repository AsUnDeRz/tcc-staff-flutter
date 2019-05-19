import 'package:app/color_config.dart';
import 'package:app/screen/concert_list_screen.dart';
import 'package:app/screen/launch_screen.dart';
import 'package:app/screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(initialRoute: checkLogin(), routes: <String, WidgetBuilder>{
      '/': (context) => LaunchScreen(),
      LoginScreen.routeName: (context) => LoginScreen(),
      ConcertScreen.routeName: (context) => ConcertScreen(),
    });
  }

  String checkLogin() {
    if ((2 * 2) == 3) {
      return LoginScreen.routeName;
    } else {
      return "/";
    }
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const channel = const MethodChannel("flutter.theconcert/scan");

  Future<Null> _openNewPage() async {
    final response = await channel.invokeMethod("openCamera", ["Hi From Flutter"]);
    print(response);
  }

  Future<Null> _showDialog() async {
    final response = await channel.invokeMethod("showDialog", ["Called From Flutter"]);
    final snackbar = new SnackBar(content: new Text(response));
    Scaffold.of(context).showSnackBar(snackbar);
  }

  void onClickLogin() {
    Navigator.pushNamed(context, LoginScreen.routeName);
//    Navigator.push(context, new MaterialPageRoute(builder: (__) => new LoginScreen()));
    print('Test onClick');
  }

  void onClickOpenList() {
    Navigator.pushNamed(context, ConcertScreen.routeName);
    print('Test onClick');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Padding(
              padding: const EdgeInsets.all(16.0),
              child: new RaisedButton(
                onPressed: () => _openNewPage(),
                child: new Text("Open Camera Native"),
                color: Colors.deepPurple,
                textColor: Colors.white,
              ),
            ),
            new Padding(
              padding: const EdgeInsets.all(16.0),
              child: new RaisedButton(
                onPressed: () => onClickLogin(),
                child: new Text("Open Login"),
                color: Colors.blueAccent,
                textColor: Colors.white,
              ),
            ),
            new Padding(
              padding: const EdgeInsets.all(16.0),
              child: new RaisedButton(
                onPressed: () => onClickOpenList(),
                child: new Text("Open Concert List"),
                color: Colors.blueAccent,
                textColor: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }

//  Widget body = new Center(
//    child: new Column(
//      mainAxisAlignment: MainAxisAlignment.center,
//      children: <Widget>[
//        new Padding(
//          padding: const EdgeInsets.all(16.0),
//          child: new RaisedButton(
//            onPressed: () => _openNewPage(),
//            child: new Text("Open Camera Native"),
//            color: Colors.deepPurple,
//            textColor: Colors.white,
//          ),
//        ),
//        new Padding(
//          padding: const EdgeInsets.all(16.0),
//          child: new RaisedButton(
//            onPressed: () => onClickLogin(),
//            child: new Text("Open Login"),
//            color: Colors.blueAccent,
//            textColor: Colors.white,
//          ),
//        ),
//        new Padding(
//          padding: const EdgeInsets.all(16.0),
//          child: new RaisedButton(
//            onPressed: () => onClickOpenList(),
//            child: new Text("Open Concert List"),
//            color: Colors.blueAccent,
//            textColor: Colors.white,
//          ),
//        )
//      ],
//    ),
//  );
}
