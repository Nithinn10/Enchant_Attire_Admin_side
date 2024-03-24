import 'package:enchant_attire_admin/Screens/products/products_detail.dart';
import 'package:enchant_attire_admin/common_widgets/dashboard_button.dart';
import 'package:enchant_attire_admin/common_widgets/loadingIndicator.dart';
import 'package:enchant_attire_admin/common_widgets/normalText.dart';
import 'package:enchant_attire_admin/consts/consts.dart';
import 'package:enchant_attire_admin/controllers/orders_controller.dart';
import 'package:enchant_attire_admin/services/store_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    //var controller= Get.find<OrderController>();
    String formattedDate = DateFormat.yMMMMd().format(DateTime.now());

    return Scaffold(
      appBar: AppBar(
        title: "Dashboard".text.fontFamily(semibold).color(enchant).size(16).make(),
        actions: [
          normalText(text: formattedDate, color: enchant,),10.widthBox
        ],
      ),
       body: StreamBuilder(
        stream:StoreServices.getProducts(currentUser!.uid),
         builder: (BuildContext context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot){
          if (!snapshot.hasData) {
            return Center(child: loadingIndicator());
            
          }else{
            var data = snapshot.data!.docs;
            data = data.sortedBy((a, b) => b['p_wishlist'].length.compareTo(a['p_wishlist'].length));
            
            return  Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
           dashboardButton(context: context, title: products, count: "${data.length}" ,icon: icproducts),
           dashboardButton(context: context, title: order, count: "",icon: icOrders ),
              ],
         
            ),
            10.heightBox,
             Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
           dashboardButton(context: context, title:rating , count: "60",icon: icStar ),
           dashboardButton(context: context, title: tsales, count: "50",icon: icSales),
              ],
         
            ),
          10.heightBox,
          const Divider(),
          10.heightBox,
          "Popular Products".text.fontFamily(semibold).make(),
          ListView(
            physics: BouncingScrollPhysics(),
            shrinkWrap: true,
            children: 
              List.generate(data.length, (index) =>data[index]['p_wishlist'].length == 0 ? const SizedBox() : ListTile(
                onTap: (){
                  Get.to(()=>ProductDetails(data: data[index],));
                },
                leading: Image.network(data[index]['p_images'][0],width: 100, height: 100,fit: BoxFit.contain,),
                title: "${data[index]['p_name']}".text.color(Colors.black).fontFamily(semibold).size(14).make(),
                subtitle: "${data[index]['price']}".text.color(Colors.black).fontFamily(semibold).size(14).make(),
              ))
            ,
          )


          ],
        ),
      );
          }
         })
  
      
    );
  }
}
