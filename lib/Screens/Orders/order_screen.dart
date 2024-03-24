import 'package:enchant_attire_admin/Screens/Orders/order_details.dart';
import 'package:enchant_attire_admin/common_widgets/loadingIndicator.dart';
import 'package:enchant_attire_admin/controllers/orders_controller.dart';
import 'package:enchant_attire_admin/services/store_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' ;
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../common_widgets/normalText.dart';
import '../../consts/consts.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    var controller= Get.put(OrderController());

    String formattedDate = DateFormat.yMMMMd().format(DateTime.now());
    String formattedDatee = DateFormat.yMd().format(DateTime.now());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Orders",
          style: TextStyle(
            fontFamily: semibold,
            color: enchant,
            fontSize: 16,
          ),
        ),
        actions: [
          Row(
            children: [
              normalText(
                text: formattedDate,
                color: enchant,
              ),
              SizedBox(width: 10),
            ],
          )
        ],
      ),
      body: StreamBuilder(stream: StoreServices.getOrders(currentUser!.uid), 
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
        if(!snapshot.hasData){
          return Center(child: loadingIndicator());
        }else{
          var data = snapshot.data!.docs;

          return Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: List.generate(
              data.length,
              (index) {

                var time = DateFormat.yMd().add_jm().format(data[index]['ordered_date'].toDate());


                return ListTile(
                onTap: () {
                  Get.to(OrderDetails(data: data[index],));
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                tileColor: const Color.fromARGB(199, 245, 245, 245),
                title: Text(
                  "${data[index]['order_code']}  "  "${data[index]['order_by_email']}",
                  style: TextStyle(
                    fontFamily: semibold,
                    color: Colors.black,
                    fontSize: 14,
                  ),
                ),
                subtitle: Column(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.calendar_month, color: enchant,size: 14,),
                        Text(
                          time,
                          style: TextStyle(
                            fontFamily: semibold,
                            color: enchant,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),

                     Row(
                      children: [
                        Icon(Icons.payment, color: enchant,size: 14,),
                        Text(
                         "${data[index]['payment_status']}",
                          style: TextStyle(
                            fontFamily: semibold,
                            color: enchant,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                  
                ),
                trailing: " ${data[index]['total_amount']}".numCurrency.text.size(14).fontFamily(semibold).color(enchant).make(),
              ).box.margin(EdgeInsets.only(bottom: 4)).make();
              }
            ),
            
          ),
        ),
      );
        }
      }),
    );
  }
}
