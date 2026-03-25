import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CompleteProfileScreen extends StatelessWidget {
  const CompleteProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final widthScreen = mediaQuery.size.width;
    final heightScreen = mediaQuery.size.height;

    final cities = ['Москва', 'Саров', 'Темников'];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 3,
        shadowColor: Colors.black,
        leadingWidth: widthScreen * 0.33,
        leading: TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Row(
            children: [
              Icon(Icons.arrow_back, color: Color(0xFFFF5900)),

              SizedBox(width: widthScreen * 0.05),

              Text(
                "Назад",
                style: TextStyle(
                  color: Color(0xFFFF5900),
                  fontFamily: "Montserrat",
                  fontSize: widthScreen * 0.05,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(vertical: heightScreen * 0.03),
            child: Column(
              children: [
                Text(
                  "JustBite",
                  style: TextStyle(
                    color: Color(0xFFFF5900),
                    fontWeight: FontWeight.w900,
                    fontSize: widthScreen * 0.12,
                    fontFamily: "Montserrat",
                  ),
                ),
                Text(
                  "Завершение профиля",
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: "Montserrat",
                    fontSize: widthScreen * 0.06,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: widthScreen * 0.05),
                    child: Text(
                      "Имя",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Montserrat",
                        fontSize: widthScreen * 0.05,
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: widthScreen * 0.05),
                  child: Container(
                    width: widthScreen * 0.9,
                    height: heightScreen * 0.06,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black, width: 1),
                    ),
                    child: TextField(
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: "Montserrat",
                        fontSize: widthScreen * 0.05,
                        fontWeight: FontWeight.w500,
                      ),
                      decoration: InputDecoration(
                        hintText: "Введите ваше имя...",
                        hintStyle: TextStyle(
                          color: Color(0xFFC9C9C9),
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w500,
                          fontSize: widthScreen * 0.05,
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(
                          left: widthScreen * 0.03,
                        ),
                      ),
                      keyboardType: TextInputType.name,
                    ),
                  ),
                ),

                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: widthScreen * 0.05),
                    child: Text(
                      "Выберите город",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Montserrat",
                        fontSize: widthScreen * 0.05,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
