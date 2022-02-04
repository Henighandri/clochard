import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController{

FirebaseAuth _auth = FirebaseAuth.instance;
FirebaseAuth get auth=>_auth;
Rxn<User> _user=Rxn<User>();
 String? get user => _user.value?.email;
@override
  void onInit() {
    // TODO: implement onInit
    _user.bindStream(_auth.authStateChanges());
    super.onInit();
  }

void logout(){
  _auth.signOut();
}
}