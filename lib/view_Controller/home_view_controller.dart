import 'package:clochard/database_service/home_sevice.dart';
import 'package:clochard/model/categories.dart';
import 'package:clochard/model/produit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeViewController extends GetxController {
  List<Categories> _listCategorie = [];
  List<Categories> get listCategorie => _listCategorie;
  List<Produit> listFiterProduit = [];
  /******** */
  bool _newCollectionSelected = false;
  bool get newCollectionSelected => _newCollectionSelected;
  set newCollectionSelected(bool value) {
    _newCollectionSelected = value;
    update();
  }
  bool _soldeSelected = false;
  bool get soldeSelected => _soldeSelected;
  set soldeSelected(bool value) {
    _soldeSelected = value;
    update();
  }
  //********************** */
int _selected_buttonNavigationBar = 0;
  int get selected_buttonNavigationBar => _selected_buttonNavigationBar;
  set selected_buttonNavigationBar(int value){
    _selected_buttonNavigationBar=value;
    update();
  }
//************************* */
  int _selected_button = -1;
  int get selected_button => _selected_button;
//************************************** */

  ValueNotifier<bool> _loading = ValueNotifier(false);
  ValueNotifier<bool> get loading => _loading;
//***************************** */

  List<String> _tailles = ["XS", "S", "M", "L", "XL", "XXL"];
  List<String> get tailles => _tailles;
  int? _selected_taille;
  int? get selected_taille => _selected_taille;

  //*****************************

  RangeValues _currentRangeValues = RangeValues(1, 500);
  RangeLabels _rangeLabels = RangeLabels("1", "500");
  RangeValues get currentRangeValues => _currentRangeValues;
  RangeLabels get rangeLabels => _rangeLabels;

  set currentRangeValues(RangeValues rangevalue) {
    _currentRangeValues = rangevalue;
    update();
  }

  setrangeLabels() {
    _rangeLabels = RangeLabels(
      _currentRangeValues.start.toString(),
      _currentRangeValues.end.toString(),
    );
    filterListCategory();
    update();
  }

  bool tailleIsExist(List<dynamic> list) {
    if (_selected_taille != null) {
      for (int i = 0; i < list.length; i++) {
        if (_tailles[_selected_taille!] == list.cast<String>()[i]) {
          return true;
        }
      }
    } else {
      return true;
    }
    return false;
  }

  set selected_taille(int? value) {
    _selected_taille = value;
    filterListCategory();
    update();
  }

  void setSelectedButton(int value) {
    _selected_button = value;
    update();
  }

  /* HomeViewController() {
   
  } */
  @override
  void onInit() {
    // TODO: implement onInit
     getAllCategory(null);
    super.onInit();
  }
  void getAllCategory(String? search) async {
    _listCategorie = await getCategory(search);
    update();
  }

  Future<List<Categories>> getCategory(String? search) async {
    _loading.value = true;
    List<Produit>? listProduit = [];
    List<Categories> listCategory = [];
    await HomeService().getCategory().then((value) async {
      for (int i = 0; i < value.length; i++) {
        listProduit = await getProductFromCategory(value[i].id,search);
        listCategory.add(Categories(
            text: value[i]["name"],
            idCategorie: value[i].id,
            listProduits: listProduit));
      }

      _loading.value = false;
    });

    return listCategory;
  }

  Future<List<Produit>?> getProductFromCategory(String idCategory,String? search) async {
    _loading.value = true;
    List<Produit>? listProduit = [];
    await HomeService().getProductFromCategory(idCategory,search).then((value) {
      for (int i = 0; i < value.length; i++) {
        listProduit.add(Produit(
            images: value[i]["image"],
            name: value[i]['name'],
            price: double.parse(value[i]["prix"].toString()),
            sizes: value[i]["taille"],
            colors: value[i]["colors"],
            solde:  double.parse(value[i]["solde"].toString()),
            idProduit: value[i].id));
      }

      _loading.value = false;
    });
    return listProduit;
  }

  filterListCategory() async {
    if (newCollectionSelected) {
     _listCategorie = await getNewCollection();
    } else if(soldeSelected){
      await getSoldeProduct();
    }else{
      _listCategorie = await getCategory(null);
    }

    _listCategorie.forEach((element) {
      filterProduits(element.idCategorie);
    });

    update();
  }

  List<Produit> getAllProduits(String? idCategorie) {
    List<Categories> listCat = _listCategorie
        .where((element) => (element.idCategorie == idCategorie))
        .toList();

    return listCat[0].listProduits!;
  }

  filterProduits(String? idCategorie) {
    List<Produit>? listProduit = getAllProduits(idCategorie);
    listFiterProduit = listProduit
        .where((produit) => (produit.price! >= _currentRangeValues.start &&
            produit.price! <= _currentRangeValues.end &&
            tailleIsExist(produit.sizes!)))
        .toList();
    _listCategorie.forEach((category) {
      if (category.idCategorie == idCategorie) {
        category.listProduits = listFiterProduit;
      }
    });

    update();
  }
  /*********************new collection */

  Future<List<Produit>?> getNewCollectionFromCategory(String idCategory) async {
    _loading.value = true;
    List<Produit>? listProduit = [];
    await HomeService().getNewCollection(idCategory).then((value) {
      for (int i = 0; i < value.length; i++) {
        listProduit.add(Produit(
            images: value[i]["image"],
            name: value[i]['name'],
            price:  double.parse(value[i]["prix"].toString()),
            sizes: value[i]["taille"],
            colors: value[i]["colors"],
            solde:  double.parse(value[i]["solde"].toString()),
            idProduit: value[i].id));
           
      }

      _loading.value = false;
    });
    
    return listProduit;
  }

  Future<List<Categories>> getNewCollection() async {
    
    _loading.value = true;
    List<Produit>? listProduit = [];
    List<Categories> listCategory = [];
    await HomeService().getCategory().then((value) async {
      for (int i = 0; i < value.length; i++) {
        listProduit = await getNewCollectionFromCategory(value[i].id);
        listCategory.add(Categories(
            text: value[i]["name"],
            idCategorie: value[i].id,
            listProduits: listProduit));
      }

      _loading.value = false;
    });
    
    return listCategory;
  }

  Future<void> getNewCollectionMethode() async {
    _listCategorie = await getNewCollection();
    update();
  }
  /*************getSoldeProduct */

  Future<void> getSoldeProduct() async {
    _listCategorie = await getCategory(null);
    List<Categories> listCategory = [];
    List<Produit>? listProduit = [];
    for (int i = 0; i < _listCategorie.length; i++) {
      listProduit = listProduitSolde(i);
      listCategory.add(Categories(
          text: _listCategorie[i].text,
          idCategorie: _listCategorie[i].idCategorie,
          listProduits: listProduit));
    }
    _listCategorie.clear();
    _listCategorie = listCategory;
    update();
  }

  List<Produit> listProduitSolde(int indexCategory) {
    List<Produit> list = [];
    for (int i = 0;
        i < _listCategorie[indexCategory].listProduits!.length;
        i++) {
      if (_listCategorie[indexCategory].listProduits![i].solde! >
          _listCategorie[indexCategory].listProduits![i].price!) {
        list.add(_listCategorie[indexCategory].listProduits![i]);
      }
    }
    return list;
  }



}
