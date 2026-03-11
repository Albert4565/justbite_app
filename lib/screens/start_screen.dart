import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void onPressed() {}

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    final widthScreen = mediaQuery.size.width;
    final heightScreen = mediaQuery.size.height;
    final paddingTop = mediaQuery.padding.top;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFFB7100), Color(0xFFFF953F)],
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(top: paddingTop),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: widthScreen * 0.8,
                height: heightScreen * 0.30,
                child: Image.asset("assets/images/burger_1.png",
                fit: BoxFit.contain,
                ),
              ),
              SizedBox(height: heightScreen * 0.04),
              Text(
                "Добро пожаловать\nв JustBite!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: widthScreen * 0.08,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Montserrat",
                  decoration: TextDecoration.none,
                ),
              ),
              SizedBox(height: heightScreen * 0.015),
              Text(
                "Заказывай любимые\nблюда прямо сейчас",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF474747),
                  fontSize: widthScreen * 0.05,
                  fontFamily: "Montserrat",
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: heightScreen * 0.105),
              SizedBox(
                width: widthScreen * 0.85,
                height: heightScreen * 0.07,
                child: ElevatedButton(
                  onPressed: onPressed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFDAD9D9),
                    shadowColor: Colors.black,
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    "Начать",
                    style: TextStyle(
                      fontFamily: "Montserrat",
                      fontSize: widthScreen * 0.07,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              SizedBox(height: heightScreen * 0.007),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Уже есть аккаунт?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF000000),
                      fontSize: widthScreen * 0.045,
                    ),
                  ),
                  SizedBox(width: widthScreen * 0.005),
                  TextButton(
                    onPressed: onPressed,
                    style: TextButton.styleFrom(
                      minimumSize: Size(0, 0),
                      padding: EdgeInsets.zero,
                    ),
                    child: Text(
                      "Войти",
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        decorationColor: Color(0xFF016BB7),
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF016BB7),
                        fontSize: widthScreen * 0.045,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: heightScreen * 0.03),
            ],
          ),
        ),
      ),
    );
  }
}
