import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:v1douvery/NAV/mobiles/centerSearchNav.dart';
import 'package:v1douvery/common/widgets/IconButton.dart';
import 'package:v1douvery/common/widgets/iconCart.dart';
import 'package:v1douvery/constantes/global_variables.dart';
import 'package:v1douvery/models/themePreference.dart';
import 'package:v1douvery/provider/theme.dart';

class AppBarIcons extends StatelessWidget {
  const AppBarIcons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentTheme = Provider.of<ThemeProvider>(context);
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
                'https://res.cloudinary.com/douvery/image/upload/v1661701638/LOGO/iizi2nvlhon5wwzdph3i.png',
          ),
        ),
      ),
      actions: [
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Icon(Icons.wb_sunny,
                  color: currentTheme.isDarkTheme()
                      ? Color.fromARGB(104, 5, 5, 5)
                      : Colors.white),
              Switch(
                  value: currentTheme.isDarkTheme(),
                  onChanged: (value) {
                    String newTheme =
                        value ? ThemePreference.DARK : ThemePreference.LIGHT;
                    currentTheme.setTheme = newTheme;
                  }),
              Icon(Icons.brightness_2,
                  color: currentTheme.isDarkTheme()
                      ? Colors.white
                      : Color.fromARGB(104, 5, 5, 5))
            ],
          ),
        ),
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
