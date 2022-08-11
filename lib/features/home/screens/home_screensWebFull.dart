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
import 'package:v1douvery/NAV/web/Web_appBarIcons.dart';
import 'package:v1douvery/NAV/web/Web_bottomNavSearchTitle.dart';
import 'package:v1douvery/features/home/widgets/web/carouselRandom.dart';
import 'package:v1douvery/features/home/widgets/web/web_banner.dart';

import 'package:v1douvery/models/product.dart';

import 'package:v1douvery/provider/user_provider.dart';

class HomeScreenWebFull extends StatefulWidget {
  static const String routeName = '/home';
  HomeScreenWebFull({Key? key}) : super(key: key);

  @override
  State<HomeScreenWebFull> createState() => _HomeScreenWebFullState();
}

class _HomeScreenWebFullState extends State<HomeScreenWebFull> {
  final _controller = StreamController<SwipeRefreshState>.broadcast();

  Stream<SwipeRefreshState> get _stream => _controller.stream;
  @override
  Widget build(BuildContext context) {
    void _reset() {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          transitionDuration: Duration.zero,
          pageBuilder: (_, __, ___) => HomeScreenWebFull(),
        ),
      );
    }

    return Scaffold(
        backgroundColor: Color(0xffEFEFEF),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(75),
          child: Center(
            child: Web_AppBarIcons(),
          ),
        ),

        //SelectBody
        body: Scrollbar(
          child: SingleChildScrollView(
            child: Column(
              children: [
                WebFull_NavCategory(),
                Web_BannerWidget(),
                Web_CarRandom()
              ],
            ),
          ),
        ));
  }
}
