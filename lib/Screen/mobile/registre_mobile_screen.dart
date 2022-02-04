import 'package:clochard/Screen/mobile/customAppBarMobile.dart';
import 'package:clochard/widgets/Register_widget.dart';
import 'package:flutter/material.dart';

class RegistreScreenMobile extends StatelessWidget {
  const RegistreScreenMobile({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarMobile(),
      body: RegisterWidget(),
    );
  }
}