import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int myIndex = 0;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final widthScreen = mediaQuery.size.width;

    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      body: Center(
        child: Text("Привет")
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Color(0xFFC9C9C9),
              offset: Offset(0, -4),
              blurRadius: 4
            ),
          ],
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          currentIndex: myIndex,
          selectedItemColor: Color(0xFFFF5900),
          selectedFontSize: widthScreen * 0.03,
          unselectedFontSize: widthScreen * 0.03,
          unselectedItemColor: Colors.black,
          selectedLabelStyle: TextStyle(
            fontFamily: "Montserrat",
            fontWeight: FontWeight.w700,
          ),
          unselectedLabelStyle: TextStyle(
            fontFamily: "Montserrat",
            fontWeight: FontWeight.w500,
          ),
          onTap: (index) {
            setState(() {
              myIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined, color: Colors.black),
              activeIcon: Icon(Icons.home),
              label: "Главная",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.grid_view_outlined, color: Colors.black),
              activeIcon: Icon(Icons.grid_view),
              label: "Каталог",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart_outlined, color: Colors.black),
              activeIcon: Icon(Icons.shopping_cart),
              label: "Корзина",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outlined, color: Colors.black),
              activeIcon: Icon(Icons.person),
              label: "Профиль",
            ),
          ],
        ),
      ),
    );
  }
}
