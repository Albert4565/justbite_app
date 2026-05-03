import 'package:flutter/material.dart';
import 'package:justbite_app/screens/registration_screen.dart';
import 'home_screen.dart';

class CompleteProfileScreen extends StatelessWidget {
  const CompleteProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final widthScreen = mediaQuery.size.width;
    final heightScreen = mediaQuery.size.height;

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
      backgroundColor: Color(0xFFF5F5F5),
      resizeToAvoidBottomInset: true,
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

                SizedBox(height: heightScreen * 0.025),

                Text(
                  "Завершение профиля",
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: "Montserrat",
                    fontSize: widthScreen * 0.06,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                SizedBox(height: heightScreen * 0.04),

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

                SizedBox(height: heightScreen * 0.01),

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

                SizedBox(height: heightScreen * 0.01),

                DropdownMenu(
                  width: widthScreen * 0.9,
                  textStyle: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: widthScreen * 0.05,
                  ),
                  dropdownMenuEntries: [
                    DropdownMenuEntry(value: "moscow", label: "Москва"),
                    DropdownMenuEntry(value: "sarov", label: "Саров"),
                    DropdownMenuEntry(value: "temnikov", label: "Темников"),
                  ],
                ),

                SizedBox(height: heightScreen * 0.01),

                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: widthScreen * 0.05),
                    child: Text(
                      "Укажите адрес",
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
                        hintText: "Например, ул. Чкалова, д. 57, кв. 2",
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

                SizedBox(height: heightScreen * 0.02),

                Text(
                  "Номер",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: widthScreen * 0.05,
                    fontWeight: FontWeight.w700,
                    fontFamily: "Montserrat",
                  ),
                ),

                SizedBox(height: heightScreen * 0.001),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "+7 (999) 123-60-90",
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.w500,
                        fontSize: widthScreen * 0.05,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RegistrationScreen(),
                          ),
                        );
                      },
                      icon: Icon(
                        Icons.edit,
                        color: Color(0xFFFF5900),
                        size: widthScreen * 0.05,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: heightScreen * 0.03),

                SizedBox(
                  width: widthScreen * 0.9,
                  height: heightScreen * 0.075,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomeScreen(),
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
                      "Продолжить",
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.w500,
                        fontSize: widthScreen * 0.06,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: heightScreen * 0.001),

                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
                      ),
                    );
                  },
                  child: Text(
                    "Пропустить",
                    style: TextStyle(
                      color: Color(0xFF7A7A7A),
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.w500,
                      fontSize: widthScreen * 0.045,
                    ),
                  ),
                ),

                SizedBox(height: heightScreen * 0.05),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
