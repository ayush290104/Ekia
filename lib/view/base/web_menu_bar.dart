import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixam_mart/controller/auth_controller.dart';
import 'package:sixam_mart/controller/cart_controller.dart';
import 'package:sixam_mart/controller/location_controller.dart';
import 'package:sixam_mart/controller/search_controller.dart';
import 'package:sixam_mart/controller/splash_controller.dart';
import 'package:sixam_mart/helper/route_helper.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/images.dart';
import 'package:sixam_mart/util/styles.dart';
import 'package:sixam_mart/view/base/custom_snackbar.dart';
import 'package:sixam_mart/view/base/text_hover.dart';
import 'package:sixam_mart/view/screens/search/widget/search_field.dart';

class WebMenuBar extends StatefulWidget implements PreferredSizeWidget {
  @override
  State<WebMenuBar> createState() => _WebMenuBarState();

  @override
  Size get preferredSize => Size(Dimensions.WEB_MAX_WIDTH, 70);
}

class _WebMenuBarState extends State<WebMenuBar> {
  final TextEditingController _searchController = TextEditingController();
  // String _selectedType = 'Business with Eki';

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Dimensions.WEB_MAX_WIDTH,
      color: Theme.of(context).cardColor,
      padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
      child: Center(
          child: SizedBox(
              width: Dimensions.WEB_MAX_WIDTH,
              child: Row(children: [
                InkWell(
                  onTap: () => Get.toNamed(RouteHelper.getInitialRoute()),
                  child: Image.asset(Images.logo, width: 100),
                ),

                // Get.find<LocationController>().getUserAddress() != null ?

                Expanded(
                    child: InkWell(
                  onTap: () => Get.toNamed(RouteHelper.getPickMapRoute(
                    RouteHelper.accessLocation,
                    false,
                  )),
                  // Get.toNamed(RouteHelper.getAccessLocationRoute('home')),
                  child: Padding(
                    padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                    child: GetBuilder<LocationController>(
                        builder: (locationController) {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            locationController.getUserAddress() == null
                                ? Icons.location_on
                                : locationController
                                            .getUserAddress()
                                            .addressType ==
                                        'home'
                                    ? Icons.home_filled
                                    : locationController
                                                .getUserAddress()
                                                .addressType ==
                                            'office'
                                        ? Icons.work
                                        : Icons.location_on,
                            size: 20,
                            color: Theme.of(context).textTheme.bodyLarge.color,
                          ),
                          SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                          Flexible(
                            child: Text(
                              locationController.getUserAddress() == null
                                  ? "Set Location"
                                  : locationController.getUserAddress().address,
                              style: robotoRegular.copyWith(
                                color:
                                    Theme.of(context).textTheme.bodyLarge.color,
                                fontSize: Dimensions.fontSizeSmall,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Icon(Icons.keyboard_arrow_down,
                              color: Theme.of(context).primaryColor),
                        ],
                      );
                    }),
                  ),
                )),
                // : Expanded(child: SizedBox()),
                // SizedBox(width: 20),

                TextButton(
                  onPressed: () {
                    Get.toNamed(RouteHelper.getRestaurantRegistrationRoute());
                  },
                  child: Row(
                    children: [
                      Image.asset(
                        Images.restaurant_join,
                        color: Colors.green,
                        height: 20,
                        width: 20,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(Get.find<SplashController>()
                              .configModel
                              .moduleConfig
                              .module
                              .showRestaurantText
                          ? 'join_as_a_restaurant'.tr
                          : 'join_as_a_store'.tr),
                    ],
                  ),
                ),
                SizedBox(width: 20),
                TextButton(
                  onPressed: () {
                    Get.toNamed(RouteHelper.getDeliverymanRegistrationRoute());
                  },
                  child: Row(
                    children: [
                      Image.asset(
                        Images.delivery_man_join,
                        color: Colors.green,
                        height: 20,
                        width: 20,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text('Join as a Dispatch Person'.tr),
                    ],
                  ),
                ),
                SizedBox(width: 20),

                // Container(
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.all(Radius.circular(8.0)),
                //   ),
                //   child: DropdownButton(
                //     // underline: const SizedBox(),
                //     icon: Icon(
                //       Icons.keyboard_arrow_down_outlined,
                //       color: Colors.green,
                //     ),
                //     value: _selectedType,
                //     onChanged: (value) {
                //       setState(() {
                //         _selectedType = value.toString();
                //       });
                //     },
                //     isExpanded: false,
                //     items: [
                //       DropdownMenuItem(
                //         value: "Business with Eki",
                //         onTap: () {
                //           // Add your action here
                //           Get.offNamed(RouteHelper.getProfileRoute());
                //         },
                //         child: Row(
                //           children: [
                //             Text(
                //               "Business with Eki",
                //               style: const TextStyle(
                //                 color: Colors.green,
                //                 fontSize: 15,
                //               ),
                //             ),
                //           ],
                //         ),
                //       ),
                //       DropdownMenuItem(
                //         value: 'profile'.tr,
                //         onTap: () {
                //           Get.offNamed(RouteHelper.getProfileRoute());
                //         },
                //         child: Row(
                //           children: [
                //             Image.asset(
                //               Images.profile,
                //               color: Colors.green,
                //               width: 20,
                //               height: 20,
                //             ),
                //             SizedBox(
                //               width: 8,
                //             ),
                //             Text(
                //               'profile'.tr,
                //               style: const TextStyle(
                //                 color: Colors.green,
                //                 fontSize: 15,
                //               ),
                //             ),
                //           ],
                //         ),
                //       ),
                //       DropdownMenuItem(
                //         value: 'my_orders'.tr,
                //         onTap: () {
                //           Get.offNamed(RouteHelper.getOrderRoute());
                //         },
                //         child: Row(
                //           children: [
                //             Image.asset(
                //               Images.orders,
                //               color: Colors.green,
                //               width: 20,
                //               height: 20,
                //             ),
                //             SizedBox(
                //               width: 8,
                //             ),
                //             Text(
                //               'my_orders'.tr,
                //               style: const TextStyle(
                //                 color: Colors.green,
                //                 fontSize: 15,
                //               ),
                //             ),
                //           ],
                //         ),
                //       ),
                //       DropdownMenuItem(
                //         value: 'my_address'.tr,
                //         onTap: () {
                //           Get.offNamed(RouteHelper.getAddressRoute());
                //         },
                //         child: Row(
                //           children: [
                //             Image.asset(
                //               Images.location,
                //               color: Colors.green,
                //               width: 20,
                //               height: 20,
                //             ),
                //             SizedBox(
                //               width: 8,
                //             ),
                //             Text(
                //               'my_address'.tr,
                //               style: const TextStyle(
                //                 color: Colors.green,
                //                 fontSize: 15,
                //               ),
                //             ),
                //           ],
                //         ),
                //       ),
                //       DropdownMenuItem(
                //         value: 'language'.tr,
                //         onTap: () {
                //           Get.offNamed(RouteHelper.getLanguageRoute('menu'));
                //         },
                //         child: Row(
                //           children: [
                //             Image.asset(
                //               Images.language,
                //               color: Colors.green,
                //               width: 20,
                //               height: 20,
                //             ),
                //             SizedBox(
                //               width: 8,
                //             ),
                //             Text(
                //               'language'.tr,
                //               style: const TextStyle(
                //                 color: Colors.green,
                //                 fontSize: 15,
                //               ),
                //             ),
                //           ],
                //         ),
                //       ),
                //       DropdownMenuItem(
                //         value: 'coupon'.tr,
                //         onTap: () {
                //           Get.offNamed(RouteHelper.getCouponRoute());
                //         },
                //         child: Row(
                //           children: [
                //             Image.asset(
                //               Images.coupon,
                //               color: Colors.green,
                //               width: 20,
                //               height: 20,
                //             ),
                //             SizedBox(
                //               width: 8,
                //             ),
                //             Text(
                //               'coupon'.tr,
                //               style: const TextStyle(
                //                 color: Colors.green,
                //                 fontSize: 15,
                //               ),
                //             ),
                //           ],
                //         ),
                //       ),
                //       DropdownMenuItem(
                //         value: 'help_support'.tr,
                //         onTap: () {
                //           Get.offNamed(RouteHelper.getSupportRoute());
                //         },
                //         child: Row(
                //           children: [
                //             Image.asset(
                //               Images.support,
                //               color: Colors.green,
                //               width: 20,
                //               height: 20,
                //             ),
                //             SizedBox(
                //               width: 8,
                //             ),
                //             Text(
                //               'help_support'.tr,
                //               style: const TextStyle(
                //                 color: Colors.green,
                //                 fontSize: 15,
                //               ),
                //             ),
                //           ],
                //         ),
                //       ),
                //       DropdownMenuItem(
                //         value: 'live_chat'.tr,
                //         onTap: () {
                //           Get.offNamed(RouteHelper.getConversationRoute());
                //         },
                //         child: Row(
                //           children: [
                //             Image.asset(
                //               Images.chat,
                //               color: Colors.green,
                //               width: 20,
                //               height: 20,
                //             ),
                //             SizedBox(
                //               width: 8,
                //             ),
                //             Text(
                //               'live_chat'.tr,
                //               style: const TextStyle(
                //                 color: Colors.green,
                //                 fontSize: 15,
                //               ),
                //             ),
                //           ],
                //         ),
                //       ),
                //       if (Get.find<SplashController>()
                //               .configModel
                //               .refundPolicyStatus ==
                //           1)
                //         DropdownMenuItem(
                //           value: 'refund_policy'.tr,
                //           onTap: () {
                //             Get.offNamed(
                //                 RouteHelper.getHtmlRoute('refund-policy'));
                //           },
                //           child: Row(
                //             children: [
                //               Image.asset(
                //                 Images.chat,
                //                 color: Colors.green,
                //                 width: 20,
                //                 height: 20,
                //               ),
                //               SizedBox(
                //                 width: 8,
                //               ),
                //               Text(
                //                 'refund_policy'.tr,
                //                 style: const TextStyle(
                //                   color: Colors.green,
                //                   fontSize: 15,
                //                 ),
                //               ),
                //             ],
                //           ),
                //         ),
                //       if (Get.find<SplashController>()
                //               .configModel
                //               .cancellationPolicyStatus ==
                //           1)
                //         DropdownMenuItem(
                //           value: 'cancellation_policy'.tr,
                //           onTap: () {
                //             Get.offNamed(RouteHelper.getHtmlRoute(
                //                 'cancellation-policy'));
                //           },
                //           child: Row(
                //             children: [
                //               Image.asset(
                //                 Images.chat,
                //                 color: Colors.green,
                //                 width: 20,
                //                 height: 20,
                //               ),
                //               SizedBox(
                //                 width: 8,
                //               ),
                //               Text(
                //                 'cancellation_policy'.tr,
                //                 style: const TextStyle(
                //                   color: Colors.green,
                //                   fontSize: 15,
                //                 ),
                //               ),
                //             ],
                //           ),
                //         ),
                //       if (Get.find<SplashController>()
                //               .configModel
                //               .shippingPolicyStatus ==
                //           1)
                //         DropdownMenuItem(
                //           value: 'shipping_policy'.tr,
                //           onTap: () {
                //             Get.offNamed(
                //                 RouteHelper.getHtmlRoute('shipping-policy'));
                //           },
                //           child: Row(
                //             children: [
                //               Image.asset(
                //                 Images.chat,
                //                 color: Colors.green,
                //                 width: 20,
                //                 height: 20,
                //               ),
                //               SizedBox(
                //                 width: 8,
                //               ),
                //               Text(
                //                 'shipping_policy'.tr,
                //                 style: const TextStyle(
                //                   color: Colors.green,
                //                   fontSize: 15,
                //                 ),
                //               ),
                //             ],
                //           ),
                //         ),
                //       if (Get.find<SplashController>()
                //               .configModel
                //               .customerWalletStatus ==
                //           1)
                //         DropdownMenuItem(
                //           value: 'wallet'.tr,
                //           onTap: () {
                //             Get.offNamed(RouteHelper.getWalletRoute(true));
                //           },
                //           child: Row(
                //             children: [
                //               Image.asset(
                //                 Images.wallet,
                //                 color: Colors.green,
                //                 width: 20,
                //                 height: 20,
                //               ),
                //               SizedBox(
                //                 width: 8,
                //               ),
                //               Text(
                //                 'wallet'.tr,
                //                 style: const TextStyle(
                //                   color: Colors.green,
                //                   fontSize: 15,
                //                 ),
                //               ),
                //             ],
                //           ),
                //         ),
                //       if (Get.find<SplashController>()
                //               .configModel
                //               .loyaltyPointStatus ==
                //           1)
                //         DropdownMenuItem(
                //           value: 'loyalty_points'.tr,
                //           onTap: () {
                //             Get.offNamed(RouteHelper.getWalletRoute(false));
                //           },
                //           child: Row(
                //             children: [
                //               Image.asset(
                //                 Images.loyal,
                //                 color: Colors.green,
                //                 width: 20,
                //                 height: 20,
                //               ),
                //               SizedBox(
                //                 width: 8,
                //               ),
                //               Text(
                //                 'loyalty_points'.tr,
                //                 style: const TextStyle(
                //                   color: Colors.green,
                //                   fontSize: 15,
                //                 ),
                //               ),
                //             ],
                //           ),
                //         ),
                //       if (Get.find<SplashController>()
                //               .configModel
                //               .refEarningStatus ==
                //           1)
                //         DropdownMenuItem(
                //           value: 'refer_and_earn'.tr,
                //           onTap: () {
                //             Get.offNamed(RouteHelper.getReferAndEarnRoute());
                //           },
                //           child: Row(
                //             children: [
                //               Image.asset(
                //                 Images.refer_code,
                //                 color: Colors.green,
                //                 width: 20,
                //                 height: 20,
                //               ),
                //               SizedBox(
                //                 width: 8,
                //               ),
                //               Text(
                //                 'refer_and_earn'.tr,
                //                 style: const TextStyle(
                //                   color: Colors.green,
                //                   fontSize: 15,
                //                 ),
                //               ),
                //             ],
                //           ),
                //         ),
                //       if (Get.find<SplashController>()
                //           .configModel
                //           .toggleDmRegistration)
                //         DropdownMenuItem(
                //           value: 'join_as_a_delivery_man'.tr,
                //           onTap: () {
                //             Get.toNamed(
                //                 RouteHelper.getDeliverymanRegistrationRoute());
                //           },
                //           child: Row(
                //             children: [
                //               Image.asset(
                //                 Images.delivery_man_join,
                //                 color: Colors.green,
                //                 width: 20,
                //                 height: 20,
                //               ),
                //               SizedBox(
                //                 width: 8,
                //               ),
                //               Text(
                //                 'join_as_a_delivery_man'.tr,
                //                 style: const TextStyle(
                //                   color: Colors.green,
                //                   fontSize: 15,
                //                 ),
                //               ),
                //             ],
                //           ),
                //         ),
                //       if (Get.find<SplashController>()
                //           .configModel
                //           .toggleStoreRegistration)
                //         DropdownMenuItem(
                //           value: Get.find<SplashController>()
                //                   .configModel
                //                   .moduleConfig
                //                   .module
                //                   .showRestaurantText
                //               ? 'join_as_a_restaurant'.tr
                //               : 'join_as_a_store'.tr,
                //           onTap: () {
                //             Get.toNamed(
                //                 RouteHelper.getRestaurantRegistrationRoute());
                //           },
                //           child: Row(
                //             children: [
                //               Image.asset(
                //                 Images.restaurant_join,
                //                 color: Colors.green,
                //                 width: 20,
                //                 height: 20,
                //               ),
                //               SizedBox(
                //                 width: 8,
                //               ),
                //               Text(
                //                 Get.find<SplashController>()
                //                         .configModel
                //                         .moduleConfig
                //                         .module
                //                         .showRestaurantText
                //                     ? 'join_as_a_restaurant'.tr
                //                     : 'join_as_a_store'.tr,
                //                 style: const TextStyle(
                //                   color: Colors.green,
                //                   fontSize: 15,
                //                 ),
                //               ),
                //             ],
                //           ),
                //         ),
                //       DropdownMenuItem(
                //         value: Get.find<AuthController>().isLoggedIn()
                //             ? 'logout'.tr
                //             : 'sign_in'.tr,
                //         onTap: () {
                //           // Get.back();
                //           if (Get.find<AuthController>().isLoggedIn()) {
                //             Get.dialog(
                //                 ConfirmationDialog(
                //                     icon: Images.support,
                //                     description: 'are_you_sure_to_logout'.tr,
                //                     isLogOut: true,
                //                     onYesPressed: () {
                //                       Get.find<AuthController>()
                //                           .clearSharedData();
                //                       Get.find<CartController>()
                //                           .clearCartList();
                //                       Get.find<AuthController>().socialLogout();
                //                       Get.find<WishListController>()
                //                           .removeWishes();
                //                       Get.offAllNamed(
                //                           RouteHelper.getSignInRoute(
                //                               RouteHelper.splash));
                //                     }),
                //                 useSafeArea: false);
                //           } else {
                //             Get.find<WishListController>().removeWishes();
                //             Get.toNamed(
                //                 RouteHelper.getSignInRoute(RouteHelper.main));
                //           }
                //         },
                //         child: Row(
                //           children: [
                //             Image.asset(
                //               Images.log_out,
                //               color: Colors.green,
                //               width: 20,
                //               height: 20,
                //             ),
                //             SizedBox(
                //               width: 8,
                //             ),
                //             Text(
                //               Get.find<AuthController>().isLoggedIn()
                //                   ? 'logout'.tr
                //                   : 'sign_in'.tr,
                //               style: const TextStyle(
                //                 color: Colors.green,
                //                 fontSize: 15,
                //               ),
                //             ),
                //           ],
                //         ),
                //       ),
                //     ],
                //     // .map((pf) {
                //     //   return DropdownMenuItem(
                //     //     value: pf,
                //     //     child: Row(
                //     //       children: [
                //     //         const Icon(
                //     //           Icons.keyboard_arrow_down_outlined,
                //     //           color: Colors.green,
                //     //         ),
                //     //         const SizedBox(width: 4),
                //     //         Text(
                //     //           pf,
                //     //           style: const TextStyle(
                //     //             color: Colors.green,
                //     //             fontSize: 15,
                //     //           ),
                //     //         ),
                //     //       ],
                //     //     ),
                //     //   );
                //     // }).toList(),
                //   ),
                // ),
                // SizedBox(width: 20),
                // // Get.find<LocationController>().getUserAddress() == null ? Row(children: [
                // //   MenuButton(title: 'home'.tr, onTap: () => Get.toNamed(RouteHelper.getInitialRoute())),
                // //   SizedBox(width: 20),
                // //   MenuButton(title: 'about_us'.tr, onTap: () => Get.toNamed(RouteHelper.getHtmlRoute('about-us'))),
                // //   SizedBox(width: 20),
                // //   MenuButton(title: 'privacy_policy'.tr, onTap: () => Get.toNamed(RouteHelper.getHtmlRoute('privacy-policy'))),
                // // ]) :
                SizedBox(
                    width: 140,
                    child: GetBuilder<SearchController>(
                        builder: (searchController) {
                      _searchController.text = searchController.searchHomeText;
                      return SearchField(
                        controller: _searchController,
                        hint: Get.find<SplashController>()
                                .configModel
                                .moduleConfig
                                .module
                                .showRestaurantText
                            ? 'search_food_or_restaurant'.tr
                            : 'search_item_or_store'.tr,
                        suffixIcon: searchController.searchHomeText.length > 0
                            ? Icons.highlight_remove
                            : Icons.search,
                        filledColor: Theme.of(context).colorScheme.background,
                        iconPressed: () {
                          if (searchController.searchHomeText.length > 0) {
                            _searchController.text = '';
                            searchController.clearSearchHomeText();
                          } else {
                            searchData();
                          }
                        },
                        onSubmit: (text) => searchData(),
                      );
                    })),
                SizedBox(width: 20),

                MenuIconButton(
                    icon: Icons.notifications,
                    onTap: () =>
                        Get.toNamed(RouteHelper.getNotificationRoute())),
                SizedBox(width: 20),
                MenuIconButton(
                    icon: Icons.favorite,
                    onTap: () =>
                        Get.toNamed(RouteHelper.getMainRoute('favourite'))),
                SizedBox(width: 20),
                MenuIconButton(
                    icon: Icons.shopping_cart,
                    isCart: true,
                    onTap: () => Get.toNamed(RouteHelper.getCartRoute())),
                // SizedBox(width: 20),
                // GetBuilder<LocalizationController>(
                //     builder: (localizationController) {
                //   int _index = 0;
                //   List<DropdownMenuItem<int>> _languageList = [];
                //   for (int index = 0;
                //       index < AppConstants.languages.length;
                //       index++) {
                //     _languageList.add(DropdownMenuItem(
                //       child: TextHover(builder: (hovered) {
                //         return Row(children: [
                //           Image.asset(AppConstants.languages[index].imageUrl,
                //               height: 20, width: 20),
                //           SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                //           Text(AppConstants.languages[index].languageName,
                //               style: robotoRegular.copyWith(
                //                   color: hovered
                //                       ? Theme.of(context).primaryColor
                //                       : null)),
                //         ]);
                //       }),
                //       value: index,
                //     ));
                //     if (AppConstants.languages[index].languageCode ==
                //         localizationController.locale.languageCode) {
                //       _index = index;
                //     }
                //   }
                //   return DropdownButton<int>(
                //     value: _index,
                //     items: _languageList,
                //     dropdownColor: Theme.of(context).cardColor,
                //     icon: Icon(Icons.keyboard_arrow_down),
                //     elevation: 0,
                //     iconSize: 30,
                //     underline: SizedBox(),
                //     onChanged: (int index) {
                //       localizationController.setLanguage(Locale(
                //           AppConstants.languages[index].languageCode,
                //           AppConstants.languages[index].countryCode));
                //     },
                //   );
                // }),
                SizedBox(width: 20),
                MenuIconButton(
                    icon: Icons.menu,
                    onTap: () {
                      Scaffold.of(context).openEndDrawer();
                    }),
                SizedBox(width: 20),
                GetBuilder<AuthController>(builder: (authController) {
                  return InkWell(
                    onTap: () {
                      Get.toNamed(authController.isLoggedIn()
                          ? RouteHelper.getProfileRoute()
                          : RouteHelper.getSignInRoute(RouteHelper.main));
                    },
                    child: Container(
                      height: 40,
                      padding: EdgeInsets.symmetric(
                          horizontal: Dimensions.PADDING_SIZE_LARGE),
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Dimensions.RADIUS_SMALL),
                        color: Theme.of(context).primaryColor,
                      ),
                      child: Row(children: [
                        Icon(
                            authController.isLoggedIn()
                                ? Icons.person_pin_rounded
                                : Icons.lock,
                            size: 20,
                            color: Colors.white),
                        SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
                        Text(
                            authController.isLoggedIn()
                                ? 'profile'.tr
                                : 'sign_in'.tr,
                            style: robotoRegular.copyWith(
                                fontSize: Dimensions.fontSizeLarge,
                                color: Colors.white)),
                      ]),
                    ),
                  );
                }),
              ]))),
    );
  }

  void searchData() {
    if (_searchController.text.trim().isEmpty) {
      showCustomSnackBar(Get.find<SplashController>()
              .configModel
              .moduleConfig
              .module
              .showRestaurantText
          ? 'search_food_or_restaurant'.tr
          : 'search_item_or_store'.tr);
    } else {
      Get.toNamed(
          RouteHelper.getSearchRoute(queryText: _searchController.text.trim()));
    }
  }
}

class MenuButton extends StatelessWidget {
  final String title;
  final Function onTap;
  MenuButton({@required this.title, @required this.onTap});

  @override
  Widget build(BuildContext context) {
    return TextHover(builder: (hovered) {
      return InkWell(
        onTap: onTap,
        child: Text(title,
            style: robotoRegular.copyWith(
                color: hovered ? Theme.of(context).primaryColor : null)),
      );
    });
  }
}

class MenuIconButton extends StatelessWidget {
  final IconData icon;
  final bool isCart;
  final Function onTap;
  const MenuIconButton(
      {@required this.icon, this.isCart = false, @required this.onTap});

  @override
  Widget build(BuildContext context) {
    return TextHover(builder: (hovered) {
      return IconButton(
        onPressed: onTap,
        icon: GetBuilder<CartController>(builder: (cartController) {
          return Stack(clipBehavior: Clip.none, children: [
            Icon(
              icon,
              color: hovered
                  ? Theme.of(context).primaryColor
                  : Theme.of(context).textTheme.bodyLarge.color,
            ),
            (isCart && cartController.cartList.length > 0)
                ? Positioned(
                    top: -5,
                    right: -5,
                    child: Container(
                      height: 15,
                      width: 15,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context).primaryColor),
                      child: Text(
                        cartController.cartList.length.toString(),
                        style: robotoRegular.copyWith(
                            fontSize: 12, color: Theme.of(context).cardColor),
                      ),
                    ),
                  )
                : SizedBox()
          ]);
        }),
      );
    });
  }
}
