import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dish_screen.dart';

class CatalogScreen extends StatefulWidget {
  final String? categoryId;

  const CatalogScreen({super.key, this.categoryId});

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  final searchController = TextEditingController();
  String searchQuery = '';

  @override
  void dispose() {
    searchController.dispose();
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
                  "Категории",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    fontFamily: "Montserrat",
                    fontSize: widthScreen * 0.1,
                  ),
                ),

                SizedBox(height: heightScreen * 0.03),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: widthScreen * 0.03),
                  child: Container(
                    height: heightScreen * 0.06,
                    decoration: BoxDecoration(
                      color: Color(0xFFECECEC),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextField(
                      controller: searchController,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Color(0xFF666666),
                        fontWeight: FontWeight.w500,
                        fontFamily: "Montserrat",
                        fontSize: widthScreen * 0.05,
                      ),
                      decoration: InputDecoration(
                        hintText: "Поиск блюд...",
                        hintStyle: TextStyle(
                          color: Color(0xFFC9C9C9),
                          fontFamily: "Montserrat",
                          fontSize: widthScreen * 0.05,
                        ),
                        prefixIcon: Icon(
                          Icons.search,
                          color: Color(0xFFC9C9C9),
                          size: widthScreen * 0.05,
                        ),
                        suffixIcon: searchQuery.isNotEmpty
                            ? IconButton(
                                icon: Icon(
                                  Icons.clear,
                                  color: Color(0xFFC9C9C9),
                                  size: widthScreen * 0.05,
                                ),
                                onPressed: () {
                                  searchController.clear();
                                  setState(() {
                                    searchQuery = '';
                                  });
                                },
                              )
                            : null,
                        border: InputBorder.none,
                        prefixIconConstraints: BoxConstraints(
                          minHeight: heightScreen * 0.01,
                          minWidth: widthScreen * 0.1,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: widthScreen * 0.02,
                          vertical: heightScreen * 0.015,
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          searchQuery = value.toLowerCase().trim();
                        });
                      },
                    ),
                  ),
                ),

                SizedBox(height: heightScreen * 0.02),

                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('categories')
                      .orderBy('sort_order')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(child: CircularProgressIndicator());
                    }

                    if (snapshot.hasError) {
                      return Center(child: Text('Ошибка: ${snapshot.error}'));
                    }

                    final allCategories = snapshot.data!.docs;
                    final categories = allCategories.where((doc) {
                      final data = doc.data() as Map<String, dynamic>;
                      final name = (data['name'] ?? '')
                          .toString()
                          .toLowerCase();
                      return name.contains(searchQuery);
                    }).toList();

                    if (categories.isEmpty) {
                      return Center(
                        child: Text(
                          searchQuery.isNotEmpty
                            ? 'Категории не найдены'
                            : 'Нет категорий',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: widthScreen * 0.045,
                            fontFamily: "Montserrat",
                          ),
                        ),
                      );
                    }

                    return ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.symmetric(
                        horizontal: widthScreen * 0.02,
                      ),
                      scrollDirection: Axis.vertical,
                      itemCount: categories.length,
                      separatorBuilder: (context, index) =>
                          SizedBox(height: heightScreen * 0.01),
                      itemBuilder: (context, index) {
                        final category =
                            categories[index].data() as Map<String, dynamic>;
                        final name = category['name'] ?? 'Категория';
                        final imageUrl = category['image'] ?? '';

                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DishScreen(
                                  categoryId: categories[index].id,
                                  categoryName: name,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            height: heightScreen * 0.09,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: Color(0xFFCACACA)),
                            ),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.horizontal(
                                    left: Radius.circular(16),
                                  ),
                                  child: Container(
                                    width: widthScreen * 0.2,
                                    height: heightScreen * 0.1,
                                    color: Color(0xFFF5F5F5),
                                    child: Image.network(
                                      imageUrl,
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      height: double.infinity,
                                      errorBuilder: (context, error, stackTrace) {
                                        return Container(color: Colors.grey[300]);
                                      },
                                    ),
                                  ),
                                ),

                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: widthScreen * 0.06,
                                    ),
                                    child: Row(
                                      children: [
                                        Text(
                                          name,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'Montserrat',
                                            fontWeight: FontWeight.w700,
                                            fontSize: widthScreen * 0.075,
                                          ),
                                        ),
                                        Spacer(),
                                        Icon(
                                          Icons.navigate_next,
                                          color: Color(0xFFFF5900),
                                          size: widthScreen * 0.075,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
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
