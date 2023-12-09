import 'package:book_bytes/models/user.dart';
import 'package:book_bytes/screens/booklist.dart';
import 'package:book_bytes/screens/cart.dart';
import 'package:book_bytes/screens/community.dart';
import 'package:book_bytes/screens/settings.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  final User user;

  const MainScreen({super.key, required this.user});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late List<Widget> tabchildren;
  int _currentIndex = 0;
  String maintitle = "Book List";

  @override
  void initState() {
    super.initState();
    print(widget.user.name);
    print("Mainscreen");
    tabchildren = [
      Cart(user: widget.user),
      BookList(user: widget.user),
      Community(user: widget.user),
      Settings(user: widget.user)
    ];
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(maintitle)),
      body: tabchildren[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          onTap: onTabTapped,
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          items: const [
            BottomNavigationBarItem(
          icon: Icon(
            Icons.menu_book,
          ),
          label: "Book List"),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.diversity_3,
            ),
            label: "Community"),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.shopping_cart,
                ),
                label: "Cart"),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.settings,
              ),
              label: "Setttings"),
          ]),
    );
  }

  void onTabTapped(int value) {
    setState(() {
      _currentIndex = value;
      if (_currentIndex == 0) {
        maintitle = "Book List";
      }
      if (_currentIndex == 1) {
        maintitle = "Community";
      }
      if (_currentIndex == 2) {
        maintitle = "Cart";
      } 
      if (_currentIndex == 3) {
        maintitle = "Settings";
      }
   } );
  }
}