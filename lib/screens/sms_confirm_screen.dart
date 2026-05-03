import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'complete_profile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home_screen.dart';
import 'dart:async';

class SmsConfirmScreen extends StatefulWidget {
  final String verificationId;
  final String phoneNumber;
  final bool isRegistration;

  const SmsConfirmScreen({
    super.key,
    required this.verificationId,
    required this.phoneNumber,
    required this.isRegistration,
  });

  @override
  State<SmsConfirmScreen> createState() => _SmsConfirmScreenState();
}

class _SmsConfirmScreenState extends State<SmsConfirmScreen> {
  final _codeController = TextEditingController();
  bool _isLoading = false;
  int _timerSeconds = 60;
  Timer? _timer;
  bool _canResend = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timerSeconds > 0) {
        setState(() => _timerSeconds--);
      } else {
        setState(() => _canResend = true);
        _timer?.cancel();
      }
    });
  }

  String get _formattedTimer {
    final minutes = _timerSeconds ~/ 60;
    final seconds = _timerSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  void _handleButtonPress() {
    if (_isLoading) {
      return;
    }
    _verifyCode();
  }

  Widget _buildButtonChild() {
    final widthScreen = MediaQuery.of(context).size.width;

    if (_isLoading) {
      return CircularProgressIndicator(color: Colors.white);
    }
    return Text(
      "Подтвердить",
      style: TextStyle(
        fontWeight: FontWeight.w500,
        fontFamily: "Montserrat",
        fontSize: widthScreen * 0.06,
        color: Colors.black,
      ),
    );
  }

  void _handleResendPress() {
    if (!_canResend) {
      return;
    }
    _resendCode();
  }

  Future<void> _verifyCode() async {
    if (_codeController.text.length != 6) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Введите 6-значный код')));
      return;
    }

    setState(() => _isLoading = true);

    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: widget.verificationId,
        smsCode: _codeController.text,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);

      if (!mounted) return;

      if (widget.isRegistration) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const CompleteProfileScreen(),
          ),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      }
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Ошибка: ${e.message}')));
    } catch (e) {
      if (!mounted) return;
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Ошибка: $e')));
    }
  }

  Future<void> _resendCode() async {
    if (!_canResend) return;

    setState(() {
      _timerSeconds = 60;
      _canResend = false;
    });
    _startTimer();

    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: widget.phoneNumber,
        verificationCompleted: (credential) async {
          await FirebaseAuth.instance.signInWithCredential(credential);
        },
        verificationFailed: (e) {
          if (!mounted) return;
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Ошибка: ${e.message}')));
        },
        codeSent: (verificationId, resendToken) {},
        codeAutoRetrievalTimeout: (verificationId) {},
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Ошибка: $e')));
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _codeController.dispose();
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
                      widget.phoneNumber,
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

                  onChanged: (value) {
                    _codeController.text = value;
                  },

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

                SizedBox(height: heightScreen * 0.01),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: _handleResendPress,
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
                      "($_formattedTimer)",
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
