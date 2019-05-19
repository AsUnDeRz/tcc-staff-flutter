import 'package:app/main.dart';
import 'package:app/model/user_repository.dart';
import 'package:app/screen/concert_list_screen.dart';
import 'package:app/screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class LaunchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      builder: (_) => UserRepository.instance(),
      child: Consumer(
        builder: (context, UserRepository user, _) {
          switch (user.status) {
            case Status.Uninitialized:
              return LoginScreen();
            case Status.Unauthenticated:
            case Status.Authenticating:
              return LoginScreen();
            case Status.Authenticated:
              return ConcertScreen();
          }
        },
      ),
    );
  }
}
