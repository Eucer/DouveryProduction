import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:v1douvery/common/widgets/IconButton.dart';
import 'package:v1douvery/common/widgets/iconCart.dart';
import 'package:v1douvery/constantes/global_variables.dart';
import 'package:v1douvery/features/search/vista/search_screen.dart';
import 'package:v1douvery/features/search/widgets/searchignClient.dart';
import 'package:v1douvery/provider/user_provider.dart';

class Web_CenterSearchNav extends StatelessWidget {
  const Web_CenterSearchNav({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SearchStactic();
  }
}

class SearchStactic extends StatelessWidget {
  const SearchStactic({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;

    void navigateToSearchingScreen(String query) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SearchingPage(
                  searchQuery: query,
                )),
      );
    }

    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.topRight,
            width: MediaQuery.of(context).size.width / 11.5,
            height: 55,
            child: CachedNetworkImage(
              alignment: Alignment.centerRight,
              imageUrl:
                  'https://res.cloudinary.com/douvery/image/upload/v1659297990/LOGO/of4ya7v8cmrg0mg8us0c.png',
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                child: Container(
                  height: 55,
                  width: MediaQuery.of(context).size.width / 1.8,
                  color: GlobalVariables.appBarbackgroundColor,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: Material(
                        child: TextFormField(
                          onFieldSubmitted: navigateToSearchingScreen,
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Color(0xffecf0f1),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.fromLTRB(8, 5, 8, 0),
                            hintText: '    Busca tu articulo ...',
                            hintStyle: TextStyle(color: Colors.grey),
                            suffixIcon: Icon(
                              Icons.search,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          IconCart(),
          Row(
            children: [
              CustomnIconsButton(
                icon: Icon(Iconsax.user, color: Colors.white),
                onPressed: () {},
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 12),
                    alignment: Alignment.topLeft,
                    child: Text(
                      '¡Hola!',
                      style: TextStyle(color: Color(0xffecf0f1), fontSize: 14),
                    ),
                  ),
                  Container(
                    child: Text(
                      user.name,
                      style: TextStyle(color: Color(0xffecf0f1), fontSize: 14),
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}