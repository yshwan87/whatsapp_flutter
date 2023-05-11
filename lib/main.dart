import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_flutter/common/utils/colors.dart';
import 'package:whatsapp_flutter/features/landings/screens/landing_screen.dart';
import 'package:whatsapp_flutter/firebase_options.dart';
import 'package:whatsapp_flutter/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Whatsapp UI',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: backgroundColor,
          appBarTheme: const AppBarTheme(
            color: appBarColor,
          ),
        ),
        onGenerateRoute: (settings) => generateRoute(settings),
        home: const LandingScreen());
  }
}
