import 'package:flutter/material.dart';

class BasketScreen extends StatelessWidget {
  const BasketScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final widthScreen = mediaQuery.size.width;
    final heightScreen = mediaQuery.size.height;

    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 3,
        shadowColor: Colors.black,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          'Корзина',
          style: TextStyle(
            color: Color(0xFFFF5900),
            fontFamily: "Montserrat",
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.delete_rounded,
              color: Color(0xFFFF5900),
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_cart_outlined,
                    color: Color(0xFFFF5900),
                    size: widthScreen * 0.4,
                  ),

                  SizedBox(height: heightScreen * 0.015),

                  Text(
                    "Ваша корзина пуста",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontFamily: "Montserrat",
                      fontSize: widthScreen * 0.075,
                    ),
                  ),

                  SizedBox(height: heightScreen * 0.015),

                  Text(
                    "Добавьте блюда из\nкаталога",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFFFF5900),
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.w500,
                      fontSize: widthScreen * 0.06,
                    ),
                  ),
                ],
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.only(
              bottom: heightScreen * 0.03,
              left: widthScreen * 0.1,
              right: widthScreen * 0.1,
            ),
            child: SizedBox(
              height: heightScreen * 0.065,
              width: widthScreen * 0.8,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFFF5900),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Перейти в меню',
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.w500,
                        fontSize: widthScreen * 0.05,
                      ),
                    ),
                    SizedBox(width: widthScreen * 0.02),
                    Icon(
                      Icons.navigate_next,
                      color: Colors.black,
                      size: widthScreen * 0.05,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      )
    );
  }
}
