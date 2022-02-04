

import 'package:clochard/view_Controller/auth_controller/login_controller.dart';
import 'package:clochard/view_Controller/auth_controller/register_controller.dart';
import 'package:clochard/widgets/Register_widget.dart';

import 'package:clochard/widgets/login_widget.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../responsive.dart';

class AuthWidget extends StatefulWidget {
  const AuthWidget({Key? key}) : super(key: key);

  @override
  _AuthWidgetState createState() => _AuthWidgetState();
}

class _AuthWidgetState extends State<AuthWidget> {
  
  @override
  void initState() {
  Get.put(LoginController());
  Get.put(RegisterController());
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
       final bool isTablet = Responsive.isTablet(context);
    return  Container(
       
        padding: EdgeInsets.symmetric(horizontal: 50),
        width: MediaQuery.of(context).size.width,
       // height: MediaQuery.of(context).size.height*.7,
        child: Row(
          children: [
            Expanded(
              flex:isTablet?2: 1,
              child: Login_widget()),
            Expanded(
              flex:isTablet ? 3: 2,
                child: RegisterWidget()),
          ],
        ),
   
    );
  }
   
}
