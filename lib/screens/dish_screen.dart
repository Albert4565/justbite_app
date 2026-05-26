import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'basket_screen.dart';
import '../providers/cart_provider.dart';
import 'package:provider/provider.dart';

class DishScreen extends StatefulWidget {
  final String categoryId;
  final String categoryName;

  const DishScreen({
    super.key,
    required this.categoryId,
    required this.categoryName,
  });

  @override
  State<DishScreen> createState() => _DishScreenState();
}

class _DishScreenState extends State<DishScreen> {
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
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFFFF5900)),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Container(
          height: heightScreen * 0.05,
          decoration: BoxDecoration(
            color: const Color(0xFFECECEC),
            borderRadius: BorderRadius.circular(15),
          ),
          child: TextField(
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF666666),
              fontFamily: 'Montserrat',
              fontSize: widthScreen * 0.045,
            ),
            decoration: InputDecoration(
              hintText: "Найти блюда",
              hintStyle: TextStyle(
                color: const Color(0xFFC9C9C9),
                fontFamily: "Montserrat",
                fontWeight: FontWeight.w500,
                fontSize: widthScreen * 0.045,
              ),
              prefixIcon: Icon(
                Icons.search,
                color: const Color(0xFFC9C9C9),
                size: widthScreen * 0.06,
              ),
              border: InputBorder.none,
              filled: true,
              fillColor: Colors.transparent,
              contentPadding: EdgeInsets.symmetric(
                horizontal: widthScreen * 0.04,
                vertical: heightScreen * 0.01,
              ),
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart_outlined, color: Color(0xFFFF5900)),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const BasketScreen()),
              );
            },
          ),
        ],
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              vertical: heightScreen * 0.02,
              horizontal: widthScreen * 0.04,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.categoryName,
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.w700,
                    fontSize: widthScreen * 0.08,
                  ),
                ),

                SizedBox(height: heightScreen * 0.02),

                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('dishes')
                      .where('category', isEqualTo: widget.categoryId)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: Color(0xFFFF5900),
                        ),
                      );
                    }

                    if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          'Ошибка: ${snapshot.error}',
                          style: TextStyle(color: Colors.red),
                        ),
                      );
                    }

                    final dishes = snapshot.data!.docs;

                    if (dishes.isEmpty) {
                      return Center(
                        child: Text(
                          'Нет блюд в этой категории',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: widthScreen * 0.045,
                          ),
                        ),
                      );
                    }

                    return GridView(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.65,
                        crossAxisSpacing: widthScreen * 0.03,
                        mainAxisSpacing: heightScreen * 0.02,
                      ),
                      children: dishes.map((dishDoc) {
                        final dish = dishDoc.data() as Map<String, dynamic>;
                        final dishId = dishDoc.id;
                        final name = dish['name'] ?? 'Блюдо';
                        final weight = dish['weight'] ?? 0;
                        final price = dish['price'] ?? 0;
                        final image = dish['image'] ?? '';

                        return GestureDetector(
                          onTap: () {},
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color(0xFFEEEEEE),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: Color(0xFFC9C9C9),
                                width: 2,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(16),
                                      ),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(16),
                                      ),
                                      child: Image.network(
                                        image,
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                        height: double.infinity,
                                      ),
                                    ),
                                  ),
                                ),

                                Expanded(
                                  flex: 2,
                                  child: Padding(
                                    padding: EdgeInsets.all(12),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                name,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontFamily: "Montserrat",
                                                  fontSize: widthScreen * 0.035,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),

                                            Text(
                                              '$weight г.',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontFamily: "Montserrat",
                                                fontWeight: FontWeight.w500,
                                                fontSize: widthScreen * 0.035,
                                              ),
                                            ),
                                          ],
                                        ),

                                        Spacer(),

                                        SizedBox(height: heightScreen * 0.008),

                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              '$price ₽',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w700,
                                                fontFamily: "Montserrat",
                                                fontSize: widthScreen * 0.045,
                                              ),
                                            ),

                                            Container(
                                              width: widthScreen * 0.15,
                                              height: heightScreen * 0.04,
                                              decoration: BoxDecoration(
                                                color: Color(0xFFFF5900),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: IconButton(
                                                icon: Icon(
                                                  Icons.add,
                                                  color: Colors.black,
                                                  size: widthScreen * 0.05,
                                                ),
                                                onPressed: () {
                                                  final cartProvider =
                                                      Provider.of<CartProvider>(
                                                        context,
                                                        listen: false,
                                                      );
                                                  cartProvider.addItem(
                                                    dishId,
                                                    name,
                                                    price.toDouble(),
                                                    image,
                                                  );

                                                  ScaffoldMessenger.of(
                                                    context,
                                                  ).showSnackBar(
                                                    SnackBar(
                                                      content: Text(
                                                        'Блюдо "$name" добавлено в корзину',
                                                      ),
                                                      duration: Duration(
                                                        seconds: 1,
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
