import 'package:clochard/helper/extension.dart';
import 'package:clochard/model/categories.dart';
import 'package:clochard/model/produit.dart';
import 'package:clochard/view_Controller/commande_controller.dart';
import 'package:clochard/view_Controller/detailController.dart';
import 'package:clochard/view_Controller/home_view_controller.dart';
import 'package:clochard/widgets/category.dart';
import 'package:clochard/widgets/custom_app_bar.dart';
import 'package:clochard/widgets/custom_footer.dart';
import 'package:clochard/widgets/detail_produit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailScreen extends StatefulWidget {
  DetailScreen({
    Key? key,
  }) : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  void initState() {
    Get.create<DetailController>(() => DetailController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<DetailController>(
        builder: (controller) => Column(
          children: [
            CustomAppBar(
              isDetailProduit: true,
              pressDrawer: () {},
            ),
            Expanded(
                    child: controller.isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : SingleChildScrollView(
                      child: Column(
                        children: [
                          DetailProduit(
                            idCategory:
                                Get.parameters["idCategorie"].toString(),
                            controller: controller,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Center(
                            child: Category(
                                idCategory:
                                    Get.parameters["idCategorie"].toString(),
                                categorieName:
                                    Get.parameters["nomcategories"].toString(),
                                listProduits: controller.listProduit),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          CustemFooter(),
                        ],
                      ),
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
