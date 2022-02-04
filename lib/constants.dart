import 'package:flutter/material.dart';

final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kEmailNullError = "Veuillez entrer une adresse e-mail";
const String kInvalidEmailError = "SVP entrer une adresse e-mail valide";
const String kPassNullError = "Veuillez entrer votre mot de passe";
const String kPassNullError2 = "Veuillez confirmer une adresse e-mail";
const String kShortPassError = "Votre mot de passe doit comporter \nentre 8 et 20 caractères";
//const String kMatchPassError = "Passwords don't match";
const String kNamelNullError = "Veuillez entrer votre nom";
const String kPrenomNullError = "Veuillez entrer votre prénom";
const String kCodePostalNull = "Veuillez entrer votre code postal";
const String kRegionNull = "Veuillez entrer votre region";
const String kPhoneNumberNullError = "Veuillez entrer votre numero ";
const String kAddressNullError = "Svp entrer votre address";
const String kShorPhoneNumberError = "SVP entrer un numero valide";


final  OtpDecoration=InputDecoration(
               contentPadding: EdgeInsets.symmetric(vertical: 15),
                enabledBorder: outlineInputBorder(),
                focusedBorder: outlineInputBorder(),
                border: outlineInputBorder(),
               
                );

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
              borderRadius: BorderRadius.circular(0),
              borderSide: BorderSide(color: Colors.grey),
            );
}