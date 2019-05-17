import 'package:app/color_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  void onClickLogin() {
    print('Test onClick');
  }

  /*
  Top
   */
  Widget logo() => Container(
      alignment: Alignment.center,
      child: new Image.asset(
        'asset/logo.png',
        width: 150,
        height: 150,
      ));

  Widget topSection() => Container(
        padding: new EdgeInsets.only(top: 80, bottom: 24),
        child: logo(),
      );
  /*
  Center
   */

  BoxDecoration bgFormRegister = new BoxDecoration(
      border: new Border.all(color: Colors.grey),
      borderRadius: new BorderRadius.all(Radius.circular(15)));

  Widget getEditText(String title) {
    List<TextInputFormatter> input = new List();
    return new Padding(
        padding: EdgeInsets.only(left: 40, top: 8, right: 40, bottom: 8),
        child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(left: 20),
            height: 45.0,
            child: new TextField(
              inputFormatters: input,
              decoration:
                  new InputDecoration(border: InputBorder.none, hintText: title, counterText: ''),
              textAlign: TextAlign.left,
              onChanged: (data) {},
            ),
            decoration: bgFormRegister));
  }

  Widget loginButton(double screenWidth) => Padding(
      padding: EdgeInsets.only(left: 40, top: 8, right: 40, bottom: 8),
      child: new Container(
          alignment: Alignment.center,
          child: new SizedBox(
            height: 45.0,
            width: screenWidth,
            child: new RaisedButton(
              onPressed: onClickLogin,
              shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(22.5)),
              color: ColorGuide.colorPrimary,
              child: Text("เข้าใช้งานระบบ", style: TextStyle(color: Colors.white, fontSize: 16.0)),
            ),
          )));

  /*
  Bottom
   */

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(this.context).size.width;

    final formLogin = <Widget>[
      getEditText("บัญชีผู้ใช้งาน"),
      getEditText("รหัสผ่าน"),
      loginButton(screenWidth)
    ];

    final Widget middleSection = new Expanded(
      child: new Container(
        child: Column(
          children: formLogin,
        ),
      ),
    );

    final body = new Column(
      // This makes each child fill the full width of the screen
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[topSection(), middleSection],
    );
    return Scaffold(
      body: SafeArea(child: body),
      resizeToAvoidBottomPadding: false,
    );
  }
}
