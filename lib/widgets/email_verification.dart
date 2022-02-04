
import 'dart:async';

import 'package:clochard/Screen/Home_screen.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'custom_text.dart';

class EmailVerification extends StatefulWidget {
 

  const EmailVerification({
    Key? key,
    
  }) : super(key: key);

  @override
  _EmailVerificationState createState() => _EmailVerificationState();
}

class _EmailVerificationState extends State<EmailVerification> {
  late Timer timer;
  User? user;
  @override
  void initState() {
    user = FirebaseAuth.instance.currentUser;
    
    user!.sendEmailVerification();
   timer = Timer.periodic(Duration(seconds: 3), (timer) {
      checkEmailVerified();
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 500,
      height: 200,
      color: Colors.black,
      padding: EdgeInsets.all(20),
      child: Column(
        //
        mainAxisAlignment: MainAxisAlignment.center,
        
        children: [
          CustomText(
            text: "Un e-mail a été envoyé à ${user!.email} ,\n veuillez vérifier",
            color: Colors.white,
            fontSize: 16,
           alignment: Alignment.center,
          ),
         
        ],
      ),
    );
  }

  Future<void> checkEmailVerified() async {
    user = FirebaseAuth.instance.currentUser;
    await user!.reload();

    if (user!.emailVerified) {
      timer.cancel();
    
      Get.toNamed("/Home");
    }
  }
}
