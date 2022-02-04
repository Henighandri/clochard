import 'package:clochard/database_service/home_sevice.dart';
import 'package:clochard/model/categories.dart';
import 'package:clochard/model/produit.dart';
import 'package:clochard/view_Controller/commande_controller.dart';
import 'package:clochard/view_Controller/home_view_controller.dart';
import 'package:clochard/view_Controller/profil_controller.dart';
import 'package:get/get.dart';

class DetailController extends GetxController{
    String? categorieName;
    List<Produit> listProduit=[];

    
      


    bool _isLoading=false;
    Produit? _produit;
    Produit? get produit=>_produit;
    set produit(Produit? value){
      _produit=value;
      update();
    }



    bool get isLoading=>_isLoading;
    set isLoading(bool value){
      _isLoading=value;
      update();
    }

   


@override
onInit(){
 
  getData(Get.parameters['idCategorie'].toString(), Get.parameters["idProduit"].toString());
  super.onInit();
}
getData(String idCategory,String idProduit) async {
   isLoading=true;
      
       await getlistProduit(idCategory);
       getProduit(idProduit);
       isLoading=false;
     
}

     
      getlistProduit(String idCategory)  async {
      
       
         await HomeService().getProductFromCategory(idCategory,null).then((value) {
            for(int i=0;i<value.length;i++){
               listProduit.add(Produit(
            images: value[i]["image"],
            name: value[i]['name'],
            price: double.parse(value[i]["prix"].toString()),
            sizes: value[i]["taille"],
            colors: value[i]["colors"],
            solde: double.parse(value[i]["solde"].toString()),
            idProduit: value[i].id));
            }
         });
        
        update();
        
      }
      
  getProduit(String idProduit) async {
         for(int i=0;i<listProduit.length;i++){
          if(listProduit[i].idProduit ==idProduit){
            produit=listProduit[i];
          }
        } 
        
   update();
  
        
  }




int _selectedImage=0;

  int get selectedImage => _selectedImage;
  set selectedImage(int value) {
    _selectedImage = value;
    update();
  }
  /************** */
  int _colorIndex=-1;

  int get colorIndex => _colorIndex;
  set colorIndex(int value) {
    _colorIndex = value;
    update();
  }

  /*************** */
  int _tailleIndex=-1;

  int get tailleIndex => _tailleIndex;
  set tailleIndex(int value) {
    _tailleIndex = value;
    update();
  }

  /******************** */
  int _quantity = 1;
  int? get quantity => _quantity;
  increment() {
    _quantity++;
    update();
  }

  decrement() {
    if (_quantity > 1) {
      _quantity--;
      update();
    }
  }

}