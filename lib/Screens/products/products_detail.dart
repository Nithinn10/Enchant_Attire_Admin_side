import 'package:enchant_attire_admin/consts/consts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../consts/styles.dart';

class ProductDetails extends StatelessWidget {
  final dynamic data;
  const ProductDetails({Key? key, this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: "${data['p_name']}".text.fontFamily(semibold).size(15).make(),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            VxSwiper.builder(
              autoPlay: true,
              itemCount: data['p_images'].length,
              aspectRatio: 16 / 9,
              viewportFraction: 0.9,
              itemBuilder: (context, index) {
                return Container(
                  height: 200,
                  child: Image.network(
                    data['p_images'][index],
                    width: 250,
                    height: 140,
                  ),
                );
              },
            ),
            const SizedBox(height: 30),
            "${data['p_name']}"
                .text
                .color(Colors.black)
                .fontFamily(bold)
                .size(14)
                .align(TextAlign.left)
                .make(),
            const SizedBox(height: 20),
            VxRating(
              value: double.parse(data['pro_rating']),
              onRatingUpdate: (value) {},
              normalColor: Colors.black,
              selectionColor: golden,
              count: 5,
              maxRating: 5,
              size: 25,
            ),
             Text(
              '${data['price']}',
              style: TextStyle(fontFamily: semibold, fontSize: 16),
            ),
            const SizedBox(height: 10),
             Text(
              '${data['pro-des']}',
              style: TextStyle(fontFamily: semibold, fontSize: 16),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                
                Text("${data['pro_category']}",style: TextStyle(color: Colors.black,fontFamily: semibold),),
                10.widthBox,
                Text("${data['p_subcategory']}",style: TextStyle(color: Colors.black,fontFamily: semibold),)
              ],
            )
            // Row(
            //   children: [
            //     _buildSelectableChip(context, 0, data['size_s']),
            //     const SizedBox(width: 10),
            //     _buildSelectableChip(context, 1, data['size_m']),
            //     const SizedBox(width: 10),
            //     _buildSelectableChip(context, 2, data['customize']),
            //   ],
            // ),
          , SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Seller",
                        style: TextStyle(fontFamily: semibold),
                      ),
                      SizedBox(height: 5),
                      Text(
                        '${data['p_seller']}',
                        style: TextStyle(fontFamily: semibold, color: enchant),
                      ),
                    ],
                  ),
                ),
                CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.message_rounded,
                    color: enchant,
                  ),
                ).onTap(() {
                  // Get.to(()=>ChatScreen(),
                  //  arguments: [data['p_seller'],data['vendor_id']],
                  // );
                }),
              ],
            ).box
                .height(60)
                .padding(const EdgeInsets.symmetric(horizontal: 12))
                .color(Colors.white10)
                .make(),
            const SizedBox(height: 20),
            Column(
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 100,
                      child:  Text(
                        "Quantity : ",
                        style: TextStyle(fontFamily: semibold),
                      ),
                    ),
                     Text(
                      '${data['quantity']}',
                      style: TextStyle(fontFamily: semibold),
                    ),
                    // Obx(
                    //   () => Row(
                    //     children: [
                    //       2.widthBox,
                    //       Text(
                    //         "(${data['quantity']} available)",
                    //         style: TextStyle(fontFamily: semibold),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                  ],
                ).box.padding(const EdgeInsets.all(8)).make(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
