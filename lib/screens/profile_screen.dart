import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final widthScreen = mediaQuery.size.width;
    final heightScreen = mediaQuery.size.height;

    String userName = 'Альберт';
    String userNumber = '+7 (999) 123-45-67';

    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 3,
        shadowColor: Colors.black,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          'Профиль',
          style: TextStyle(
            color: Color(0xFFFF5900),
            fontWeight: FontWeight.w500,
            fontFamily: "Montserrat",
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.settings_outlined, color: Color(0xFFFF5900)),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: widthScreen * 0.04,
          vertical: heightScreen * 0.02,
        ),
        child: Column(
          children: [
            Center(
              child: Column(
                children: [
                  Padding(padding: EdgeInsets.only(top: heightScreen * 0.03)),

                  Icon(
                    Icons.account_circle_outlined,
                    color: Colors.black,
                    size: widthScreen * 0.1,
                  ),

                  SizedBox(height: heightScreen * 0.001),

                  StreamBuilder<DocumentSnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('users')
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Text(
                          "Загрузка...",
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.w500,
                            fontSize: widthScreen * 0.06,
                          ),
                        );
                      }

                      final userData = snapshot.data!.data() as Map<String, dynamic>;
                      final name = userData['name'];

                      return Text(
                        '$name',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontFamily: "Montserrat",
                          fontSize: widthScreen * 0.06,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      );
                    },
                  ),

                  SizedBox(height: heightScreen * 0.001),

                  StreamBuilder<DocumentSnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('users')
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Text(
                          "Загрузка...",
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.w500,
                            fontSize: widthScreen * 0.06,
                          ),
                        );
                      }

                      final userData = snapshot.data!.data() as Map<String, dynamic>;
                      final phone = userData['phone'];

                      return Text(
                        '$phone',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontFamily: "Montserrat",
                          fontSize: widthScreen * 0.06,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      );
                    },
                  ),

                  SizedBox(height: heightScreen * 0.03),

                  Column(
                    children: ListTile.divideTiles(
                      context: context,
                      tiles: [
                        ListTile(
                          title: Text(
                            "Мои скидки",
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w500,
                              fontSize: widthScreen * 0.05,
                            ),
                          ),
                          trailing: Icon(
                            Icons.navigate_next,
                            color: Color(0xFFFF5900),
                            size: widthScreen * 0.08,
                          ),
                          onTap: () {},
                        ),

                        ListTile(
                          title: Text(
                            "Избранное",
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w500,
                              fontSize: widthScreen * 0.05,
                            ),
                          ),
                          trailing: Icon(
                            Icons.navigate_next,
                            color: Color(0xFFFF5900),
                            size: widthScreen * 0.08,
                          ),
                          onTap: () {},
                        ),

                        ListTile(
                          title: Text(
                            "Мои заказы",
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w500,
                              fontSize: widthScreen * 0.05,
                            ),
                          ),
                          trailing: Icon(
                            Icons.navigate_next,
                            color: Color(0xFFFF5900),
                            size: widthScreen * 0.08,
                          ),
                          onTap: () {},
                        ),
                      ],
                    ).toList(),
                  ),

                  SizedBox(height: heightScreen * 0.03),

                  TextButton.icon(
                    onPressed: () {},
                    icon: Icon(
                      Icons.logout,
                      color: Color(0xFFFF5900),
                      size: widthScreen * 0.07,
                    ),
                    label: Text(
                      "Выйти из аккаунта",
                      style: TextStyle(
                        color: Color(0xFFFF5900),
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.w500,
                        fontSize: widthScreen * 0.05,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
