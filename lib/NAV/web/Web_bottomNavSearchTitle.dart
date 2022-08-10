import 'package:flutter/material.dart';
import 'package:v1douvery/NAV/centerSearchNav.dart';

import 'package:v1douvery/constantes/global_variables.dart';
import 'package:v1douvery/features/home/screens/categoryDealsScreen.dart';

class BottomNavSearchTitle extends StatelessWidget {
  const BottomNavSearchTitle({Key? key}) : super(key: key);

  void navigateToCategoryPage(BuildContext context, String category) {
    MaterialPageRoute(
      builder: (context) => CategoryDealsScreen(
        category: category,
      ),
      settings: RouteSettings(
        arguments: category,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CenterSearchNav(),
        NavCategory(),
      ],
    );
  }
}

class NavCategory extends StatelessWidget {
  const NavCategory({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      width: MediaQuery.of(context).size.width,
      child: Container(
        padding: EdgeInsets.only(right: 0),
        color: GlobalVariables.secondaryColor,
        child: ListView.builder(
          itemCount: GlobalVariables.categoryTitle.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CategoryDealsScreen(
                    category: GlobalVariables.categoryTitle[index]['title']!,
                  ),
                  settings: RouteSettings(
                    arguments: GlobalVariables.categoryTitle[index]['title']!,
                  ),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 30,
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(
                      left: 15,
                    ),
                    child: Text(
                      GlobalVariables.categoryTitle[index]['title']!,
                      style: TextStyle(color: Colors.white, fontSize: 13),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
