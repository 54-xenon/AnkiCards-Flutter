import 'package:ankicards/repository/isar_setup.dart';
import 'package:ankicards/screens/home_page.dart';
import 'package:ankicards/screens/list_page.dart';
import 'package:ankicards/screens/setting_page.dart';
import 'package:flutter/material.dart';



// Hive(DBの初期化)
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  // データベースの初期化
  await initializeIsar();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AnkiCards',
      home: BottomNavigation(),
      debugShowCheckedModeBanner: true,
      theme: ThemeData(
        // テーマのカラーを指定する
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.lightBlue[100],
          elevation: 0,
        ),
        // 背景色の指定
        scaffoldBackgroundColor: Colors.white,
        // floating ActionButton color
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.lightBlue[100],
        )
        // テーマの切り替え(Light/Dark)
      ),
    );
  }
}

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  static const _screens = [
    HomePage(),
    ListPage(),
    SettingPage(),
  ];

  int _selectIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectIndex],
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.white,
        onDestinationSelected: (int index) {
          setState(() {
            _selectIndex = index;
          });
        },
        indicatorColor: Colors.lightBlue[100],
        selectedIndex: _selectIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'ホーム',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.list),
            icon: Icon(Icons.list_outlined),
            label: 'リスト',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.settings),
            icon: Icon(Icons.settings_outlined),
            label: '設定',
          ),
        ],
      ),
    );
  }
}