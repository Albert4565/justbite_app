import 'package:flutter/material.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    final widthScreen = mediaQuery.size.width;
    final heightScreen = mediaQuery.size.height;

    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "JustBite",
                style: TextStyle(
                  color: Color(0xFFFF5900),
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.w900,
                  fontSize: widthScreen * 0.15,
                ),
              ),

              Text(
                "Регистрация",
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.w700,
                  fontSize: widthScreen * 0.085,
                ),
              ),

              SizedBox(height: heightScreen * 0.1),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: widthScreen * 0.05),
                child: TextField(
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.w500,
                    fontSize: widthScreen * 0.05,
                  ),
                  decoration: InputDecoration(
                    prefixText: "+7 ",
                    prefixStyle: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                      fontFamily: "Montserrat",
                      fontSize: widthScreen * 0.05,
                    ),
                    hintText: "Номер телефона",
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.w700,
                      fontSize: widthScreen * 0.05,
                    ),
                    suffixIcon: Icon(Icons.phone),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(0),
                      borderSide: BorderSide(color: Color(0xFFC9C9C9)),
                    ),
                    filled: true,
                    fillColor: Color(0xFFF5F5F5),
                  ),
                  keyboardType: TextInputType.phone,
                ),
              ),

              SizedBox(height: heightScreen * 0.015),

              SizedBox(
                width: widthScreen * 0.9,
                height: heightScreen * 0.075,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFFF5900),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    "Продолжить",
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.w500,
                      fontSize: widthScreen * 0.07,
                    ),
                  ),
                ),
              ),

              SizedBox(height: heightScreen * 0.025),

              Center(
                child: Text(
                  "Другие способы входа",
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.w500,
                    fontSize: widthScreen * 0.05,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
