import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home_screen.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  String paymentMethod = 'Наличные';
  final TextEditingController commentController = TextEditingController();

  int get totalPrepTime {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    if (cartProvider.itemsList.isEmpty) return 0;

    final totalTime = cartProvider.itemsList.fold(
      0,
      (sum, item) => sum + (item.prepTime * item.quantity),
    );

    return totalTime;
  }

  @override
  void dispose() {
    commentController.dispose();
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
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFFFF5900)),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Text(
          'Оформление заказа',
          style: TextStyle(
            color: Color(0xFFFF5900),
            fontFamily: "Montserrat",
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Consumer<CartProvider>(
        builder: (context, cartProvider, child) {
          final cartItems = cartProvider.itemsList;

          return Column(
            children: [
              Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                      vertical: heightScreen * 0.02,
                      horizontal: widthScreen * 0.04,
                    ),
                    child: Center(
                      child: Column(
                        children: [
                          Text(
                            'Доставка',
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w700,
                              fontSize: widthScreen * 0.05,
                            ),
                          ),

                          StreamBuilder<DocumentSnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('users')
                                .doc(FirebaseAuth.instance.currentUser!.uid)
                                .snapshots(),
                            builder: (context, snapshot) {
                              String address = 'Адрес не указан';
                              String cityLabel = '';

                              if (snapshot.hasData && snapshot.data!.exists) {
                                final userData =
                                    snapshot.data!.data()
                                        as Map<String, dynamic>;
                                address =
                                    userData['address'] ?? 'Адрес не указан';
                                cityLabel = userData['cityLabel'] ?? '';
                              }

                              return Container(
                                padding: EdgeInsets.all(widthScreen * 0.03),
                                decoration: BoxDecoration(),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.location_on,
                                          color: Color(0xFFFF5900),
                                          size: widthScreen * 0.05,
                                        ),
                                        SizedBox(width: widthScreen * 0.02),
                                        Expanded(
                                          child: Text(
                                            '$cityLabel, $address',
                                            style: TextStyle(
                                              fontFamily: "Montserrat",
                                              fontSize: widthScreen * 0.04,
                                            ),
                                          ),
                                        ),
                                        IconButton(
                                          icon: Icon(
                                            Icons.edit,
                                            color: Color(0xFFFF5900),
                                            size: widthScreen * 0.04,
                                          ),
                                          onPressed: () =>
                                              showEditAddressDialog(context),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: heightScreen * 0.01),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.access_time,
                                          color: Color(0xFFFF5900),
                                          size: widthScreen * 0.05,
                                        ),
                                        SizedBox(width: widthScreen * 0.02),
                                        Text(
                                          '~${cartProvider.totalPrepTime} мин',
                                          style: TextStyle(
                                            fontSize: widthScreen * 0.04,
                                            fontFamily: "Montserrat",
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),

                          SizedBox(height: heightScreen * 0.02),

                          Text(
                            'Контакты',
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w700,
                              fontSize: widthScreen * 0.05,
                            ),
                            textAlign: TextAlign.center,
                          ),

                          StreamBuilder<DocumentSnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('users')
                                .doc(FirebaseAuth.instance.currentUser!.uid)
                                .snapshots(),
                            builder: (context, snapshot) {
                              String name = 'Имя не указано';
                              String phone = 'Телефон не указан';

                              if (snapshot.hasData && snapshot.data!.exists) {
                                final userData =
                                    snapshot.data!.data()
                                        as Map<String, dynamic>;
                                name = userData['name'] ?? 'Имя не указано';
                                phone =
                                    userData['phone'] ?? 'Телефон не указан';
                              }

                              return Container(
                                padding: EdgeInsets.all(widthScreen * 0.03),
                                decoration: BoxDecoration(),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.person,
                                          color: Color(0xFFFF5900),
                                          size: widthScreen * 0.05,
                                        ),
                                        SizedBox(width: widthScreen * 0.02),
                                        Expanded(
                                          child: Text(
                                            name,
                                            style: TextStyle(
                                              fontFamily: "Montserrat",
                                              fontSize: widthScreen * 0.04,
                                            ),
                                          ),
                                        ),
                                        IconButton(
                                          icon: Icon(
                                            Icons.edit,
                                            color: Color(0xFFFF5900),
                                            size: widthScreen * 0.04,
                                          ),
                                          onPressed: () =>
                                              showEditNameDialog(context),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: heightScreen * 0.01),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.phone,
                                          color: Color(0xFFFF5900),
                                          size: widthScreen * 0.05,
                                        ),
                                        SizedBox(width: widthScreen * 0.02),
                                        Expanded(
                                          child: Text(
                                            phone,
                                            style: TextStyle(
                                              fontSize: widthScreen * 0.04,
                                              fontFamily: "Montserrat",
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                        IconButton(
                                          icon: Icon(
                                            Icons.edit,
                                            color: Color(0xFFFF5900),
                                            size: widthScreen * 0.04,
                                          ),
                                          onPressed: () =>
                                              showEditPhoneDialog(context),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),

                          SizedBox(height: heightScreen * 0.02),

                          Text(
                            'Оплата',
                            style: TextStyle(
                              fontSize: widthScreen * 0.05,
                              fontWeight: FontWeight.w700,
                              fontFamily: "Montserrat",
                              color: Colors.black,
                            ),
                          ),

                          SizedBox(height: heightScreen * 0.01),

                          Container(
                            padding: EdgeInsets.all(widthScreen * 0.03),
                            decoration: BoxDecoration(color: Color(0xFFFF5900)),
                            child: DropdownButton<String>(
                              value: paymentMethod,
                              isExpanded: true,
                              underline: SizedBox(),
                              items: ['Наличные', 'По карте'].map((
                                String value,
                              ) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      left: widthScreen * 0.03,
                                    ),
                                    child: Text(
                                      value,
                                      style: TextStyle(
                                        fontSize: widthScreen * 0.05,
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  paymentMethod = newValue!;
                                });
                              },
                            ),
                          ),

                          SizedBox(height: heightScreen * 0.02),

                          Text(
                            'Товары',
                            style: TextStyle(
                              fontSize: widthScreen * 0.05,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Montserrat',
                              color: Colors.black,
                            ),
                          ),

                          SizedBox(height: heightScreen * 0.01),

                          Column(
                            children: cartItems.map((item) {
                              return Container(
                                margin: EdgeInsets.only(
                                  bottom: heightScreen * 0.01,
                                ),
                                padding: EdgeInsets.all(widthScreen * 0.03),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: Color(0xFFC1C1C1)),
                                ),
                                child: Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.network(
                                        item.image,
                                        width: widthScreen * 0.18,
                                        height: heightScreen * 0.08,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    SizedBox(width: widthScreen * 0.03),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            item.name,
                                            style: TextStyle(
                                              fontSize: widthScreen * 0.04,
                                              fontFamily: 'Montserrat',
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          SizedBox(
                                            height: heightScreen * 0.005,
                                          ),
                                          Text(
                                            'x${item.quantity}',
                                            style: TextStyle(
                                              fontSize: widthScreen * 0.035,
                                              fontFamily: 'Montserrat',
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Text(
                                      '${(item.price * item.quantity).toStringAsFixed(0)} ₽',
                                      style: TextStyle(
                                        fontSize: widthScreen * 0.045,
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),

                          SizedBox(height: heightScreen * 0.01),

                          Container(
                            padding: EdgeInsets.all(widthScreen * 0.03),
                            decoration: BoxDecoration(),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Сумма заказа:',
                                      style: TextStyle(
                                        fontSize: widthScreen * 0.05,
                                        fontFamily: "Montserrat",
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),

                                    Text(
                                      '${cartProvider.totalAmount.toStringAsFixed(0)} ₽',
                                      style: TextStyle(
                                        fontSize: widthScreen * 0.045,
                                        fontFamily: "Montserrat",
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          SizedBox(height: heightScreen * 0.02),

                          Text(
                            'Комментарий',
                            style: TextStyle(
                              fontSize: widthScreen * 0.05,
                              fontWeight: FontWeight.w700,
                              fontFamily: "Montserrat",
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: heightScreen * 0.01),
                          Container(
                            padding: EdgeInsets.all(widthScreen * 0.03),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: TextField(
                              controller: commentController,
                              maxLines: 5,
                              decoration: InputDecoration(
                                hintText: 'Оставьте комментарий...',
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontFamily: "Montserrat",
                                  fontSize: widthScreen * 0.035,
                                ),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.zero,
                              ),
                            ),
                          ),

                          SizedBox(height: heightScreen * 0.02),

                          SizedBox(
                            width: double.infinity,
                            height: heightScreen * 0.07,
                            child: ElevatedButton(
                              onPressed: () async {
                                final cartProvider = Provider.of<CartProvider>(
                                  context,
                                  listen: false,
                                );

                                if (cartProvider.itemsList.isEmpty) return;

                                showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (context) => Center(
                                    child: CircularProgressIndicator(
                                      color: Color(0xFFFF5900),
                                    ),
                                  ),
                                );

                                try {
                                  await FirebaseFirestore.instance
                                      .collection('orders')
                                      .add({
                                        'userId': FirebaseAuth
                                            .instance
                                            .currentUser!
                                            .uid,
                                        'items': cartProvider.itemsList
                                            .map((item) => item.toMap())
                                            .toList(),
                                        'totalAmount': cartProvider.totalAmount,
                                        'status': 'Принят',
                                        'createdAt':
                                            FieldValue.serverTimestamp(),
                                      });

                                  if (mounted) Navigator.pop(context);

                                  await showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (context) => AlertDialog(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      title: Center(
                                        child: Icon(
                                          Icons.check_circle_outline,
                                          color: Color(0xFFFF5900),
                                          size: widthScreen * 0.15,
                                        ),
                                      ),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            'Заказ принят!',
                                            style: TextStyle(
                                              fontSize: widthScreen * 0.05,
                                              fontWeight: FontWeight.w700,
                                              fontFamily: 'Montserrat',
                                            ),
                                            textAlign: TextAlign.center,
                                          ),

                                          SizedBox(height: heightScreen * 0.02),

                                          Container(
                                            padding: EdgeInsets.all(
                                              widthScreen * 0.025,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Colors.grey[100],
                                              borderRadius: BorderRadius.circular(
                                                10,
                                              ),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.access_time,
                                                  color: Colors.grey[700],
                                                  size: widthScreen * 0.05,
                                                ),
                                                SizedBox(
                                                  width: widthScreen * 0.02,
                                                ),
                                                Text(
                                                  '~${cartProvider.totalPrepTime} мин',
                                                  style: TextStyle(
                                                    fontSize: widthScreen * 0.04,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),

                                          SizedBox(height: heightScreen * 0.013),

                                          Text(
                                            'Итого: ${cartProvider.totalAmount.toStringAsFixed(0)} ₽',
                                            style: TextStyle(
                                              fontSize: widthScreen * 0.045,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xFFFF5900),
                                            ),
                                          ),

                                          SizedBox(height: heightScreen * 0.02),

                                          Text(
                                            'Для связи с оператором:',
                                            style: TextStyle(
                                              color: Colors.grey[600],
                                              fontSize: widthScreen * 0.03,
                                            ),
                                          ),
                                          Text(
                                            '+7 (800) 555-35-35',
                                            style: TextStyle(
                                              fontSize: widthScreen * 0.04,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                      actions: [
                                        SizedBox(
                                          width: double.infinity,
                                          height: heightScreen * 0.06,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              cartProvider.clear();
                                              Navigator.pop(context);
                                              Navigator.pushAndRemoveUntil(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      HomeScreen(),
                                                ),
                                                (route) => false,
                                              );
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Color(0xFFFF5900),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                            ),
                                            child: Text(
                                              'Отлично!',
                                              style: TextStyle(
                                                fontSize: widthScreen * 0.04,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                } catch (e) {
                                  if (mounted) Navigator.pop(context);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'Ошибка сохранения заказа: $e',
                                      ),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFFFF5900),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              child: Text(
                                "Заказать",
                                style: TextStyle(
                                  fontSize: widthScreen * 0.05,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "Montserrat",
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),

                          SizedBox(height: heightScreen * 0.03),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void showEditAddressDialog(BuildContext context) {
    final addressController = TextEditingController();
    String? currentCityValue;

    final mediaQuery = MediaQuery.of(context);
    final heightScreen = mediaQuery.size.height;
    final widthScreen = mediaQuery.size.width;

    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((snapshot) {
          if (snapshot.exists) {
            final userData = snapshot.data() as Map<String, dynamic>;
            addressController.text = userData['address'] ?? '';
            currentCityValue = userData['city'];
          }
        });

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: Text('Изменить адрес'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('cities')
                    .orderBy('label')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }

                  if (snapshot.hasError) {
                    return Text('Ошибка: ${snapshot.error}');
                  }

                  final cities = snapshot.data?.docs ?? [];

                  if (currentCityValue == null) {
                    return CircularProgressIndicator();
                  }

                  return Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: widthScreen * 0.04,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                    ),
                    child: DropdownButton<String>(
                      value: currentCityValue,
                      isExpanded: true,
                      hint: Text('Выберите город'),
                      underline: SizedBox(),
                      items: cities.map((doc) {
                        final data = doc.data() as Map<String, dynamic>;
                        return DropdownMenuItem<String>(
                          value: data['value'],
                          child: Text(data['label']),
                        );
                      }).toList(),
                      onChanged: (String? value) {
                        setDialogState(() {
                          currentCityValue = value;
                        });
                      },
                    ),
                  );
                },
              ),

              SizedBox(height: heightScreen * 0.01),

              TextField(
                controller: addressController,
                decoration: InputDecoration(
                  hintText: 'Адрес (улица, дом, квартира)',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Отмена'),
            ),

            ElevatedButton(
              onPressed: () async {
                if (currentCityValue == null || currentCityValue!.isEmpty) {
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

                final cityDoc = await FirebaseFirestore.instance
                    .collection('cities')
                    .where('value', isEqualTo: currentCityValue)
                    .get();

                if (cityDoc.docs.isEmpty) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text('Город не найден')));
                  return;
                }

                final cityData =
                    cityDoc.docs.first.data() as Map<String, dynamic>;
                final cityLabel = cityData['label'] as String;

                try {
                  final userId = FirebaseAuth.instance.currentUser!.uid;
                  await FirebaseFirestore.instance
                      .collection('users')
                      .doc(userId)
                      .update({
                        'city': currentCityValue,
                        'cityLabel': cityLabel,
                        'address': addressController.text.trim(),
                      });

                  if (mounted) Navigator.pop(context);
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Ошибка сохранения: $e')),
                  );
                }
              },
              child: Text('Сохранить'),
            ),
          ],
        ),
      ),
    );
  }

  void showEditNameDialog(BuildContext context) {
    final nameController = TextEditingController();

    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((snapshot) {
          if (snapshot.exists) {
            final userData = snapshot.data() as Map<String, dynamic>;
            nameController.text = userData['name'] ?? '';
          }
        });

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Изменить имя'),
        content: TextField(
          controller: nameController,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Введите имя',
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Отмена'),
          ),
          ElevatedButton(
            onPressed: () async {
              if (nameController.text.trim().isEmpty) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text('Введите имя')));
                return;
              }

              final userId = FirebaseAuth.instance.currentUser!.uid;
              await FirebaseFirestore.instance
                  .collection('users')
                  .doc(userId)
                  .update({'name': nameController.text.trim()});

              if (mounted) Navigator.pop(context);
            },
            child: Text('Сохранить'),
          ),
        ],
      ),
    );
  }

  void showEditPhoneDialog(BuildContext context) {
    final phoneController = TextEditingController();

    final mediaQuery = MediaQuery.of(context);
    final heightScreen = mediaQuery.size.height;
    final widthScreen = mediaQuery.size.width;

    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((snapshot) {
          if (snapshot.exists) {
            final userData = snapshot.data() as Map<String, dynamic>;
            final rawPhone = userData['phone'] ?? '';
            final cleaned = rawPhone.replaceAll(RegExp(r'\D'), '');
            phoneController.text = cleaned;
          }
        });

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Изменить номер'),
        content: TextField(
          controller: phoneController,
          decoration: InputDecoration(
            labelText: 'Номер телефона',
            border: OutlineInputBorder(),
            hintText: '89991234567 или 79991234567',
            counterText: '',
          ),
          keyboardType: TextInputType.number,
          maxLength: 11,
          buildCounter:
              (
                context, {
                required currentLength,
                required maxLength,
                required isFocused,
              }) => null,
          onChanged: (value) {
            final cleaned = value.replaceAll(RegExp(r'\D'), '');

            if (cleaned != value) {
              phoneController.text = cleaned;
              phoneController.selection = TextSelection.collapsed(
                offset: cleaned.length,
              );
            }
          },
        ),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Отмена'),
          ),
          ElevatedButton(
            onPressed: () async {
              final digits = phoneController.text.replaceAll(RegExp(r'\D'), '');

              if (digits.length != 11) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Введите 11 цифр (7 или 8 + 10 цифр)'),
                  ),
                );
                return;
              }

              final formattedPhone = formatPhone(digits);

              if (formattedPhone.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Неверный формат номера')),
                );
                return;
              }

              final userId = FirebaseAuth.instance.currentUser!.uid;
              await FirebaseFirestore.instance
                  .collection('users')
                  .doc(userId)
                  .update({'phone': formattedPhone, 'phoneRaw': digits});

              if (mounted) Navigator.pop(context);
            },
            child: Text('Сохранить'),
          ),
        ],
      ),
    );
  }

  String formatPhone(String raw) {
    final cleaned = raw.replaceAll(RegExp(r'\D'), '');

    String normalized = cleaned;
    if (normalized.startsWith('8') && normalized.length == 11) {
      normalized = '7' + normalized.substring(1);
    }

    if (normalized.length != 11) return '';

    return '+7 (${normalized.substring(1, 4)}) ${normalized.substring(4, 7)}-${normalized.substring(7, 9)}-${normalized.substring(9, 11)}';
  }
}
