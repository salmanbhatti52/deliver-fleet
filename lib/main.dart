import 'dart:io';
import 'package:get_it/get_it.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:deliver_partner/CustomSplash.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:deliver_partner/services/API_services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  HttpOverrides.global = MyHttpOverrides();
  await Firebase.initializeApp();
  runApp(const MyApp());
  // runApp(
  //   DevicePreview(
  //     enabled: true,
  //     builder: (context) => const MyApp(),
  //   ),
  // );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    if (!GetIt.I.isRegistered<ApiServices>()) {
      GetIt.I.registerLazySingleton(() => ApiServices());
    }
    super.initState();
  }

  bool get isIos =>
      foundation.defaultTargetPlatform == foundation.TargetPlatform.iOS;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      builder: (context, child) {
        SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
          statusBarColor:
              Colors.transparent, // Set your preferred status bar color
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarColor:
              Colors.white, // Set your preferred system navigation bar color
          systemNavigationBarDividerColor: Colors
              .grey, // Set your preferred system navigation bar divider color
          systemNavigationBarIconBrightness: Brightness.dark,
        ));

        return MaterialApp(
          theme: ThemeData(
            useMaterial3: false,
          ),
          debugShowCheckedModeBanner: false,
          title: 'Deliver Rider',
          home: const CustomSplash(),
        );
      },
    );
  }
}
