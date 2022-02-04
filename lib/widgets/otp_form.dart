import 'package:flutter/material.dart';



import '../constants.dart';

class OtpForm extends StatefulWidget {

   OtpForm({
    Key? key,
   
  }) : super(key: key);
  @override
  _OtpFormState createState() => _OtpFormState();
}

class _OtpFormState extends State<OtpForm> {
String optValue='';

  
  FocusNode? pin2FocusNode;
  FocusNode? pin3FocusNode;
  FocusNode? pin4FocusNode;
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pin2FocusNode=FocusNode();
    pin3FocusNode=FocusNode();
    pin4FocusNode=FocusNode();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    pin2FocusNode!.dispose();
    pin3FocusNode!.dispose();
    pin4FocusNode!.dispose();
  }

  void nextField({String? value,FocusNode? focusNode}){
    if(value!.length==1){
        optValue=optValue+value;
      if(focusNode!=null){
      focusNode.requestFocus();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
           SizedBox(height:20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(width:40,),
              Container(
                color: Colors.white,
                width: 40,
                height: 40,
                alignment: Alignment.center,
                child: TextFormField(
                  
                  autofocus: true,
                 // obscureText: true,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24,color: Colors.black),
                  decoration: OtpDecoration,
                  onChanged: (value){
                    nextField(value: value,focusNode: pin2FocusNode);
                  },
                )),
                  Container(
                color: Colors.white,
                width:40,
                height: 40,
                child: TextFormField(
                  focusNode: pin2FocusNode,
               //   obscureText: true,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24,color: Colors.black),
                  decoration: OtpDecoration,
                  onChanged: (value){
                     nextField(value: value,focusNode: pin3FocusNode);
                  },
                )),
                 Container(
                color: Colors.white,
                width: 40,
                height: 40,
                child: TextFormField(
                  focusNode: pin3FocusNode,
                 // obscureText: true,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24,color: Colors.black),
                  decoration: OtpDecoration,
                  onChanged: (value){
                     nextField(value: value,focusNode: pin4FocusNode);
                  },
                )),
                  Container(
                color: Colors.white,
                width: 40,
                height: 40,
                child: TextFormField(
                  focusNode: pin4FocusNode,
                 // obscureText: true,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24,color: Colors.black),
                  decoration: OtpDecoration,
                  onChanged: (value){
                    pin4FocusNode!.unfocus();
                    nextField(value: value,focusNode: null);
                   // print(otpvalue);
                  },
                )),
               SizedBox(width:40,),
            ],
          ),
           SizedBox(height: 20,),
           
        ],
      ),
      
      
    );
  }
}
