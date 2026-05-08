import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'complete_profile_screen.dart';

class SmsConfirmScreen extends StatelessWidget {
  const SmsConfirmScreen({super.key});

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
        leadingWidth: widthScreen * 0.33,
        leading: TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Row(
            children: [
              Icon(
                Icons.arrow_back,
                color: Color(0xFFFF5900),
                size: widthScreen * 0.05,
              ),

              SizedBox(width: widthScreen * 0.05),

              Text(
                "Назад",
                style: TextStyle(
                  color: Color(0xFFFF5900),
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.w500,
                  fontSize: widthScreen * 0.05,
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
                Padding(
                  padding: EdgeInsets.only(top: heightScreen * 0.03),
                  child: Text(
                    "JustBite",
                    style: TextStyle(
                      color: Color(0xFFFF5900),
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.w900,
                      fontSize: widthScreen * 0.12,
                    ),
                  ),
                ),

                SizedBox(height: heightScreen * 0.08),

                Text(
                  "Введите код из СМС",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    fontFamily: "Montserrat",
                    fontSize: widthScreen * 0.06,
                  ),
                ),

                SizedBox(height: heightScreen * 0.08),

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
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.edit,
                        color: Color(0xFFFF5900),
                        size: widthScreen * 0.05,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: heightScreen * 0.08),

                PinCodeTextField(
                  appContext: context,
                  length: 6,
                  keyboardType: TextInputType.number,
                  mainAxisAlignment: MainAxisAlignment.center,
                  textStyle: TextStyle(fontSize: widthScreen * 0.06),
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    fieldOuterPadding: EdgeInsets.symmetric(
                      horizontal: widthScreen * 0.02,
                    ),
                    borderRadius: BorderRadius.circular(8),
                    fieldHeight: heightScreen * 0.075,
                    fieldWidth: widthScreen * 0.1,
                    borderWidth: 1,
                    activeFillColor: Color(0xFFF5F5F5),
                    inactiveFillColor: Color(0xFFF5F5F5),
                    selectedFillColor: Color(0xFFF5F5F5),
                    activeColor: Color(0xFFFF5900),
                    inactiveColor: Color(0xFFC9C9C9),
                    selectedColor: Color(0xFFFF5900),
                  ),
                ),

                SizedBox(height: heightScreen * 0.08),

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
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      "Подтвердить",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontFamily: "Montserrat",
                        fontSize: widthScreen * 0.06,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: heightScreen * 0.01),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        "Отправить код повторно",
                        style: TextStyle(
                          color: Color(0xFFFF5900),
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w500,
                          fontSize: widthScreen * 0.045,
                        ),
                      ),
                    ),
                    Text(
                      "(0:59)",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: widthScreen * 0.045,
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.w500,
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