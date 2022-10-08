import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_beep/flutter_beep.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:provider/provider.dart';
import '/application/cartProvider.dart';
import '/application/locationProvider.dart';
import '/application/productDetailsProvider.dart';
import '/application/userDetails.dart';
import '/presentation/views/homePage.dart';

import 'application/app_state.dart';
import 'application/errorStrings.dart';
import 'application/productList.dart';
import 'application/signUpBusinissLogic.dart';
import 'configurations/frontEndConfigs.dart';
import 'infrastructure/services/authServices.dart';
import 'infrastructure/services/bannerServices.dart';
import 'infrastructure/services/categoryServices.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
  print(message.data);
  flutterLocalNotificationsPlugin.show(
      message.data.hashCode,
      message.data['title'],
      message.data['body'],
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          // channel.description,
        ),
      ));
}

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  // 'This channel is used for important notifications.', // description
  importance: Importance.high,
);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>();
  //     ?.createNotificationChannel(channel);
  runApp(EasyLocalization(
    supportedLocales: [
      Locale('zh', 'CN'),
      Locale('en', 'US'),
    ],
    path: 'assets/translations',
    fallbackLocale: Locale('en', 'US'),
    child: MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => ProductProvider()),
      ChangeNotifierProvider(create: (_) => SignUpBusinessLogic()),
      ChangeNotifierProvider(create: (_) => ErrorString()),
      ChangeNotifierProvider(create: (_) => AppState()),
      ChangeNotifierProvider(create: (_) => CartProvider()),
      ChangeNotifierProvider(create: (_) => LocationProvider()),
      ChangeNotifierProvider(create: (_) => UserDetailsProvider()),
      ChangeNotifierProvider(create: (_) => ProductDetailsProvider()),
      ChangeNotifierProvider(
        create: (_) => AuthServices(),
      ),
      Provider<CategoryServices>(create: (_) =>  CategoryServices()),

        StreamProvider(
      initialData: User,
          create: (context) => context.read<AuthServices>().authState,
        ),
      // StreamProvider(
      //   initialData: [],
      //   create: (context) => context.read<BannerServices>().streamBanners(),
      // ),
      Provider<BannerServices>(create: (_) => BannerServices()),
    ], child: MyApp()),
  ));
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var initialzationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    final DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    var initializationSettings = InitializationSettings(
        android: initialzationSettingsAndroid,
        iOS: initializationSettingsDarwin);

    flutterLocalNotificationsPlugin.initialize(initializationSettings);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification!.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                // channel.description,
                icon: android.smallIcon,
              ),
            ));
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (android != null) {
        FlutterBeep.beep();
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification!.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                icon: android.smallIcon,
              ),
            ));
      }
    });
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      locale: context.locale,
      title: 'Flutter Demo',
      theme: ThemeData(
        appBarTheme: AppBarTheme(color: Colors.white, elevation: 0),
        fontFamily: "Poppins",
        scaffoldBackgroundColor: Colors.white,
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: FrontEndConfigs.appBaseColor,
        ),
        primaryColor: FrontEndConfigs.appBaseColor,
        colorScheme: ColorScheme.light(primary: FrontEndConfigs.appBaseColor)
            .copyWith(secondary: FrontEndConfigs.appBaseColor),
      ),
      home: HomePage(),
    );
  }
}
