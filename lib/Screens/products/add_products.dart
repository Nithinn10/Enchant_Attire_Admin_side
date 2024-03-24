import 'package:enchant_attire_admin/Screens/products/components/productImages.dart';
import 'package:enchant_attire_admin/Screens/products/components/product_dropdown.dart';
import 'package:enchant_attire_admin/common_widgets/formtext_field.dart';
import 'package:enchant_attire_admin/common_widgets/loadingIndicator.dart';
import 'package:enchant_attire_admin/controllers/products_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../../consts/consts.dart';

class AddProduct extends StatelessWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProductsController>();

    return Obx(
      () => Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Get.back();
              controller.pnameController.clear();
              controller.descController.clear();
              controller.price.clear();
              controller.inBagController.clear();
              controller.qtyController.clear();
            },
            icon: const Icon(Icons.arrow_back),
          ),
          title: "Add Products".text.fontFamily(semibold).size(15).make(),
          actions: [
            controller.isLoading.value
                ? loadingIndicator()
                : TextButton(
                    onPressed: () async {
                      controller.isLoading(true);
                      await controller.uploadImages();
                      await controller.uploadProduct(context);

                      controller.pnameController.clear();
                      controller.descController.clear();
                      controller.price.clear();
                      controller.inBagController.clear();
                      controller.qtyController.clear();

                      // Clear stored images
                      controller.pImagesList.clear();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        'Save',
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: semibold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                5.heightBox,
                FormTextField(
                  hint: 'eg. Shirt',
                  label: "Product name",
                  controller: controller.pnameController,
                ),
                10.heightBox,
                FormTextField(
                  hint: 'eg. description',
                  label: "Description",
                  isDesc: true,
                  controller: controller.descController,
                ),
                10.heightBox,
                FormTextField(
                  hint: 'price',
                  label: "Price",
                  controller: controller.price,
                ),
                10.heightBox,
                FormTextField(
                  hint: '1 pcs set',
                  label: "Items In bag",
                  controller: controller.inBagController,
                ),
                10.heightBox,
                FormTextField(
                  hint: 'eg. qty',
                  label: "Quantity",
                  controller: controller.qtyController,
                ),
                10.heightBox,
                productDropdown("Category", controller.categoryList,
                    controller.categoryvalue, controller),
                10.heightBox,
                productDropdown("Subcategory", controller.subcategoryList,
                    controller.subcategoryvalue, controller),
                10.heightBox,
                "Choose products images".text.fontFamily(semibold).make(),
                10.heightBox,
                controller.pImagesList.isEmpty
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: List.generate(
                          3,
                          (index) => productImages(label: "${index + 1}")
                              .onTap(() {
                            controller.pickImage(index, context);
                          }),
                        ),
                      )
                    : Obx(
                        () => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: List.generate(
                            3,
                            (index) => controller.pImagesList[index] != null
                                ? Image.file(
                                    controller.pImagesList[index],
                                    width: 100,
                                  ).onTap(() {
                                    controller.pickImage(index, context);
                                  })
                                : productImages(label: "${index + 1}")
                                    .onTap(() {
                                    controller.pickImage(index, context);
                                  }),
                          ),
                        ),
                      ),
                5.heightBox,
                "First Image will be the banner image of your product"
                    .text
                    .fontFamily(semibold)
                    .make(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
