import 'package:flutter/material.dart';
import '../screens/login_screen.dart';
import '../screens/bookings_screen.dart';

void main() => runApp(ChaloCholoApp());

class ChaloCholoApp extends StatelessWidget {
  const ChaloCholoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chalo Cholo App',
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(), // Corrected here
        '/bookings': (context) => BookingsScreen(),
      },
    );
  }
}
