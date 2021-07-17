import 'package:Anwar/provider/auth_provider.dart';
import 'package:Anwar/provider/brand_provider.dart';
import 'package:Anwar/provider/cart_provider.dart';
import 'package:Anwar/provider/category_provider.dart';
import 'package:Anwar/provider/chat_provider.dart';
import 'package:Anwar/provider/coupon_provider.dart';
import 'package:Anwar/provider/localization_provider.dart';
import 'package:Anwar/provider/notification_provider.dart';
import 'package:Anwar/provider/onboarding_provider.dart';
import 'package:Anwar/provider/order_provider.dart';
import 'package:Anwar/provider/profile_provider.dart';
import 'package:Anwar/provider/search_provider.dart';
import 'package:Anwar/provider/seller_provider.dart';
import 'package:Anwar/provider/splash_provider.dart';
import 'package:Anwar/provider/support_ticket_provider.dart';
import 'package:Anwar/provider/theme_provider.dart';
import 'package:Anwar/provider/wishlist_provider.dart';
import 'package:Anwar/theme/dark_theme.dart';
import 'package:Anwar/theme/light_theme.dart';
import 'package:Anwar/utill/app_constants.dart';
import 'package:Anwar/view/screen/splash/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'di_container.dart' as di;
import 'localization/app_localization.dart';
import 'notification/my_notification.dart';
import 'provider/banner_provider.dart';
import 'provider/category_provider.dart';
import 'provider/coupon_provider.dart';
import 'provider/flash_deal_provider.dart';
import 'provider/order_provider.dart';
import 'provider/product_details_provider.dart';
import 'provider/product_provider.dart';
import 'provider/wishlist_provider.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await di.init();
  await MyNotification.initialize(flutterLocalNotificationsPlugin);
  FirebaseMessaging.onBackgroundMessage(myBackgroundMessageHandler);

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => di.sl<CategoryProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<FlashDealProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<BrandProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<ProductProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<BannerProvider>()),
      ChangeNotifierProvider(
          create: (context) => di.sl<ProductDetailsProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<OnBoardingProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<AuthProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<SearchProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<SellerProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<CouponProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<ChatProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<OrderProvider>()),
      ChangeNotifierProvider(
          create: (context) => di.sl<NotificationProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<ProfileProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<WishListProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<SplashProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<CartProvider>()),
      ChangeNotifierProvider(
          create: (context) => di.sl<SupportTicketProvider>()),
      ChangeNotifierProvider(
          create: (context) => di.sl<LocalizationProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<ThemeProvider>()),
    ],
    child: MyApp(orderId: 1),
  ));
}

class MyApp extends StatelessWidget {
  final int orderId;
  MyApp({@required this.orderId});

  static final navigatorKey = new GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    List<Locale> _locals = [];
    AppConstants.languages.forEach((language) {
      _locals.add(Locale(language.languageCode, language.countryCode));
    });
    return MaterialApp(
        title: 'ShopyNow',
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        theme: Provider.of<ThemeProvider>(context).darkTheme ? dark : light,
        locale: Provider.of<LocalizationProvider>(context).locale,
        localizationsDelegates: [
          AppLocalization.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: _locals,
        home: SplashScreen());
  }
}
