import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:iconsax/iconsax.dart';
import 'package:v1douvery/NAV/mobiles/centerSearchNav.dart';
import 'package:v1douvery/common/widgets/IconButton.dart';
import 'package:v1douvery/common/widgets/iconCart.dart';
import 'package:v1douvery/constantes/global_variables.dart';

class AppBarIcons extends StatelessWidget {
  const AppBarIcons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      title: Padding(
        padding: const EdgeInsets.only(top: 25.0, right: 40),
        child: Container(
          alignment: Alignment.center,
          width: 150,
          height: 100,
          child: CachedNetworkImage(
            imageUrl:
                'https://res.cloudinary.com/douvery/image/upload/v1659297990/LOGO/of4ya7v8cmrg0mg8us0c.png',
          ),
        ),
      ),
      actions: [
        CustomnIconsButton(
          icon: Icon(Iconsax.user),
          onPressed: () {},
        ),
        IconCart()
      ],
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(15),
        child: CenterSearchNav(),
      ),
      backgroundColor: GlobalVariables.appBarbackgroundColor,
    );
  }
}
