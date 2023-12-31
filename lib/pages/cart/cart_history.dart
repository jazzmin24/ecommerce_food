import 'dart:convert';
import 'dart:html';

import 'package:delivery/base/no_data_page.dart';
import 'package:delivery/controllers/cart_controller.dart';
import 'package:delivery/models/cart_model.dart';
import 'package:delivery/routes/route_helper.dart';
import 'package:delivery/utils/app_constants.dart';
import 'package:delivery/utils/colors.dart';
import 'package:delivery/utils/dimentions.dart';
import 'package:delivery/widgets/app_icon.dart';
import 'package:delivery/widgets/big_text.dart';
import 'package:delivery/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CartHistory extends StatelessWidget {
  const CartHistory({super.key});  

  @override
  Widget build(BuildContext context) {
    var getCartHistoryList =
        Get.find<CartController>().getCartHistoryList().reversed.toList();
    Map<String, int> cartItemsPerOrder = Map();

    for (int i = 0; i < getCartHistoryList.length; i++) {
      if (cartItemsPerOrder.containsKey(getCartHistoryList[i].time)) {
        cartItemsPerOrder.update(
            getCartHistoryList[i].time!, (value) => ++value);
      } else {
        cartItemsPerOrder.putIfAbsent(getCartHistoryList[i].time!, () => 1);
      }
    }

    List<int> cartItemsPerOrderToList() {
      return cartItemsPerOrder.entries.map((e) => e.value).toList();
    }

    List<String> cartOrderTimeToList() {
      return cartItemsPerOrder.entries.map((e) => e.key).toList();
    }

    List<int> itemsPerOrder = cartItemsPerOrderToList();
    

    var listCounter = 0;
     Widget timeWidget(int index){  
       var outputDate=DateTime.now().toString();
      if(index<getCartHistoryList.length){
       
        DateTime parseDate = DateFormat('yyyy-MM-dd HH:mm:ss').parse(getCartHistoryList[listCounter].time!);
          var inputDate = DateTime.parse(parseDate.toString());
           var outputFormat =DateFormat('MM/dd/yyyy hh:mm a');
          outputDate =outputFormat.format(inputDate);
      }
                                        return BigText(text: outputDate);
    }


    return Scaffold(
      // appBar: AppBar(
      //   actions: [
      //     Icon(Icons.shopping_cart)       //since ye bilkul ebd m h we dont have proper control over it
      //   ],
      //   title: BigText(text: 'Cart History'),
      // ),
      body: Column(
        children: [
          //header or appbar
          Container(
            height: Dimentions.height10 * 10,
            color: AppColors.mainColor,
            width: double.maxFinite,
            padding: EdgeInsets.only(top: Dimentions.height45),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                BigText(
                  text: 'Cart History',
                  color: Colors.white,
                ),
                AppIcon(
                  icon: Icons.shopping_cart_outlined,
                  iconColor: AppColors.mainColor,
                  backgroundColor: AppColors.yellowColor,
                )
              ],
            ),
          ),
          // Expanded(
          //   child: Container(
          //   margin: EdgeInsets.only(
          //     top: Dimentions.height20,
          //     left: Dimentions.width20,
          //     right: Dimentions.width20,
          //   ),
          //   child: ListView(
          //     children: [
          //     for(int i=0; i<itemsPerOrder.length; i++)
          //    Container(
          //     margin:EdgeInsets.only(bottom: Dimentions.height20),
          //     child: Column(
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: [
          //         BigText(text: 'date a to z'),
          //       // Row(
          //       //   children: [
          //       //     Wrap(
          //       //       direction: Axis.horizontal,
          //       //       children: [
          //       //       Text('hlo ppl'),
          //       //       Text('hi ppl'),
          //       //       ],
          //       //     )
          //       //   ],
          //       // )
          //       ],
          //     ),

          //    )
          //     ],
          //   ),
          //   )
          // )

//body
          GetBuilder<CartController>(builder: (_cartController) {
           return _cartController.getCartHistoryList().length > 0
                ? Expanded(
                    child: Container(
                        margin: EdgeInsets.only(
                          top: Dimentions.height20,
                          left: Dimentions.width20,
                          right: Dimentions.width20,
                        ),
                        child: MediaQuery.removePadding(
                          removeTop: true,
                          context: context,
                          child: ListView(
                            children: [
                              for (int i = 0;
                                  i < itemsPerOrder.length;
                                  i++) //   ????????
                                Container(
                                  height: Dimentions.height30 * 4,
                                  margin: EdgeInsets.only(
                                      bottom: Dimentions.height20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      //BigText(text: getCartHistoryList[listCounter].time!),
                                     timeWidget(listCounter),
                                      SizedBox(height: Dimentions.height10),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Wrap(
                                              direction: Axis.horizontal,
                                              children: List.generate(
                                                  itemsPerOrder[i], (index) {
                                                if (listCounter <
                                                    getCartHistoryList.length) {
                                                  listCounter++;
                                                }
                                                return index <= 2
                                                    ? Container(
                                                        height: Dimentions
                                                                .height20 *
                                                            4,
                                                        width: Dimentions
                                                                .height20 *
                                                            4,
                                                        margin: EdgeInsets.only(
                                                            right: Dimentions
                                                                    .widtht10 /
                                                                2),
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                    Dimentions
                                                                            .radius15 /
                                                                        2),
                                                            color: Colors.amber
                                                            // image: DecorationImage(
                                                            // fit:BoxFit.cover,
                                                            //     image: NetworkImage(
                                                            //         AppConstants.BASE_URL +
                                                            //             AppConstants
                                                            //                 .BASE_URL +
                                                            //             getCartHistoryList[
                                                            //                     listCounter-1]
                                                            //                 .img!))
                                                            ),
                                                      )
                                                    : Container();
                                              })),
                                          Container(
                                            //color: Colors.red,
                                            height: Dimentions.height20 * 4,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                SmallText(
                                                  text: 'Total',
                                                  color: AppColors.titleColor,
                                                ),
                                                BigText(
                                                  text: itemsPerOrder[i]
                                                          .toString() +
                                                      ' Items',
                                                  color: AppColors.titleColor,
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    var orderTime =
                                                        cartOrderTimeToList();
                                                    // print('Order Time ' +
                                                    //     orderTime[i]
                                                    //         .toString());
                                                    Map<int, CartModel>
                                                        moreOrder = {};
                                                    for (int j = 0;
                                                        j <
                                                            getCartHistoryList
                                                                .length;
                                                        j++) {
                                                      if (getCartHistoryList[j]
                                                              .time ==
                                                          orderTime[i]) {
                                                        // print('My order time is ' +
                                                        //     orderTime[i]);
                                                        // print(
                                                        //     'The cart or order id is ' +
                                                        //         getCartHistoryList[j]
                                                        //             .product!
                                                        //             .id
                                                        //             .toString());
                                                        // print('Prodect info if ' +
                                                        //     jsonEncode(
                                                        //         getCartHistoryList[
                                                        //             j]));
                                                        moreOrder.putIfAbsent(
                                                            getCartHistoryList[j]
                                                                .id!,
                                                            () => CartModel.fromJson(
                                                                jsonDecode(jsonEncode(
                                                                    getCartHistoryList[
                                                                        j]))));
                                                      }
                                                    }
                                                    Get.find<CartController>()
                                                        .setItems = moreOrder;
                                                    Get.find<CartController>()
                                                        .addToCartList();
                                                    Get.toNamed(RouteHelper
                                                        .getCartPage());
                                                  },
                                                  child: Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal:
                                                                Dimentions
                                                                    .widtht10,
                                                            vertical: Dimentions
                                                                    .height10 /
                                                                2),
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius
                                                          .circular(Dimentions
                                                                  .radius15 /
                                                              3),
                                                      border: Border.all(
                                                          width: 1,
                                                          color: AppColors
                                                              .mainColor),
                                                    ),
                                                    child: SmallText(
                                                      text: 'one more',
                                                      color:
                                                          AppColors.mainColor,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                )
                            ],
                          ),
                        )))
                : SizedBox(
                  height: MediaQuery.of(context).size.height/1.5,
                  child: Center(child: NoDataPage(text: "You didn't buy anything so far!", imgPath: "assets/image/food.jpg",)));
          })
        ],
      ),
    );
  }
}
