import 'package:clochard/Screen/Home_screen.dart';
import 'package:clochard/database_service/auth_service.dart';
import 'package:clochard/view_Controller/profil_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
      bool _registerFromLoading = false;

      String? _signInEmail;
      String? _signInPassword;
      List<String> _errorsSignIn = [];

     
      bool _passwordVisibl = false;






  

      bool get passwordVisibl => _passwordVisibl;
    

      

      
    
      List<String> get errorsSignIn => _errorsSignIn;
      

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
    
      String get signInEmail => _signInEmail!;
      String get signInPassword => _signInPassword!;

      set registerFormLoading(bool value) {
        _registerFromLoading = value;
      }

      

      set signInEmail(String email) {
        _signInEmail = email;
      }

      set signInPassword(String password) {
        _signInPassword = password;
      }
    /*************Method************** */


      void signInethod() async {
        _registerFromLoading = true;
    update();
        String? result =
            await AuthService().signIn(_signInEmail!, _signInPassword!);
            // print(result);
        if (result != null) {
          //print(result);
          if (result != "Error") addError(_errorsSignIn, result);
         
        } else {
        
        Get.back();
          
          
        }

        _registerFromLoading = false;
        update();
      }

      resetPassword() {
        AuthService().resetPassword(_signInEmail!);
      }
}
