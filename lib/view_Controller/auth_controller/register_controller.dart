import 'package:clochard/database_service/auth_service.dart';
import 'package:clochard/model/user.dart';
import 'package:clochard/view_Controller/auth_controller/login_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:get/get.dart';

class RegisterController extends GetxController {
  bool _registerFromLoading = false;
  String? _registerEmail;
  String? _registerPassword;
  String? _nom, _adresse, _codePostal, _prenom, _region, _tel;
  bool _passwordVisibl = false;
  bool get passwordVisibl => _passwordVisibl;
  List<String> _errorsSignUp = [];
  

  String? get nom => _nom;
  set nom(String? value) {
    _nom = value;
  }

  String? get adresse => _adresse;
  set adresse(String? value) {
    _adresse = value;
  }

  String? get codePostal => _codePostal;
  set codePostal(String? value) {
    _codePostal = value;
  }

  String? get prenom => _prenom;
  set prenom(String? value) {
    _prenom = value;
  }

  String? get region => _region;
  set region(String? value) {
    _region = value;
  }

  String? get tel => _tel;
  set tel(String? value) {
    _tel = value;
  }

  List<String> get errorsSignUp => _errorsSignUp;

  String get registerEmail => _registerEmail!;
  String get registerPassword => _registerPassword!;

  set registerEmail(String email) {
    _registerEmail = email;
  }

  set registerPassword(String password) {
    _registerPassword = password;
  }

  set passwordVisibl(bool visivilite) {
    _passwordVisibl = visivilite;
    update();
  }

  addError(List<String> list, String error) {
    list.add(error);
    update();
  }

  removeError(List<String> list, String error) {
    list.remove(error);
    update();
  }

  clearError(List<String> list) {
    list.clear();
    update();
  }

  bool get registerFormLoading => _registerFromLoading;
  set registerFormLoading(bool value) {
    _registerFromLoading = value;
  }

  Future<void> creatUser() async {
    _registerFromLoading = true;
    update();
    UserModel user = UserModel(
        email: _registerEmail,
        password: _registerPassword,
        region: _region,
        prenom: _prenom,
        tel: _tel,
        codePostal: _codePostal,
        adresse: _adresse,
        nom: _nom);
    await AuthService().creatUser(user);
  
   

    _registerFromLoading = false;
    update();
  }
}
