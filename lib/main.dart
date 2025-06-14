import 'package:clean_pro/screens/booking_form_screen.dart';
import 'package:clean_pro/screens/main_screen.dart';
import 'package:clean_pro/screens/onboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CleanPro',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
      ),
      debugShowCheckedModeBanner: false,
      onGenerateRoute: (settings) {
        final uri = Uri.parse(settings.name ?? '');

        if (uri.path == '/main') {
          return MaterialPageRoute(builder: (context) => MainScreen());
        }

        if (uri.pathSegments.length == 4 &&
            uri.pathSegments[0] == 'services' &&
            uri.pathSegments[2] == 'booking' &&
            uri.pathSegments[3] == 'create') {
          final serviceId = uri.pathSegments[1];

          return MaterialPageRoute(
            builder: (context) => BookingFormScreen(serviceId: serviceId),
          );
        }

        return MaterialPageRoute(builder: (context) => OnboardScreen());
      },
    );
  }
}
