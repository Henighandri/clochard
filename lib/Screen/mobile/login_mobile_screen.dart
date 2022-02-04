import 'package:clochard/widgets/login_widget.dart';
import 'package:flutter/material.dart';

import 'customAppBarMobile.dart';

class LoginMobileScreen extends StatelessWidget {
  const LoginMobileScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarMobile(),
    body: Login_widget(),
    );
  }
}