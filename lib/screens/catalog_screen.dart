import 'package:flutter/material.dart';

class CatalogScreen extends StatelessWidget {
  const CatalogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final widthScreen = mediaQuery.size.width;
    final heightScreen = mediaQuery.size.height;

    final List<Map<String, String>> categories = [
      {'name': 'Напитки', 'image': 'assets/images/drinks.png'},
      {'name': 'Завтраки', 'image': 'assets/images/breakfast.png'},
      {'name': 'Пицца', 'image': 'assets/images/pizza.png'},
      {'name': 'Салаты', 'image': 'assets/images/salads.png'},
      {'name': 'Бургеры', 'image': 'assets/images/burgers.png'},
      {'name': 'Супы', 'image': 'assets/images/soups.png'},
      {'name': 'Десерты', 'image': 'assets/images/desserts.png'},
    ];

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
                      style: TextStyle(
                        color: Colors.black,
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
                        prefixIcon: Icon(Icons.search, color: Color(0xFFC9C9C9)),
                        border: InputBorder.none,
                        prefixIconConstraints: BoxConstraints(
                          minHeight: heightScreen * 0.01,
                          minWidth: widthScreen * 0.1,
                        ),
                        contentPadding: EdgeInsets.only(
                          right: widthScreen * 0.05,
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: heightScreen * 0.02),

                ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: widthScreen * 0.02),
                  scrollDirection: Axis.vertical,
                  itemCount: categories.length,
                  separatorBuilder: (context, index) =>
                      SizedBox(height: heightScreen * 0.01),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {},
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
                                child: Image.asset(
                                  categories[index]['image']!,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: double.infinity,
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
                                      categories[index]['name']!,
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
