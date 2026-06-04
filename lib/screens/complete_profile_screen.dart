import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CompleteProfileScreen extends StatefulWidget {
  const CompleteProfileScreen({super.key});

  @override
  State<CompleteProfileScreen> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  final nameController = TextEditingController();
  final addressController = TextEditingController();
  final phoneController = TextEditingController();

  String? selectedCity;

  List<Map<String, String>> _cachedCities = [];
  bool _citiesLoaded = false;

  Future<void> _loadCities() async {
    if (_citiesLoaded) return;

    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('cities')
          .orderBy('label')
          .get();

      _cachedCities = snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return {
          'value': data['value'] as String,
          'label': data['label'] as String,
        };
      }).toList();

      _citiesLoaded = true;

      if (mounted) setState(() {});
    } catch (e) {
      print('Ошибка загрузки городов: $e');
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    addressController.dispose();
    phoneController.dispose();

    super.dispose();
  }

  Future<void> saveProfile() async {
    if (nameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Введите имя')));
      return;
    }

    if (selectedCity == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Выберите город')));
      return;
    }

    if (addressController.text.trim().isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Введите адрес')));
      return;
    }

    if (phoneController.text.trim().isEmpty ||
        phoneController.text.length < 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Введите корректный номер телефона')),
      );
      return;
    }

    try {
      final user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        throw Exception('Пользователь не авторизован');
      }

      final cityDoc = await FirebaseFirestore.instance
          .collection('cities')
          .where('value', isEqualTo: selectedCity)
          .get();

      if (cityDoc.docs.isEmpty) {
        throw Exception('Город не найден');
      }

      final cityData = cityDoc.docs.first.data() as Map<String, dynamic>;
      final cityLabel = cityData['label'] as String;

      String phone = phoneController.text.trim();
      String formattedPhone =
          '+7 (${phone.substring(0, 3)}) ${phone.substring(3, 6)}-${phone.substring(6, 8)}-${phone.substring(8, 10)}';

      await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
        'uid': user.uid,
        'email': user.email,
        'name': nameController.text.trim(),
        'city': selectedCity,
        'cityLabel': cityLabel,
        'address': addressController.text.trim(),
        'phone': formattedPhone,
        'phoneRaw': '+7$phone',
        'createdAt': FieldValue.serverTimestamp(),
        'updateAt': FieldValue.serverTimestamp(),
      });

      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
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

                SizedBox(height: heightScreen * 0.02),

                Text(
                  "Завершение профиля",
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: "Montserrat",
                    fontSize: widthScreen * 0.06,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                SizedBox(height: heightScreen * 0.02),

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
                      controller: nameController,
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

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: widthScreen * 0.05),
                  child: Container(
                    width: widthScreen * 0.9,
                    padding: EdgeInsets.symmetric(horizontal: widthScreen * 0.02),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black, width: 1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: FutureBuilder<void>(
                      future: _loadCities(),
                      builder: (context, snapshot) {
                        if (!_citiesLoaded) {
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: heightScreen * 0.02),
                            child: Center(
                              child: CircularProgressIndicator(color: Color(0xFFFF5900)),
                            ),
                          );
                        }
                        
                        if (_cachedCities.isEmpty) {
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: heightScreen * 0.02),
                            child: Text(
                              'Не удалось загрузить города',
                              style: TextStyle(color: Colors.red),
                            ),
                          );
                        }
                        
                        return DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: selectedCity,
                            isExpanded: true,
                            underline: SizedBox(),
                            hint: Text(
                              'Выберите город',
                              style: TextStyle(
                                color: Color(0xFFC9C9C9),
                                fontFamily: "Montserrat",
                                fontSize: widthScreen * 0.05,
                              ),
                            ),
                            items: _cachedCities.map((city) {
                              return DropdownMenuItem<String>(
                                value: city['value'],
                                child: Text(
                                  city['label']!,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: "Montserrat",
                                    fontSize: widthScreen * 0.05,
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (String? value) {
                              setState(() {
                                selectedCity = value;
                              });
                            },
                          ),
                        );
                      },
                    ),
                  ),
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
                      controller: addressController,
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
                      keyboardType: TextInputType.streetAddress,
                    ),
                  ),
                ),

                SizedBox(height: heightScreen * 0.02),

                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: widthScreen * 0.05),
                    child: Text(
                      "Номер телефона",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Montserrat",
                        fontSize: widthScreen * 0.05,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: heightScreen * 0.02),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: widthScreen * 0.05),
                  child: Container(
                    height: heightScreen * 0.075,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black),
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

                        VerticalDivider(color: Colors.black),

                        Expanded(
                          child: TextField(
                            controller: phoneController,
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

                SizedBox(height: heightScreen * 0.03),

                SizedBox(
                  width: widthScreen * 0.9,
                  height: heightScreen * 0.075,
                  child: ElevatedButton(
                    onPressed: saveProfile,
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

                SizedBox(height: heightScreen * 0.05),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
