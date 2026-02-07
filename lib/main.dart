// import 'package:ankur_portfolio/screens/splash.screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdfrx/pdfrx.dart';
// import 'package:device_preview/device_preview.dart';
import 'package:ankur_portfolio/routing/app_router.dart';

Future<void> main() async {
  if (kIsWeb) {
    WidgetsFlutterBinding.ensureInitialized();
    pdfrxFlutterInitialize();
    SystemChannels.keyEvent.setMethodCallHandler((call) async {
      return null;
    });
  }

  runApp(MyApp());
  
  // runApp(DevicePreview(
  //   enabled: !kReleaseMode,
  //   builder: (context) => MyApp(), // Wrap your app
  // ),);
}



extension on BasicMessageChannel<Object?> {
  void setMethodCallHandler(Future<Null> Function(dynamic call) param0) {}
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: "Ankur ",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      routerConfig: router,
    );
  }
}

