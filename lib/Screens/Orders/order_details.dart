import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enchant_attire_admin/consts/consts.dart';
import 'package:enchant_attire_admin/controllers/orders_controller.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;

import '../../consts/styles.dart';
import 'components/order_place_details.dart';
import 'components/order_status.dart';
import 'package:intl/intl.dart' as intl;


class OrderDetails extends StatefulWidget {
  
  final dynamic data;

  const OrderDetails({Key? key, this.data}) : super(key: key);

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  var controller = Get.find<OrderController>();

  @override
  void initState() {
    
    super.initState();
    controller.getOrder(widget.data);
    controller.confirmed.value = widget.data["order_confirmed"];
    controller.ondelivery.value = widget.data["out_for_delivery"];
    controller.delivered.value = widget.data["order_delivered"];
  }

  @override
  Widget build(BuildContext context) {
   
    print(widget.data);

    return Obx(
      ()=> Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            "Order Details",
            style: TextStyle(
              fontFamily: semibold,
              color: Colors.black,
              fontSize: 14,
            ),
          ),
        ),
        bottomNavigationBar: Visibility(
          visible: !controller.confirmed.value,
          child: SizedBox(
            height: 60,
            width: context.screenWidth,
            child: ElevatedButton(onPressed: (){
              controller.confirmed(true);
              controller.changeStatus(title : "confirmed", status: true, docID: widget.data.id);
            }, 
          style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
              shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0.0), // Set borderRadius to zero to make it square
          ),
           minimumSize: Size(60, 60),
          
           // Set background color to green
              ),
            child: Text("Confirm Order",
            style: TextStyle(color: whiteColor,fontFamily: semibold),
            )),
          ),
        ),
        body:
        
         Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Visibility(
                  visible: controller.confirmed.value,
                  child: Column(
                    
                   
                    children: [
                      Padding(padding: EdgeInsets.all(12)),
                       "Order Status".text.color(enchant).fontFamily(semibold).size(14).makeCentered(),
                      SwitchListTile(

                        activeTrackColor: Colors.green,
                        value: true,
                         onChanged: (value){
                        
                  
                      },title: 'Placed'.text.fontFamily(semibold).make(),activeColor: fontGrey,),
                      SwitchListTile(
                        activeTrackColor: Colors.green,
                        value: controller.confirmed.value, 
                        onChanged: (value){
                            controller.changeStatus(title : "order_confirmed", status: true, docID: widget.data.id);
                            controller.confirmed.value = value;
                      },title: 'Confirmed'.text.fontFamily(semibold).make(),activeColor: fontGrey,),
                      SwitchListTile(
                        activeTrackColor: Colors.green,
                        value: controller.ondelivery.value,
                        
                         onChanged: (value){
                          controller.confirmed(true);
              controller.changeStatus(title : "out_for_delivery", status: true, docID: widget.data.id);
                            controller.ondelivery.value = value;
                      },title: 'On delivery'.text.fontFamily(semibold).make(),activeColor: fontGrey,),
                      SwitchListTile(
                        activeTrackColor: Colors.green,
                        value: controller.delivered.value,
                         onChanged: (value){controller.confirmed(true);
              controller.changeStatus(title : "order_delivered", status: true, docID: widget.data.id);
                            controller.delivered.value = value;
                      },title: 'Delivered'.text.fontFamily(semibold).make(),activeColor: fontGrey,),
                    ],
                  
                  
                  ).box.roundedSM.white.make(),
                ),
                Divider(),
                SizedBox(height: 10),
                orderPlaceDetails(
                  d1: widget.data != null ? widget.data['order_code'] : '',
                  d2: widget.data != null ? widget.data['shipping_method'] : '',
                  title1: "Order Code",
                  title2: "Shipping Method",
                ),
                orderPlaceDetails(
                  d1: widget.data != null
                      ? intl.DateFormat().add_yMd().format((widget.data['ordered_date'].toDate()))
                      : '',
                  d2: widget.data != null ? widget.data['payment_method'] : '',
                  title1: "Order Date",
                  title2: "Payment Method",
                ),
                orderPlaceDetails(
                  d1: widget.data != null ? widget.data['payment_status'] : '',
                  d2: "Order Placed",
                  title1: "Payment Status",
                  title2: "Delivery Status",
                ),
                 
                Divider(),
            
                
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        "Shipping Address".text.fontFamily(semibold).make(),
                        "${widget.data['client_name']}".text.size(10).make(),
                        "${widget.data['order_by_email']}".text.size(10).make(),
                        "${widget.data['order_by_address']}".text.size(10).make(),
                        
                        "${widget.data['landmark']}".text.size(10).make(),
                        "${widget.data['district']}".text.size(10).make(),
                        "${widget.data['phone_no']}".text.size(10).make(),
                    
                    
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 100,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        "Total Amount".text.fontFamily(semibold).make(),
                        "${widget.data['total_amount']}".text.color(enchant).make(),
                        
                      ],
                    ),
                  ),
                ],),
               Divider(),
                10.heightBox,
                "Ordered Product".text.size(14).color(enchant).make(),
            
                ListView(
                  physics : const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: List.generate(controller.orders.length, (index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        orderPlaceDetails(
                          title1:'${controller.orders[index]['title']}',
                          title2: widget.data['orders'][index]['tprice'],
                          d1:"${widget.data['orders'][index]['qty']}",
                          d2:"Refundable"
                        ),
                        const Divider(),
                      ],
                    );
                  }).toList(),
      
                 
                ),
                 10.heightBox,
      
                
      
      
      
              ],
              
            ),
          ),
          
        ),
        
      
      ),
    );
  }
}
