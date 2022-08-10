import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:v1douvery/common/widgets/IconButton.dart';
import 'package:v1douvery/common/widgets/iconCart.dart';
import 'package:v1douvery/constantes/global_variables.dart';
import 'package:v1douvery/features/search/vista/search_screen.dart';

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
                child: GestureDetector(
                  onTap: () => Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => SearchPage()),
                      (r) => true),
                  child: Container(
                    height: 55,
                    width: MediaQuery.of(context).size.width / 1.4,
                    color: Colors.transparent,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: const IgnorePointer(
                          child: TextField(
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.fromLTRB(8, 5, 8, 0),
                              hintText: 'Busca tu articulo ...',
                              hintStyle: TextStyle(color: Colors.grey),
                              prefixIcon: Icon(
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
              ),
            ],
          ),
          CustomnIconsButton(
            icon: Icon(Iconsax.user, color: Colors.white),
            onPressed: () {},
          ),
          IconCart()
        ],
      ),
    );
  }
}
