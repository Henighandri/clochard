import 'package:clochard/view_Controller/auth_controller/register_controller.dart';
import 'package:flutter/material.dart';



import 'custom_btn.dart';
import 'custom_text.dart';
import 'otp_form.dart';

class OptDialogue extends StatelessWidget {
  RegisterController controller;
   OptDialogue({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
                width: 500,
                height: 400,
                color: Colors.black,
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    CustomText(
                      text: "Code de vérification",
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      alignment: Alignment.center,
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    CustomText(
                      text:
                          "veuillez saisir le code de vérification envoyé au +216 ${controller.tel} ",
                      color: Colors.white,
                      alignment: Alignment.center,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    OtpForm(),
                    Row(
                      children: [
                        SizedBox(width: 50,),
                        CustomText(text: "Renvoyer le code",color: Colors.white,),
                        SizedBox(width: 10,),
                        Icon(Icons.arrow_forward,color: Colors.white,size: 20,),
                      ],
                    ),
                    SizedBox(height: 50,),
                   Container(
                  width: 250,
                  child: CustomBtn(
                    txtColor: Colors.black,
                    text: "Confirmer",
                    bgColor: Color(0xFFFBB03B),
                    isLoading: controller.registerFormLoading,
                    onPressed: () {
                      
                    },
                  ),
                ),
                SizedBox(height: 20,),
               InkWell(
                        onTap: () {
                        
                          Navigator.pop(context);
                        },
                        child: Row(
                          children: [
                            Icon(Icons.arrow_back_ios,color: Colors.white,size: 20,),
                            CustomText(text: "Back",color: Colors.white,),
                          ],
                        )
                        ),

                  ],
                ),
              );
  }
}
