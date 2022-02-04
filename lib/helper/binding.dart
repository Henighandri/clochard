

import 'package:clochard/view_Controller/auth_controller/auth_controller.dart';
import 'package:clochard/view_Controller/auth_controller/login_controller.dart';
import 'package:clochard/view_Controller/auth_controller/register_controller.dart';
import 'package:clochard/view_Controller/commande_controller.dart';
import 'package:clochard/view_Controller/detailController.dart';
import 'package:clochard/view_Controller/home_view_controller.dart';
import 'package:clochard/view_Controller/profil_controller.dart';
import 'package:get/get.dart';

class Binding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => HomeViewController());
    Get.lazyPut(() => LoginController());
    Get.lazyPut(() => RegisterController());
     Get.lazyPut(() => CommandeController());
     Get.lazyPut(() => AuthController());
      Get.lazyPut(() => ProfilController());
      // Get.lazyPut(() => DetailController());
  }

}