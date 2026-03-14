import 'package:flutter/material.dart';
import 'registration_screen.dart';
import 'login_screen.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    final widthScreen = mediaQuery.size.width;
    final heightScreen = mediaQuery.size.height;

    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: SizedBox(
                height: heightScreen * 0.5,
                width: widthScreen * 0.8,
                child: Image.asset(
                  "assets/images/burger_1.png",
                  fit: BoxFit.contain,
                ),
              ),
            ),

            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Добро пожаловать\nв JustBite!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: "Montserrat",
                      color: Colors.black,
                      fontSize: widthScreen * 0.08,
                      fontWeight: FontWeight.w700,
                      height: 1.2,
                    ),
                  ),
                  SizedBox(height: heightScreen * 0.015),
                  Text(
                    "Заказывай любимые\nблюда прямо сейчас",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: "Montserrat",
                      color: Color(0xFF474747),
                      fontWeight: FontWeight.w700,
                      fontSize: widthScreen * 0.055,
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: heightScreen * 0.065,
                    width: widthScreen * 0.8,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const RegistrationScreen()
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFFF5900),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        "Начать",
                        style: TextStyle(
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                          fontSize: widthScreen * 0.075,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: heightScreen * 0.005),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Уже есть аккаунт?",
                        style: TextStyle(
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                          fontSize: widthScreen * 0.045,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const LoginScreen()
                            ),
                          );
                        },
                        child: Text(
                          "Войти",
                          style: TextStyle(
                            color: Color(0xFFFF5900),
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.w500,
                            fontSize: widthScreen * 0.045,
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
  }
}
