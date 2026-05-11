import 'package:flutter/material.dart';
import 'complete_profile_screen.dart';
import 'login_email_screen.dart';

class RegistrationEmailScreen extends StatelessWidget {
  const RegistrationEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final widthScreen = mediaQuery.size.width;
    final heightScreen = mediaQuery.size.height;

    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      resizeToAvoidBottomInset: true,
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(vertical: heightScreen * 0.02),
            child: Column(
              children: [
                Text(
                  "Just Bite",
                  style: TextStyle(
                    color: Color(0xFFFF5900),
                    fontWeight: FontWeight.w900,
                    fontFamily: "Montserrat",
                    fontSize: widthScreen * 0.12,
                  ),
                ),

                SizedBox(height: heightScreen * 0.005),

                Text(
                  "Регистрация",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    fontFamily: "Montserrat",
                    fontSize: widthScreen * 0.06,
                  ),
                ),

                SizedBox(height: heightScreen * 0.01),

                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: widthScreen * 0.05),
                    child: Text(
                      "Email",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Montserrat",
                        fontSize: widthScreen * 0.05,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: heightScreen * 0.01),

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
                        hintText: "Введите вашу почту...",
                        hintStyle: TextStyle(
                          color: Color(0xFFC9C9C9),
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w500,
                          fontSize: widthScreen * 0.05,
                        ),
                        suffixIcon: Icon(
                          Icons.email_outlined,
                          color: Color(0xFFC1C1C1),
                        ),
                        suffixIconConstraints: BoxConstraints(
                          minHeight: heightScreen * 0.01,
                          minWidth: widthScreen * 0.1,
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(
                          left: widthScreen * 0.03,
                        ),
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),
                ),

                SizedBox(height: heightScreen * 0.02),

                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: widthScreen * 0.05),
                    child: Text(
                      "Пароль",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Montserrat",
                        fontSize: widthScreen * 0.05,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: heightScreen * 0.01),

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
                      obscureText: true,
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: "Montserrat",
                        fontSize: widthScreen * 0.05,
                        fontWeight: FontWeight.w500,
                      ),
                      decoration: InputDecoration(
                        hintText: "Придумайте пароль...",
                        hintStyle: TextStyle(
                          color: Color(0xFFC9C9C9),
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w500,
                          fontSize: widthScreen * 0.05,
                        ),
                        suffixIcon: Icon(
                          Icons.visibility_off_outlined,
                          color: Color(0xFFC1C1C1),
                        ),
                        suffixIconConstraints: BoxConstraints(
                          minHeight: heightScreen * 0.01,
                          minWidth: widthScreen * 0.1,
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(
                          left: widthScreen * 0.03,
                        ),
                      ),
                      keyboardType: TextInputType.visiblePassword,
                    ),
                  ),
                ),

                SizedBox(height: heightScreen * 0.02),

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
                      obscureText: true,
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: "Montserrat",
                        fontSize: widthScreen * 0.05,
                        fontWeight: FontWeight.w500,
                      ),
                      decoration: InputDecoration(
                        hintText: "Подтвердите пароль...",
                        hintStyle: TextStyle(
                          color: Color(0xFFC9C9C9),
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w500,
                          fontSize: widthScreen * 0.05,
                        ),
                        suffixIcon: Icon(
                          Icons.visibility_off_outlined,
                          color: Color(0xFFC1C1C1),
                        ),
                        suffixIconConstraints: BoxConstraints(
                          minHeight: heightScreen * 0.01,
                          minWidth: widthScreen * 0.1,
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(
                          left: widthScreen * 0.03,
                        ),
                      ),
                      keyboardType: TextInputType.visiblePassword,
                    ),
                  ),
                ),

                SizedBox(height: heightScreen * 0.03),

                SizedBox(
                  height: heightScreen * 0.075,
                  width: widthScreen * 0.9,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CompleteProfileScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFFF5900),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text(
                      "Зарегистрироваться",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontFamily: "Montserrat",
                        fontSize: widthScreen * 0.06,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: heightScreen * 0.02),

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

                SizedBox(height: heightScreen * 0.02),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: widthScreen * 0.04),
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      minimumSize: Size(
                        widthScreen * 0.9,
                        heightScreen * 0.075,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                      backgroundColor: Colors.white,
                      side: BorderSide(color: Color(0xFFE0E0E0)),
                    ),
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset("assets/images/icon_vk.png"),

                        SizedBox(width: widthScreen * 0.03),

                        Text(
                          "VK ID",
                          style: TextStyle(
                            color: Color(0xFF1A1A1A),
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.w500,
                            fontSize: heightScreen * 0.025,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: heightScreen * 0.025),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: widthScreen * 0.04),
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      minimumSize: Size(
                        widthScreen * 0.9,
                        heightScreen * 0.075,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                      backgroundColor: Colors.white,
                      side: BorderSide(color: Color(0xFFE0E0E0)),
                    ),
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset("assets/images/icon_ya.png"),

                        SizedBox(width: widthScreen * 0.03),

                        Text(
                          "Яндекс ID",
                          style: TextStyle(
                            color: Color(0xFF1A1A1A),
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.w500,
                            fontSize: heightScreen * 0.025,
                          ),
                        ),
                      ],
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
                          MaterialPageRoute(
                            builder: (context) => const LoginEmailScreen(),
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
        ),
      ),
    );
  }
}
