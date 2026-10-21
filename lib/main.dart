import 'package:flutter/material.dart';
import 'services/phone_service.dart';
import 'views/splash_screen_ui.dart';

void main() => runApp(const ThaiHotlineApp());

class ThaiHotlineApp extends StatelessWidget {
  const ThaiHotlineApp({
    super.key,
    this.phoneService = const PhoneService(),
    this.splashDuration = const Duration(seconds: 2),
  });
  final PhoneService phoneService;
  final Duration splashDuration;
  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'สายด่วน THAILAND',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true,
      fontFamily: 'Kanit',
      scaffoldBackgroundColor: Colors.white,
      colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF24223F)),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFFD9D9D9),
        foregroundColor: Colors.black,
        centerTitle: true,
        elevation: 0,
        titleTextStyle: TextStyle(
          fontFamily: 'Kanit',
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: Color(0xFF24223F),
        unselectedItemColor: Color(0xFF9A9A9A),
        selectedLabelStyle: TextStyle(
          fontFamily: 'Kanit',
          fontSize: 10,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: TextStyle(fontFamily: 'Kanit', fontSize: 10),
      ),
    ),
    builder: (_, child) => ColoredBox(
      color: const Color(0xFFEDEDED),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 440),
          child: child,
        ),
      ),
    ),
    home: SplashScreenUI(phoneService: phoneService, duration: splashDuration),
  );
}
