import 'package:delivery/pages/auth/sign_in_page.dart';
import 'package:delivery/pages/cart/cart_page.dart';
import 'package:delivery/pages/food/popular_food_detail.dart';
import 'package:delivery/pages/food/recommended_food_detail.dart';
import 'package:delivery/pages/home/home_page.dart';
import 'package:delivery/pages/home/main_food_page.dart';
import 'package:delivery/pages/splash/splash_page.dart';
import 'package:get/get.dart';

class RouteHelper {
  static const String splashPage = '/splash-page';
  static const String initial = "/";
  static const String popularFood = "/popular-food";
  static const String recommendedFood = "/recommended-food";
  static const String cartPage = "/cart-Page";
  static const String signIn = "/sign-in";
//methods
   static String getSplashPage() =>'$splashPage';
  static String getInitial() =>'$initial';                   //functions are created so tht parameters could be pssed
  static String getPopularFood(int pageId, String page) =>'$popularFood?pageId=$pageId&page=$page';
  static String getRecommendedFood(int pageId, String page) =>'$recommendedFood?pageId=$pageId&page=$page';
  static String getCartPage() => '$cartPage';
  static String getSignInPage() => '$signIn';


//get pages
  static List<GetPage> routes = [
     GetPage(name: splashPage, page: () => SplashScreen()),
    GetPage(name: initial, page: () => HomePage()),
    GetPage(name: signIn, page: () => SignInPage(), transition: Transition.fade),
    GetPage(
      name: popularFood,
      page: () {
        var pageId = Get.parameters['pageId'];
        var page = Get.parameters['page'];
        // print('popular food get called');
        return PopularFoodDetail(pageId: int.parse(pageId!), page: page!);
      },
      transition: Transition.fadeIn,
    ),
    GetPage(
        name: recommendedFood,
        page: () {
          var pageId = Get.parameters['pageId'];
          var page = Get.parameters['page'];
          return RecommendedFoodDetail(pageId: int.parse(pageId!), page: page!);
        }),
    GetPage(
        name: cartPage,
        page: () {
          return CartPage();
        },
        transition: Transition.fadeIn)
  ];
}
