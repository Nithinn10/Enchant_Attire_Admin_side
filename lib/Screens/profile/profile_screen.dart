import 'package:enchant_attire_admin/Screens/Messages/message_screen.dart';
import 'package:enchant_attire_admin/Screens/profile/edit_profile.dart';
import 'package:enchant_attire_admin/common_widgets/loadingIndicator.dart';
import 'package:enchant_attire_admin/consts/consts.dart';
import 'package:enchant_attire_admin/consts/lists.dart';
import 'package:enchant_attire_admin/services/store_services.dart';
import 'package:flutter/material.dart';
import 'package:enchant_attire_admin/controllers/auth_controller.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../Authentication/login.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: settings.text.fontFamily(semibold).color(enchant).size(16).make(),
        actions: [

           IconButton(
            onPressed: () {
              Get.to(ManageProfile());
            },
            icon: const Icon(Icons.edit,color: enchant,), // Icon for edit
          ),

          IconButton(
            onPressed: () async{
              // Add your logout logic here
              await Get.put(AuthController()).signoutMethod(context);
               Get.off(() => LoginScreen());
              
            },
            icon: const Icon(Icons.logout,color: enchant,), // Icon for logout
          ),
         
        ],
      ),
      body: FutureBuilder(future: StoreServices.getProfile(currentUser!.uid),
      
      
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
        if(!snapshot.hasData){
          return Center(child: loadingIndicator());
        }else{

          var data = snapshot.data!.docs[0];


            return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ListTile(
              leading: Image.asset(cat2).box.roundedFull.clip(Clip.antiAlias).make(),
              title: "${data['username']}".text.fontFamily(semibold).color(Colors.black).size(14).make(),

              subtitle: "${data['email']}".text.fontFamily(semibold).color(Colors.black).size(14).make(),
            ),
            Divider(),
            10.heightBox,
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: List.generate(2, (index) => ListTile(
                  onTap: (){
                    switch (index) {
                      case 0:
                      //Get.to(()=> ShopSettings());
                        
                        break;
                        case 1:
                        Get.to(MessagesScreen());
                      default:
                    }
                  },
                  leading: Icon(ProfileButtonIcons[index]),
                  title: profileButtonTitles[index].text.fontFamily(semibold).color(Colors.black).size(14).make(),
                )),
                
              ),
            )
          ],
        ),
      );
        }
        
        
      })
      
    );
  }
}
