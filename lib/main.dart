import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:get_storage/get_storage.dart';
import 'package:timezone/data/latest_all.dart';
import 'package:timezone/timezone.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import 'package:tugsuyoo/app/data/services/storage/services.dart';
import 'package:tugsuyoo/app/screens/home/binding.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tugsuyoo/features/ondboarding/screens/onboarding_screen.dart';
import 'package:tugsuyoo/login/login.dart';
import 'package:tugsuyoo/water/bloc/water_bloc.dart';
import 'package:tugsuyoo/water/domain/repository/water_repository.dart';
import 'package:tugsuyoo/water/ui/home/home_page.dart';
import 'package:tugsuyoo/water/ui/theme/app_theme.dart';
import 'firebase_options.dart';
// import 'package:tugsuyoo/features/ondboarding/screens/onboarding_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  
  
Platform.isAndroid?

  await Firebase.initializeApp(
  options: const FirebaseOptions(
    apiKey: 'AIzaSyDRNFmxQ_ELmV4EYxwNXlTkq5ZZt-QmIvU',
    appId: '1:585728837923:web:ced5f39a889ee2dcba6496',
    messagingSenderId: '585728837923',
    projectId: 'tugsuyoo',
    authDomain: 'tugsuyoo.firebaseapp.com',
    storageBucket: 'tugsuyoo.appspot.com',
    measurementId: 'G-T3T59GC94D',
  ))
  :await Firebase.initializeApp();
  runApp(const MyApp());


 WidgetsFlutterBinding.ensureInitialized();
 await GetStorage.init();
  await Get.putAsync(() => StorageService().init());
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _repository = WaterRepository();
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();


  @override
  void initState() {
    _requestPermissions();
    _setUpLocalNotification();
    _repository.subscribeToDataStore();
    super.initState();
  }

 
  // This widget is the root of your application.
 @override
Widget build(BuildContext context) {
  return MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => WaterBloc(_repository),
        lazy: false,
      ),
    ],
    child: GetMaterialApp(
      title: 'To do app using Getx',
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      // OnboardingScreen()
      home: Scaffold(
        body: AnnotatedRegion(
          value: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            systemNavigationBarColor: Colors.transparent,
            systemNavigationBarIconBrightness: Brightness.dark,
            statusBarIconBrightness: Brightness.dark,
          ),
          child: OnboardingScreen(),
        ),
      ),
      locale: LocalizationService.locale,
      fallbackLocale: LocalizationService.fallbackLocale,
      translations: LocalizationService(),
      initialBinding: HomeBinding(),
      builder: EasyLoading.init(),
    ),
  );
}


  void _requestPermissions() async {
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  void _setUpLocalNotification() async {
    await _configureLocalTimeZone();
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    /// Note: permissions aren't requested here just to demonstrate that can be
    /// done later
    final DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
            requestAlertPermission: true,
            requestBadgePermission: true,
            requestSoundPermission: true,
            onDidReceiveLocalNotification: (
              int id,
              String? title,
              String? body,
              String? payload,
            ) async {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text(title ?? ''),
                  content: Text(body ?? ''),
                ),
              );
            });

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> _configureLocalTimeZone() async {
    if (kIsWeb || Platform.isLinux) {
      return;
    }
    initializeTimeZones();
    final String timeZoneName = await FlutterTimezone.getLocalTimezone();
    setLocalLocation(getLocation(timeZoneName));
  }
}


