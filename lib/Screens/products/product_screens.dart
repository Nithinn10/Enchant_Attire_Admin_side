import 'package:enchant_attire_admin/Screens/products/add_products.dart';
import 'package:enchant_attire_admin/Screens/products/products_detail.dart';
import 'package:enchant_attire_admin/common_widgets/loadingIndicator.dart';
import 'package:enchant_attire_admin/consts/lists.dart';
import 'package:enchant_attire_admin/services/store_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../common_widgets/normalText.dart';
import '../../consts/consts.dart';
import '../../controllers/products_controller.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {

    var controller = Get.put(ProductsController());
    String formattedDate = DateFormat.yMMMMd().format(DateTime.now());
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: enchant,
        onPressed: () async{
          await controller.getCategories();
          controller.populateCategoryList();
          Get.to(const AddProduct());
        },
        child: Icon(
          Icons.add,
          color: whiteColor,
        ),
      ),
      appBar: AppBar(
        title:
            products.text.fontFamily(semibold).color(enchant).size(16).make(),
        actions: [
          normalText(
            text: formattedDate,
            color: enchant,
          ),
          10.widthBox
        ],
      ),
      body: StreamBuilder(
        stream: StoreServices.getProducts(currentUser!.uid),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: loadingIndicator());
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text(
                "No products added",
                style: TextStyle(
                  fontFamily: semibold,
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            );
          } else {
            var data = snapshot.data!.docs;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: List.generate(
                    data.length,
                    (index) => ListTile(
                      onTap: () {
                        Get.to(ProductDetails(data: data[index]));
                      },
                      leading: Image.network(
                        '${data[index]['p_images'][0]}',
                        width: 100,
                        height: 100,
                        fit: BoxFit.fitHeight,
                      ),
                      title: "${data[index]['p_name']}"
                          .text
                          .color(Colors.black)
                          .fontFamily(semibold)
                          .size(14)
                          .make(),
                      subtitle: Row(
                        children: [
                          "${data[index]['price']}"
                              .numCurrency
                              .text
                              .color(Colors.black)
                              .fontFamily(semibold)
                              .size(12)
                              .make(),
                          10.widthBox,
                          (data[index]['is_featured'] == true ? "Featured" : "")
                              .text
                              .color(enchant)
                              .fontFamily(semibold)
                              .size(12)
                              .make(),
                        ],
                      ),
                      trailing: VxPopupMenu(
                        arrowSize: 0.0,
                        child: Icon(Icons.more_vert_rounded),
                        menuBuilder: () => Column(
                          children: List.generate(
                            popupMenuIcons.length,
                            (i) => Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                children: [
                                  Icon(popupMenuIcons[i]
                                  
                                  ),
                                  10.widthBox,
                                  popupMenuTitles[i]
                                      .text
                                      .color(Colors.black)
                                      .fontFamily(semibold)
                                      .size(14)
                                      .make()
                                ],
                              ).onTap(() {

                                  switch (i) {
                                    case 0:
                                    
                                      
                                      break;
                                    case 1:
                                    controller.removeProduct(data[index].id);
                                    VxToast.show(context, msg: "Product Removed");
                                    break;
                                    default:
                                  }
                            
                              }),
                            ),
                          ),
                        ).box.white.rounded.width(200).make(),
                        clickType: VxClickType.singleClick,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
