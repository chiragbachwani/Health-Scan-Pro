// import 'package:quick_buy/controller/product_controller.dart';
// import 'package:quick_buy/views/chat_screen/chat_screen.dart';

// import '../../const/const.dart';
// import '../../const/lists.dart';
// import '../../widgets_common/our_button.dart';

// class ItemDetails extends StatelessWidget {
//   final String? title;

//   final dynamic data;
//   const ItemDetails({super.key, required this.title, this.data});

//   @override
//   Widget build(BuildContext context) {
//     var controller = Get.put(ProductController());
//     return WillPopScope(
//       onWillPop: () async {
//         controller.resetValue();
//         return true;
//       },
//       child: Scaffold(
//         backgroundColor: whiteColor,
//         appBar: AppBar(
//           title: title!.text.bold.color(darkFontGrey).make(),
//           actions: [
//             IconButton(onPressed: () {}, icon: const Icon(Icons.share)),
//             Obx(
//               () => IconButton(
//                   onPressed: () {
//                     if (controller.isFav.value) {
//                       controller.removeFromWishlist(data.id, context);
//                     } else {
//                       controller.addToWishlist(data.id, context);
//                     }
//                   },
//                   icon: controller.isFav.value
//                       ? const Icon(
//                           Icons.favorite,
//                           color: Colors.red,
//                         )
//                       : const Icon(Icons.favorite_outline)),
//             ),
//           ],
//           leading: IconButton(
//               onPressed: () {
//                 controller.resetValue();
//                 Get.back();
//               },
//               icon: const Icon(Icons.arrow_back_ios)),
//         ),
//         body: Column(
//           children: [
//             Expanded(
//                 child: Padding(
//               padding: const EdgeInsets.all(8),
//               child: SingleChildScrollView(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     VxSwiper.builder(
//                       autoPlay: true,
//                       height: 350,
//                       aspectRatio: 16 / 9,
//                       itemCount: data['p_imgs'].length,
//                       itemBuilder: (context, index) {
//                         return Image.network(
//                           data['p_imgs'][index],
//                           width: double.infinity,
//                           fit: BoxFit.cover,
//                         );
//                       },
//                       viewportFraction: 1.1,
//                     ),
//                     10.heightBox,
//                     title!.text.size(16).color(darkFontGrey).semiBold.make(),
//                     10.heightBox,
//                     VxRating(
//                       isSelectable: false,
//                       value: double.parse(data['p_rating']),
//                       onRatingUpdate: (value) {},
//                       normalColor: textfieldGrey,
//                       selectionColor: golden,
//                       count: 5,
//                       maxRating: 5,
//                       size: 25,
//                     ),
//                     10.heightBox,
//                     "${data['p_price']}"
//                         .numCurrency
//                         .text
//                         .size(18)
//                         .color(turquoiseColor)
//                         .bold
//                         .make(),
//                     10.heightBox,
//                     Row(
//                       children: [
//                         Expanded(
//                             child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             "Seller".text.color(turquoiseColor).semiBold.make(),
//                             5.heightBox,
//                             "${data['p_seller']}"
//                                 .text
//                                 .size(16)
//                                 .semiBold
//                                 .color(darkFontGrey)
//                                 .make()
//                           ],
//                         )),
//                         const CircleAvatar(
//                           backgroundColor: Colors.white,
//                           child:
//                               Icon(Icons.message_rounded, color: darkFontGrey),
//                         ).onTap(() {
//                           Get.to(() => const ChatScreen(),
//                               arguments: [data['p_seller'], data['vendor_id']]);
//                         })
//                       ],
//                     )
//                         .box
//                         .height(60)
//                         .roundedSM
//                         .padding(const EdgeInsets.symmetric(horizontal: 16))
//                         .color(Vx.gray200)
//                         .make(),
//                     20.heightBox,
//                     Obx(
//                       () => Column(
//                         children: [
//                           Row(
//                             children: [
//                               SizedBox(
//                                 width: 100,
//                                 child: "Color".text.color(Vx.gray400).make(),
//                               ),
//                               Row(
//                                 children: List.generate(
//                                     data['p_colors'].length,
//                                     (index) => Stack(
//                                           alignment: Alignment.center,
//                                           children: [
//                                             VxBox()
//                                                 .size(40, 40)
//                                                 .border(
//                                                   color:
//                                                       darkFontGrey.withOpacity(
//                                                           0.5), // Border color
//                                                   width: 1.5, // Border width
//                                                 )
//                                                 .roundedFull
//                                                 .margin(
//                                                     const EdgeInsets.symmetric(
//                                                         horizontal: 4))
//                                                 .color(Color(
//                                                     data['p_colors'][index]))
//                                                 .make()
//                                                 .onTap(() {
//                                               controller
//                                                   .changeColorIndex(index);
//                                             }),
//                                             Visibility(
//                                               visible: index ==
//                                                   controller.colorIndex.value,
//                                               child: const Icon(
//                                                 Icons.done,
//                                                 color: turquoiseColor,
//                                               ),
//                                             )
//                                           ],
//                                         )),
//                               )
//                             ],
//                           ).box.padding(const EdgeInsets.all(8)).make(),

//                           // quantity row

//                           Obx(
//                             () => Row(
//                               children: [
//                                 SizedBox(
//                                   width: 100,
//                                   child:
//                                       "Quantity".text.color(Vx.gray400).make(),
//                                 ),
//                                 Row(
//                                   children: [
//                                     IconButton(
//                                         onPressed: () {
//                                           controller.decreaseQuantity();
//                                           controller.calculateTotalPrice(
//                                               int.parse(data['p_price']));
//                                         },
//                                         icon: const Icon(Icons.remove)),
//                                     controller.quantity.value.text
//                                         .size(19)
//                                         .color(darkFontGrey)
//                                         .bold
//                                         .make(),
//                                     IconButton(
//                                         onPressed: () {
//                                           controller.increaseQuantity(
//                                               int.parse(data['p_quantity']));
//                                           controller.calculateTotalPrice(
//                                               int.parse(data['p_price']));
//                                         },
//                                         icon: const Icon(Icons.add)),
//                                     10.widthBox,
//                                     Row(
//                                       children: [
//                                         "(".text.color(Vx.gray400).make(),
//                                         (int.parse(data['p_quantity']) -
//                                                 controller.quantity.value)
//                                             .toString()
//                                             .text
//                                             .color(Vx.gray400)
//                                             .make(),
//                                         " available)"
//                                             .text
//                                             .color(Vx.gray400)
//                                             .make(),
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ).box.padding(const EdgeInsets.all(8)).make(),
//                           ),
//                           //total row
//                           Row(
//                             children: [
//                               SizedBox(
//                                 width: 100,
//                                 child: "Total".text.color(Vx.gray400).make(),
//                               ),
//                               "${controller.totalPrice.value}"
//                                   .numCurrency
//                                   .text
//                                   .color(turquoiseColor)
//                                   .size(16)
//                                   .bold
//                                   .make(),
//                             ],
//                           ).box.padding(const EdgeInsets.all(8)).make(),
//                         ],
//                       ).box.white.shadowSm.make(),
//                     ),

//                     //description section

//                     10.heightBox,

//                     "Description".text.color(darkFontGrey).semiBold.make(),
//                     10.heightBox,
//                     "${data['p_desc']}".text.color(Vx.gray500).make(),
//                     10.heightBox,

//                     //buttons section
//                     ListView(
//                       physics: const NeverScrollableScrollPhysics(),
//                       shrinkWrap: true,
//                       children: List.generate(
//                           5,
//                           (index) => ListTile(
//                                 title: itemDetailButtonList[index]
//                                     .text
//                                     .semiBold
//                                     .color(darkFontGrey)
//                                     .make(),
//                                 trailing: const Icon(Icons.arrow_forward),
//                               )),
//                     ),

//                     //products may like section

//                     productsyoumaylike.text
//                         .size(16)
//                         .color(darkFontGrey)
//                         .bold
//                         .make(),
//                     10.heightBox,
//                     SingleChildScrollView(
//                       scrollDirection: Axis.horizontal,
//                       child: Row(
//                         children: List.generate(
//                             6,
//                             (index) => Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Image.asset(imgP1,
//                                         width: 150, fit: BoxFit.cover),
//                                     10.heightBox,
//                                     "Laptop 4GB/64GB"
//                                         .text
//                                         .semiBold
//                                         .color(darkFontGrey)
//                                         .make(),
//                                     10.heightBox,
//                                     "\$600"
//                                         .text
//                                         .size(16)
//                                         .color(turquoiseColor)
//                                         .bold
//                                         .make()
//                                   ],
//                                 )
//                                     .box
//                                     .white
//                                     .margin(const EdgeInsets.symmetric(
//                                         horizontal: 5))
//                                     .roundedSM
//                                     .padding(const EdgeInsets.all(8))
//                                     .make()),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             )),
//             SizedBox(
//               width: double.infinity,
//               height: 60,
//               child: ourButton(
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(3)),
//                   color: turquoiseColor,
//                   onPress: () {
//                     if (controller.quantity.value > 0) {
//                       controller.addToCart(
//                           vendorID: data['vendor_id'],
//                           color: data['p_colors'][controller.colorIndex.value],
//                           context: context,
//                           img: data['p_imgs'][0],
//                           qty: controller.quantity.value,
//                           sellername: data['p_seller'],
//                           title: data['p_name'],
//                           tprice: controller.totalPrice.value);

//                       VxToast.show(context, msg: "Added to Cart");
//                     } else {
//                       VxToast.show(context, msg: "Quantity can't be 0");
//                     }
//                   },
//                   textColor: whiteColor,
//                   title: "Add to Cart"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
