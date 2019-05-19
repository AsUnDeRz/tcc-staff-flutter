import 'package:app/color_config.dart';
import 'package:app/model/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  static String routeName = "/login";
  @override
  State<StatefulWidget> createState() => new LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  TextEditingController username;
  TextEditingController password;

  @override
  void initState() {
    username = TextEditingController(text: "");
    password = TextEditingController(text: "");
    super.initState();
  }

  void onClickLogin() {
    print('Test onClick');
  }

  Future<Widget> _showAlert(BuildContext context, String message) async {
    return showDialog(
        context: context,
        child: new AlertDialog(
          title: new Text(message),
          actions: <Widget>[
            new FlatButton(onPressed: () => Navigator.pop(context), child: new Text('Ok'))
          ],
        ));
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

  Widget getEditText(String title, TextEditingController controller, {bool isPassword = false}) {
    List<TextInputFormatter> input = new List();
    return new Padding(
        padding: EdgeInsets.only(left: 40, top: 8, right: 40, bottom: 8),
        child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(left: 20),
            height: 45.0,
            child: new TextFormField(
              obscureText: isPassword,
              controller: controller,
              inputFormatters: input,
              decoration:
                  new InputDecoration(border: InputBorder.none, hintText: title, counterText: ''),
              textAlign: TextAlign.left,
            ),
            decoration: bgFormRegister));
  }

  Widget loginButton(double screenWidth, UserRepository userRepo) => Padding(
      padding: EdgeInsets.only(left: 40, top: 8, right: 40, bottom: 8),
      child: new Container(
          alignment: Alignment.center,
          child: new SizedBox(
            height: 45.0,
            width: screenWidth,
            child: new RaisedButton(
              onPressed: () {
                userRepo.authen(username.text, password.text);
              },
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
    final user = Provider.of<UserRepository>(context);

    var screenWidth = MediaQuery.of(this.context).size.width;

    final formLogin = <Widget>[
      getEditText("บัญชีผู้ใช้งาน", username),
      getEditText("รหัสผ่าน", password, isPassword: true),
      loginButton(screenWidth, user)
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
      body: SafeArea(
          child: user.status == Status.Authenticating
              ? Center(child: CircularProgressIndicator())
              : body),
      resizeToAvoidBottomPadding: false,
    );
  }

  @override
  void dispose() {
    username.dispose();
    password.dispose();
    super.dispose();
  }
}
