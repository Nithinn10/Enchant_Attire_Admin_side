import 'package:enchant_attire_admin/Screens/Authentication/Home/home_screen.dart';
import 'package:enchant_attire_admin/Screens/Orders/order_screen.dart';

import 'package:enchant_attire_admin/Screens/products/product_screens.dart';
import 'package:enchant_attire_admin/Screens/profile/profile_screen.dart';
import 'package:enchant_attire_admin/consts/consts.dart';
import 'package:enchant_attire_admin/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HomeController());
    var navScreens = [
      const HomeScreen(),const ProductScreen(),const OrderScreen(),const ProfileScreen()
    ];


    var bottomNavbar = [
      BottomNavigationBarItem(icon: Icon(Icons.home),label: dashboard
      
      ),
       BottomNavigationBarItem(icon: Image.asset(icproducts,color: darkFontGrey,width: 25,), label: products,
      
      ),
       BottomNavigationBarItem(icon: Image.asset(icOrders,width:25,color: darkFontGrey),label: order
      
      ),
       BottomNavigationBarItem(icon: Image.asset(icGeneralSettings,width:25,color: darkFontGrey),label: settings
      
      ),
    ];
    return Scaffold(
      bottomNavigationBar: Obx(
        ()=> BottomNavigationBar(
          onTap: (index){
            controller.navIndex.value = index;
          },
          currentIndex: controller.navIndex.value,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: enchant,
          unselectedItemColor: darkFontGrey,
          items: bottomNavbar),
      ),
      body: Obx(
        ()=> Column(
          children: [
            Expanded(child: navScreens.elementAt(controller.navIndex.value))
          ],
        ),
      ),
    );
  }
}