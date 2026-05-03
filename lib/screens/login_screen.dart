import 'package:flutter/material.dart';
import 'sms_confirm_screen.dart';
import 'registration_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _phoneController = TextEditingController();
  bool _isLoading = false;

  Future<void> _sendSms() async {
    if (_phoneController.text.length < 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Введите корректный номер телефона')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      String fullPhone = '+7${_phoneController.text}';

      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: fullPhone,

        verificationCompleted: (credential) async {
          await FirebaseAuth.instance.signInWithCredential(credential);
        },

        verificationFailed: (e) {
          setState(() => _isLoading = false);
          if (!mounted) return;
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Ошибка: ${e.message}')));
        },

        codeSent: (String verificationId, int? resendToken) {
          setState(() => _isLoading = false);
          if (!mounted) return;

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SmsConfirmScreen(
                verificationId: verificationId,
                phoneNumber: fullPhone,
                isRegistration: false,
              ),
            ),
          );
        },

        codeAutoRetrievalTimeout: (verificationId) {
          setState(() => _isLoading = false);
        },
      );
    } catch (e) {
      setState(() => _isLoading = false);
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Ошибка: $e')));
    }
  }

  void _handleButtonPress() {
    if (_isLoading) {
      return;
    }
    _sendSms();
  }

  Widget _buildButtonChild() {
    final widthScreen = MediaQuery.of(context).size.width;

    if (_isLoading) {
      return CircularProgressIndicator(color: Colors.white);
    }
    return Text(
      "Войти",
      style: TextStyle(
        color: Colors.black,
        fontFamily: "Montserrat",
        fontWeight: FontWeight.w500,
        fontSize: widthScreen * 0.06,
      ),
    );
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

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
            padding: EdgeInsets.symmetric(vertical: heightScreen * 0.03),
            child: Column(
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
                  "С возвращением!",
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
                  child: Container(
                    height: heightScreen * 0.075,
                    decoration: BoxDecoration(
                      color: Color(0xFFF5F5F5),
                      border: Border.all(color: Color(0xFFC9C9C9)),
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: widthScreen * 0.04,
                          ),
                          child: Text(
                            "+7",
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w700,
                              fontSize: heightScreen * 0.025,
                            ),
                          ),
                        ),

                        VerticalDivider(color: Color(0xFFC9C9C9)),

                        Expanded(
                          child: TextField(
                            controller: _phoneController,
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontFamily: "Montserrat",
                              fontSize: heightScreen * 0.025,
                            ),
                            decoration: InputDecoration(
                              hintText: "Номер телефона",
                              hintStyle: TextStyle(
                                color: Color(0xFFC9C9C9),
                                fontFamily: "Montserrat",
                                fontWeight: FontWeight.w700,
                                fontSize: heightScreen * 0.025,
                              ),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: widthScreen * 0.03,
                              ),
                            ),
                            keyboardType: TextInputType.phone,
                            maxLength: 10,
                            buildCounter:
                                (
                                  context, {
                                  required currentLength,
                                  required maxLength,
                                  required isFocused,
                                }) => null,
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.only(right: widthScreen * 0.04),
                          child: Icon(
                            Icons.call,
                            color: Color(0xFFC9C9C9),
                            size: heightScreen * 0.025,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: heightScreen * 0.015),

                SizedBox(
                  width: widthScreen * 0.9,
                  height: heightScreen * 0.075,
                  child: ElevatedButton(
                    onPressed: _handleButtonPress,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFFF5900),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: _buildButtonChild(),
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
                        Image.asset("assets/images/icon_mail.png"),

                        SizedBox(width: widthScreen * 0.03),

                        Text(
                          "Почта",
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
                      "Ещё нет аккаунта?",
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
                            builder: (context) => const RegistrationScreen(),
                          ),
                        );
                      },
                      child: Text(
                        "Регистрация",
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
                SizedBox(height: heightScreen * 0.02),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
