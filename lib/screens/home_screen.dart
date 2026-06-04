import 'package:flutter/material.dart';
import 'basket_screen.dart';
import 'catalog_screen.dart';
import 'profile_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dish_screen.dart';
import '../providers/cart_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  final int initialIndex;

  const HomeScreen({super.key, this.initialIndex = 0});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late int myIndex;

  List<Map<String, dynamic>> popularDishes = [];
  List<Map<String, dynamic>> categories = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    myIndex = widget.initialIndex;
    loadData();
  }

  Future<void> loadData() async {
    try {
      final dishesSnapshot = await FirebaseFirestore.instance
          .collection('dishes')
          .get();

      List<Map<String, dynamic>> allDishes = dishesSnapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return {...data, 'id': doc.id};
      }).toList();

      allDishes.shuffle();
      popularDishes = allDishes.take(5).toList();

      final categoriesSnapshot = await FirebaseFirestore.instance
          .collection('categories')
          .orderBy('sort_order')
          .get();

      categories = categoriesSnapshot.docs.take(5).map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return {...data, 'id': doc.id};
      }).toList();

      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      print('Ошибка загрузки данных: $e');
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

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
                                if (!snapshot.hasData || !snapshot.data!.exists) {
                                  return Text(
                                    "Неизвестно",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: "Montserrat",
                                      fontWeight: FontWeight.w500,
                                      fontSize: widthScreen * 0.04,
                                    ),
                                  );
                                }

                                final userData =
                                    snapshot.data!.data()
                                        as Map<String, dynamic>;
                                final address = userData['address'] ?? 'Не указано';
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
                            if (!snapshot.hasData || !snapshot.data!.exists) {
                              return Text(
                                "Неизвестно",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: "Montserrat",
                                  fontWeight: FontWeight.w500,
                                  fontSize: widthScreen * 0.04,
                                ),
                              );
                            }

                            final userData =
                                snapshot.data!.data() as Map<String, dynamic>;
                            final name = userData['name'] ?? 'Не указано';

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

              SizedBox(height: heightScreen * 0.05),

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
                      setState(() {
                        myIndex = 1;
                      });
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
                  itemCount: categories.length,
                  separatorBuilder: (context, index) =>
                      SizedBox(width: widthScreen * 0.03),
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    final name = category['name'] ?? 'Категория';
                    final imageUrl = category['image'] ?? '';

                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DishScreen(
                              categoryId: category['id'],
                              categoryName: name,
                            ),
                          ),
                        );
                      },
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
                                  child: Image.network(
                                    imageUrl,
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(color: Colors.grey[300]);
                                    },
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(widthScreen * 0.02),
                              child: Text(
                                name,
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
                  itemCount: popularDishes.length,
                  separatorBuilder: (context, index) =>
                      SizedBox(width: widthScreen * 0.03),
                  itemBuilder: (context, index) {
                    final dish = popularDishes[index];

                    return GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: widthScreen * 0.35,
                        height: heightScreen * 0.28,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: heightScreen * 0.17,
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
                                child: Image.network(
                                  dish['image'] ?? '',
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(color: Colors.grey[300]);
                                  },
                                ),
                              ),
                            ),

                            Container(
                              height: heightScreen * 0.11,
                              padding: EdgeInsets.all(widthScreen * 0.03),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: Text(
                                      dish['name'] ?? '',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.w600,
                                        fontSize: widthScreen * 0.035,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),

                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        child: Text(
                                          '${(dish['price'] as num).toInt()} ₽',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'Montserrat',
                                            fontWeight: FontWeight.w700,
                                            fontSize: widthScreen * 0.04,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          final cartProvider =
                                              Provider.of<CartProvider>(
                                                context,
                                                listen: false,
                                              );
                                          cartProvider.addItem(
                                            dish['id'] ?? '',
                                            dish['name'] ?? '',
                                            (dish['price'] ?? 0).toDouble(),
                                            dish['image'] ?? '',
                                            prepTime: dish['prepTime'] ?? 20,
                                          );
                                        },
                                        child: Container(
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
              activeIcon: Icon(Icons.grid_view_rounded),
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
