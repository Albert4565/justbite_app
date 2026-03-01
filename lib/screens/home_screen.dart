import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void onPressed()
  {

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFFB7100), Color(0xFFFF953F)],
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(top: 70),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset("assets/images/burger_1.png"),
            SizedBox(height: 70),
            Text(
              "Добро пожаловать\nв JustBite!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 36,
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontFamily: "Montserrat",
                decoration: TextDecoration.none,
              ),
            ),
            SizedBox(height: 15),
            Text(
              "Заказывай любимые\nблюда прямо сейчас",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF474747),
                fontSize: 24,
                fontFamily: "Montserrat",
                decoration: TextDecoration.none,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 105),
            ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFDAD9D9),
                minimumSize: Size(350, 60),
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
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(height: 7),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:
              [
                Text(
                  "Уже есть аккаунт?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    decoration: TextDecoration.none,
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF000000),
                    fontSize: 20,
                  ),
                ),
                SizedBox(width: 5),
                TextButton(
                  onPressed: onPressed,
                  style: TextButton.styleFrom(
                    minimumSize: Size(0, 0),
                    padding: EdgeInsets.zero,
                  ),
                  child: Text("Войти",
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    decorationColor: Color(0xFF016BB7),
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF016BB7),
                    fontSize: 20,
                  ))
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
