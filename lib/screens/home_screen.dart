import 'package:flutter/material.dart';
import 'basket_screen.dart';
import 'catalog_screen.dart';
import 'profile_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int myIndex = 0;

  final List<Map<String, String>> _categories = [
    {'name': 'Бургеры', 'image': 'assets/images/burgers.png'},
    {'name': 'Супы', 'image': 'assets/images/soups.png'},
    {'name': 'Десерты', 'image': 'assets/images/desserts.png'},
    {'name': 'Напитки', 'image': 'assets/images/drinks.png'},
    {'name': 'Пицца', 'image': 'assets/images/pizza.png'},
  ];

  final List<Map<String, dynamic>> _popularDishes = [
    {'name': 'Брауни', 'price': 300, 'image': 'assets/images/brownie.png'},
    {'name': 'Пепперони', 'price': 550, 'image': 'assets/images/pepperoni.png'},
    {'name': 'Цезарь', 'price': 250, 'image': 'assets/images/caesar.png'},
  ];

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    final widthScreen = mediaQuery.size.width;
    final heightScreen = mediaQuery.size.height;

    final List<Widget> screens = [
      GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            vertical: heightScreen * 0.02,
            horizontal: widthScreen * 0.04,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: widthScreen * 0.03),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            color: Colors.black,
                            size: widthScreen * 0.05,
                          ),
                          SizedBox(width: widthScreen * 0.02),
                          Flexible(
                            child: StreamBuilder<DocumentSnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(FirebaseAuth.instance.currentUser!.uid)
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return Text(
                                    "Загрузка...",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: "Montserrat",
                                      fontWeight: FontWeight.w500,
                                      fontSize: widthScreen * 0.04,
                                    ),
                                  );
                                }

                                final userData = snapshot.data!.data() as Map<String, dynamic>;
                                final address = userData['address'];
                                final cityLabel = userData['cityLabel'] ?? '';

                                return Text(
                                  '$cityLabel, $address',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: "Montserrat",
                                    fontSize: widthScreen * 0.04,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(width: widthScreen * 0.07),

                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        StreamBuilder<DocumentSnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('users')
                              .doc(FirebaseAuth.instance.currentUser!.uid)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return Text(
                                "Загрузка...",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: "Montserrat",
                                  fontWeight: FontWeight.w500,
                                  fontSize: widthScreen * 0.04,
                                ),
                              );
                            }

                            final userData = snapshot.data!.data() as Map<String, dynamic>;
                            final name = userData['name'];

                            return Text(
                              '$name',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontFamily: "Montserrat",
                                fontSize: widthScreen * 0.04,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            );
                          },
                        ),
                        SizedBox(width: widthScreen * 0.01),
                        Icon(
                          Icons.account_circle_outlined,
                          color: Colors.black,
                          size: widthScreen * 0.05,
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: heightScreen * 0.025),

              Row(
                children: [
                  Expanded(
                    flex: 85,
                    child: Container(
                      height: heightScreen * 0.05,
                      decoration: BoxDecoration(
                        color: const Color(0xFFECECEC),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: TextField(
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF666666),
                          fontFamily: 'Montserrat',
                          fontSize: widthScreen * 0.045,
                        ),
                        decoration: InputDecoration(
                          hintText: "Поиск блюд...",
                          hintStyle: TextStyle(
                            color: const Color(0xFFC9C9C9),
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.w500,
                            fontSize: widthScreen * 0.045,
                          ),
                          prefixIcon: Icon(
                            Icons.search,
                            color: const Color(0xFFC9C9C9),
                            size: widthScreen * 0.06,
                          ),
                          border: InputBorder.none,
                          filled: true,
                          fillColor: Colors.transparent,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: widthScreen * 0.04,
                            vertical: heightScreen * 0.01,
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(width: widthScreen * 0.03),

                  Expanded(
                    flex: 15,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          myIndex = 2;
                        });
                      },
                      child: Icon(
                        Icons.shopping_cart_outlined,
                        color: Colors.black,
                        size: widthScreen * 0.07,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: heightScreen * 0.035),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Категории',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w700,
                      fontSize: widthScreen * 0.055,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CatalogScreen(),
                        ),
                      );
                    },
                    child: Text(
                      'Все >',
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w500,
                        fontSize: widthScreen * 0.04,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: heightScreen * 0.02),

              SizedBox(
                height: heightScreen * 0.15,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: _categories.length,
                  separatorBuilder: (context, index) =>
                      SizedBox(width: widthScreen * 0.03),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: widthScreen * 0.25,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0xFFF5F5F5),
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(16),
                                  ),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(16),
                                  ),
                                  child: Image.asset(
                                    _categories[index]['image']!,
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(widthScreen * 0.02),
                              child: Text(
                                _categories[index]['name']!,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w700,
                                  fontSize: widthScreen * 0.035,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              SizedBox(height: heightScreen * 0.035),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Популярные блюда',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w700,
                      fontSize: widthScreen * 0.055,
                    ),
                  ),
                ],
              ),

              SizedBox(height: heightScreen * 0.02),

              SizedBox(
                height: heightScreen * 0.28,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: _popularDishes.length,
                  separatorBuilder: (context, index) =>
                      SizedBox(width: widthScreen * 0.03),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: widthScreen * 0.35,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF5F5F5),
                                  borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(16),
                                  ),
                                ),
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(16),
                                  ),
                                  child: Image.asset(
                                    _popularDishes[index]['image']!,
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(widthScreen * 0.03),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _popularDishes[index]['name']!,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.w600,
                                      fontSize: widthScreen * 0.04,
                                    ),
                                  ),
                                  SizedBox(height: heightScreen * 0.005),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '${_popularDishes[index]['price']} р.',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.w700,
                                          fontSize: widthScreen * 0.04,
                                        ),
                                      ),
                                      Container(
                                        width: widthScreen * 0.08,
                                        height: widthScreen * 0.08,
                                        decoration: BoxDecoration(
                                          color: Color(0xFFFF5900),
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                        ),
                                        child: Icon(
                                          Icons.add,
                                          color: Colors.black,
                                          size: widthScreen * 0.05,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      const CatalogScreen(),
      const BasketScreen(),
      const ProfileScreen(),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SizedBox(
          width: double.infinity,
          height: heightScreen,
          child: SafeArea(child: screens[myIndex]),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFC9C9C9),
              offset: const Offset(0, -4),
              blurRadius: 4,
            ),
          ],
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          currentIndex: myIndex,
          selectedItemColor: const Color(0xFFFF5900),
          selectedFontSize: widthScreen * 0.03,
          unselectedFontSize: widthScreen * 0.03,
          unselectedItemColor: Colors.black,
          selectedLabelStyle: const TextStyle(
            fontFamily: "Montserrat",
            fontWeight: FontWeight.w700,
          ),
          unselectedLabelStyle: const TextStyle(
            fontFamily: "Montserrat",
            fontWeight: FontWeight.w500,
          ),
          onTap: (index) {
            setState(() {
              myIndex = index;
            });
          },
          items: const [
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
