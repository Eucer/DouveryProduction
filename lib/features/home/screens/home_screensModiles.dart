import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:swipe_refresh/swipe_refresh.dart';
import 'package:v1douvery/NAV/appBarIcons.dart';
import 'package:v1douvery/NAV/bottomNavSearchTitle.dart';
import 'package:v1douvery/NAV/centerSearchNav.dart';
import 'package:v1douvery/NAV/topTitleButtom.dart';
import 'package:v1douvery/common/widgets/bottom_bar.dart';
import 'package:v1douvery/common/widgets/custon_button.dart';
import 'package:v1douvery/common/widgets/iconCart.dart';
import 'package:v1douvery/constantes/global_variables.dart';
import 'package:v1douvery/features/home/services/homeServices.dart';
import 'package:v1douvery/features/home/widgets/carAll.dart';
import 'package:v1douvery/features/home/widgets/carAnimations.dart';
import 'package:v1douvery/features/home/widgets/carBrands.dart';
import 'package:v1douvery/features/home/widgets/carCrypyoPromo.dart';
import 'package:v1douvery/features/home/widgets/carKits.dart';

import 'package:v1douvery/features/home/widgets/listMarcaSelect.dart';
import 'package:v1douvery/features/home/widgets/listNew.dart';
import 'package:v1douvery/features/home/widgets/banner_widget.dart';
import 'package:v1douvery/features/home/widgets/deal-of-day.dart';
import 'package:v1douvery/features/home/widgets/listDealOfDay.dart';

import 'package:v1douvery/features/home/widgets/listRandom.dart';
import 'package:v1douvery/features/home/widgets/listRecomend.dart';
import 'package:v1douvery/features/home/widgets/testing.dart';
import 'package:v1douvery/models/product.dart';

import 'package:v1douvery/provider/user_provider.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _controller = StreamController<SwipeRefreshState>.broadcast();

  Stream<SwipeRefreshState> get _stream => _controller.stream;
  @override
  Widget build(BuildContext context) {
    void _reset() {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          transitionDuration: Duration.zero,
          pageBuilder: (_, __, ___) => HomeScreen(),
        ),
      );
    }

    return Scaffold(
        backgroundColor: Color(0xffEFEFEF),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(105),
          child: Center(
            child: AppBarIcons(),
          ),
        ),

        //SelectBody
        body: Scrollbar(
          child: SingleChildScrollView(
            child: Column(
              children: [
                NavCategory(),
                BannerWidget(),
                CardsOneWidget(),
                ListDealOfDay(),
                DealOfDay(),
                ListRandom(),
                RecomendProduct(),
                ListMarca(),
                CartCrypto(),
                CarAnimationsTesting(),
                CardBrands(),
                DealOfDay(),
                DealOfDay(),
                DealOfDay(),
              ],
            ),
          ),
        ));
  }
}
