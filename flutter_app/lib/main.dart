import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'chat_screen.dart';
import 'webview_screen.dart';

void main() {
  runApp(const TurboVetsApp());
}

class TurboVetsApp extends StatelessWidget {
  const TurboVetsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TurboVets Messaging App',
      theme: ThemeData(
        // Light / Default Theme
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 1,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.blue,
          unselectedLabelStyle: TextStyle(fontSize: 12),
        ),
        cardTheme: CardTheme(
          color: const Color.fromRGBO(217, 217, 217, 1),
          elevation: 1,
        ),
        textTheme: const TextTheme(bodyLarge: TextStyle(color: Colors.black87)),
      ),

      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.grey[900],
        appBarTheme: AppBarTheme(
          backgroundColor: const Color.fromRGBO(33, 33, 33, 1),
          foregroundColor: Colors.white,
          elevation: 1,
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.grey[900],
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.blue,
        ),
        cardTheme: CardTheme(color: Colors.grey[800], elevation: 1),
        textTheme: const TextTheme(bodyLarge: TextStyle(color: Colors.white70)),
      ),

      themeMode: ThemeMode.system, // Use system theme mode
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [const ChatScreen(), const WebviewScreen()];

  // Handle tab changes
  void _onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onTabTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.chat_bubble_2,
              color: Colors.blue,
              size: 28,
            ),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.settings, color: Colors.blue, size: 28),
            label: 'Dashboard',
          ),
        ],
      ),
    );
  }
}
