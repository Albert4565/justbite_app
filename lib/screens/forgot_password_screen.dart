import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final emailTextInputController = TextEditingController();

  @override
  void dispose() {
    emailTextInputController.dispose();

    super.dispose();
  }

  Future<void> forgotPassword() async {
    if (emailTextInputController.text.trim().isEmpty ||
        !emailTextInputController.text.trim().contains('@')) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Введите корректный email')));
      return;
    }

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: emailTextInputController.text.trim(),
      );

      if (!mounted) return;

      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Письмо'),
            content: Text(
              'Письмо с подтвеждением отправлено на вашу электронную почту (проверьте также папку "спам")',
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: Text("ОК"),
              ),
            ],
          );
        },
      );
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;

      String message = 'Ошибка';

      if (e.code == 'user-not-found') {
        message = 'Пользователь с таким email не найден';
      } else if (e.code == 'invalid-email') {
        message = 'Некорректный email';
      }

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Ошибка: $e')));
    }
  }

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
                Text(
                  "Just Bite",
                  style: TextStyle(
                    color: Color(0xFFFF5900),
                    fontWeight: FontWeight.w900,
                    fontFamily: "Montserrat",
                    fontSize: widthScreen * 0.15,
                  ),
                ),

                SizedBox(height: heightScreen * 0.03),

                Text(
                  "Восстановление\nпароля",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    fontFamily: "Montserrat",
                    fontSize: widthScreen * 0.085,
                  ),
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: heightScreen * 0.1),

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
                      controller: emailTextInputController,
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: "Montserrat",
                        fontSize: widthScreen * 0.05,
                        fontWeight: FontWeight.w500,
                      ),
                      decoration: InputDecoration(
                        hintText: "Введите ваш email...",
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

                SizedBox(height: heightScreen * 0.1),

                SizedBox(
                  height: heightScreen * 0.075,
                  width: widthScreen * 0.9,
                  child: ElevatedButton(
                    onPressed: forgotPassword,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFFF5900),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text(
                      "Отправить",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontFamily: "Montserrat",
                        fontSize: widthScreen * 0.06,
                        color: Colors.black,
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
