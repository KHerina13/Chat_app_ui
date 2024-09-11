import 'package:chat/View/Screen/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Chat',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: false,
          brightness: Brightness.light,
          scaffoldBackgroundColor: Colors.white,
          primaryColor: const Color(0xFF075E54),
          colorScheme: const ColorScheme.light(
            primary: Color(0xFF075E54), // AppBar and highlights
            secondary: Color(0xFF25D366), // Floating Action Button color, etc.
            background: Colors.white,
          ),
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFF075E54),
            titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.white),
          ),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: Color(0xFF25D366), // WhatsApp-like color
          ),
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          scaffoldBackgroundColor: const Color(0xFF121212),
          colorScheme: const ColorScheme.dark(
            primary: Color(0xFF128C7E),
            secondary: Color(0xFF25D366),
            background: Color(0xFF1F1F1F),
          ),
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFF128C7E),
            titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
            elevation: 0,
          ),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor:
                Color(0xFF25D366), // WhatsApp-like color for dark theme
          ),
        ),
        themeMode: ThemeMode.system,
        home: HomeScreen());
  }
}
