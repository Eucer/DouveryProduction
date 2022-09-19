import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:swipe_refresh/swipe_refresh.dart';
import 'package:v1douvery/common/widgets/header_text.dart';
import 'package:v1douvery/common/widgets/loader.dart';
import 'package:v1douvery/constantes/global_variables.dart';
import 'package:v1douvery/features/account/widgets/ordenesUser.dart';
import 'package:v1douvery/features/admin/screens/adminScreens.dart';
import 'package:v1douvery/features/admin/servicios/adminServices.dart';
import 'package:v1douvery/features/orderDetails/screens/orderDetails.dart';
import 'package:v1douvery/models/order.dart';
import 'package:v1douvery/provider/ordersProviders.dart';
import 'package:v1douvery/provider/theme.dart';

import '../../Drawer/screen/mobiles_drawerScreen.dart';
import '../../search/widgets/searchignClient.dart';

class OrdersScreen extends StatefulWidget {
  OrdersScreen({Key? key}) : super(key: key);

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  List<Order>? orders;
  final AdminServices adminServices = AdminServices();
  @override
  void initState() {
    super.initState();
    fecthOrders();
  }

  void fecthOrders() async {
    orders = await adminServices.fetchAllOrders(context);
    setState(() {});
  }

  final _controller = StreamController<SwipeRefreshState>.broadcast();
  Stream<SwipeRefreshState> get _stream => _controller.stream;

  @override
  Widget build(BuildContext context) {
    final orderss = context.watch<OrderProvider>().order;
    final currentTheme = Provider.of<ThemeProvider>(context);
    orderss.products.toList();

    void _reset() {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          transitionDuration: Duration.zero,
          pageBuilder: (_, __, ___) => OrdersScreen(),
        ),
      );
    }

    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(115),
          child: Column(
            children: [
              AppBar(
                backgroundColor: Color(
                  0XFF0D3B66,
                ),
                flexibleSpace: Container(),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      child: Row(
                        children: [
                          Text(
                            'Ordenes',
                            style: GoogleFonts.lato(
                              color: Color(0xffFCFCFC),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                toolbarHeight: 60,
              ),
              Container(
                child: Column(children: [
                  SizedBox(
                    child: Container(
                      height: 55,
                      width: double.infinity,
                      color: Color(
                        0XFF0D3B66,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: Material(
                            child: TextFormField(
                              cursorColor: Colors.grey,
                              autofocus: true,
                              style: TextStyle(
                                color: currentTheme.isDarkTheme()
                                    ? GlobalVariables.text1darkbackgroundColor
                                    : GlobalVariables.text1WhithegroundColor,
                              ),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: currentTheme.isDarkTheme()
                                    ? GlobalVariables.darkbackgroundColor
                                    : GlobalVariables.backgroundColor,
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.fromLTRB(8, 5, 8, 0),
                                hintText: 'Busca tu articulo ...',
                                hintStyle: TextStyle(color: Colors.grey),
                                prefixIcon: Icon(
                                  Icons.search,
                                  size: 20,
                                  color: currentTheme.isDarkTheme()
                                      ? Colors.grey
                                      : Colors.grey,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ]),
              )
            ],
          ),
        ),
        drawer: DrawerScreen(),
        body: SwipeRefresh.cupertino(
            refreshTriggerPullDistance: 20,
            refreshIndicatorExtent: 20,
            stateStream: _stream,
            onRefresh: _reset,
            children: [
              Container(
                color: currentTheme.isDarkTheme()
                    ? GlobalVariables.darkOFbackgroundColor
                    : GlobalVariables.greyBackgroundCOlor,
                child: orders == null
                    ? Loader()
                    : ListView.builder(
                        itemCount: orders!.length,
                        itemBuilder: (context, index) {
                          final orderData = orders![index];

                          return GestureDetector(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => OrderDetailScreen(
                                  order: orders![index],
                                ),
                                settings: RouteSettings(
                                  arguments: orders![index],
                                ),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Container(
                                padding: const EdgeInsets.only(top: 5.0),
                                width: MediaQuery.of(context).size.width,
                                height: 150,
                                decoration: BoxDecoration(
                                    color: currentTheme.isDarkTheme()
                                        ? GlobalVariables.darkbackgroundColor
                                        : GlobalVariables.backgroundColor,
                                    border: Border(
                                        top: BorderSide(
                                            width: 1,
                                            color: currentTheme.isDarkTheme()
                                                ? GlobalVariables
                                                    .borderColorsDarklv10
                                                : GlobalVariables
                                                    .borderColorsWhithelv10))),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      color: currentTheme.isDarkTheme()
                                          ? GlobalVariables.darkbackgroundColor
                                          : GlobalVariables.backgroundColor,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          ImagesOrdersList(
                                              orderData: orderData,
                                              currentTheme: currentTheme),
                                          Container(
                                            alignment: Alignment.center,
                                            padding: const EdgeInsets.only(
                                                left: 5.0, top: 5),
                                            child: orderData.status == 4
                                                ? Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 2.0),
                                                    child: Container(
                                                      width: 150,
                                                      height: 15,
                                                      child: Text(
                                                        'Orden Completada',
                                                        style: TextStyle(
                                                          fontSize: 11,
                                                          color: currentTheme
                                                                  .isDarkTheme()
                                                              ? GlobalVariables
                                                                  .text1darkbackgroundColor
                                                              : GlobalVariables
                                                                  .text1WhithegroundColor,
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                : Text(
                                                    'Orden Pendiente',
                                                    style: TextStyle(
                                                      fontSize: 11,
                                                      color: currentTheme
                                                              .isDarkTheme()
                                                          ? GlobalVariables
                                                              .text1darkbackgroundColor
                                                          : GlobalVariables
                                                              .text1WhithegroundColor,
                                                    ),
                                                  ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 0.0),
                                            child: Container(
                                              child: Row(
                                                children: [
                                                  Text(
                                                    'Num. Orden  ',
                                                    style: TextStyle(
                                                      fontSize: 11,
                                                      color: currentTheme
                                                              .isDarkTheme()
                                                          ? GlobalVariables
                                                              .text1darkbackgroundColor
                                                          : GlobalVariables
                                                              .text1WhithegroundColor,
                                                    ),
                                                  ),
                                                  Text(
                                                    orderData.orderedAt
                                                        .toString(),
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      color: currentTheme
                                                              .isDarkTheme()
                                                          ? GlobalVariables
                                                              .text1darkbackgroundColor
                                                          : GlobalVariables
                                                              .text2WhithegroundColor,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 0.0),
                                            child: Container(
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Precio. Orden  ',
                                                    style: TextStyle(
                                                      fontSize: 11,
                                                      color: currentTheme
                                                              .isDarkTheme()
                                                          ? GlobalVariables
                                                              .text1darkbackgroundColor
                                                          : GlobalVariables
                                                              .text1WhithegroundColor,
                                                    ),
                                                  ),
                                                  Text(
                                                    r'$' +
                                                        orderData.totalPrice
                                                            .toString(),
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      color: currentTheme
                                                              .isDarkTheme()
                                                          ? GlobalVariables
                                                              .text1darkbackgroundColor
                                                          : GlobalVariables
                                                              .text2WhithegroundColor,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 0.0),
                                            child: Container(
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Address. Orden  ',
                                                    style: TextStyle(
                                                      fontSize: 11,
                                                      color: currentTheme
                                                              .isDarkTheme()
                                                          ? GlobalVariables
                                                              .text1darkbackgroundColor
                                                          : GlobalVariables
                                                              .text1WhithegroundColor,
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 200,
                                                    child: Text(
                                                      orderData.address
                                                          .toString(),
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        color: currentTheme
                                                                .isDarkTheme()
                                                            ? GlobalVariables
                                                                .text1darkbackgroundColor
                                                            : GlobalVariables
                                                                .text2WhithegroundColor,
                                                      ),
                                                      textAlign:
                                                          TextAlign.start,
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 8,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 0.0),
                                            child: Container(
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Status. Orden  ',
                                                    style: TextStyle(
                                                      fontSize: 11,
                                                      color: currentTheme
                                                              .isDarkTheme()
                                                          ? GlobalVariables
                                                              .text1darkbackgroundColor
                                                          : GlobalVariables
                                                              .text1WhithegroundColor,
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 200,
                                                    child: Text(
                                                      orderData.status
                                                          .toString(),
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        color: currentTheme
                                                                .isDarkTheme()
                                                            ? GlobalVariables
                                                                .text1darkbackgroundColor
                                                            : GlobalVariables
                                                                .text2WhithegroundColor,
                                                      ),
                                                      textAlign:
                                                          TextAlign.start,
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 0.0),
                                            child: Container(
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Product. Orden  ',
                                                    style: TextStyle(
                                                      fontSize: 11,
                                                      color: currentTheme
                                                              .isDarkTheme()
                                                          ? GlobalVariables
                                                              .text1darkbackgroundColor
                                                          : GlobalVariables
                                                              .text1WhithegroundColor,
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 200,
                                                    child: Text(
                                                      orderData.products.length
                                                          .toString(),
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        color: currentTheme
                                                                .isDarkTheme()
                                                            ? GlobalVariables
                                                                .text1darkbackgroundColor
                                                            : GlobalVariables
                                                                .text2WhithegroundColor,
                                                      ),
                                                      textAlign:
                                                          TextAlign.start,
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ]));
  }
}

class ImagesOrdersList extends StatelessWidget {
  const ImagesOrdersList({
    Key? key,
    required this.orderData,
    required this.currentTheme,
  }) : super(key: key);

  final Order orderData;
  final ThemeProvider currentTheme;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        orderData.products.length != 1
            ? Container(
                width: 150,
                decoration: BoxDecoration(
                  color: currentTheme.isDarkTheme()
                      ? GlobalVariables.darkbackgroundColor
                      : GlobalVariables.backgroundColor,
                ),
                child: GestureDetector(
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 0.0, top: 0.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(0),
                          child: CachedNetworkImage(
                            imageUrl: orderData.products[0].images[0],
                            width: 100,
                            height: 110.0,
                            fit: BoxFit.scaleDown,
                          ),
                        ),
                      ),
                      Container(
                        width: 50,
                        alignment: Alignment.center,
                        child: Text('+'),
                      )
                    ],
                  ),
                ),
              )
            : Container(
                color: currentTheme.isDarkTheme()
                    ? GlobalVariables.darkbackgroundColor
                    : GlobalVariables.backgroundColor,
                child: GestureDetector(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 0.0, top: 0.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(0),
                      child: CachedNetworkImage(
                        imageUrl: orderData.products[0].images[0],
                        width: 150,
                        height: 110.0,
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                  ),
                ),
              )
      ],
    );
  }
}

class OrderSearch extends StatefulWidget {
  const OrderSearch({
    Key? key,
  }) : super(key: key);

  @override
  State<OrderSearch> createState() => _OrderSearchState();
}

class _OrderSearchState extends State<OrderSearch> {
  void navigateToSearchingScreen(String query) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => SearchingPage(
                searchQuery: query,
              )),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentTheme = Provider.of<ThemeProvider>(context);
    return Container(
      child: Column(children: [
        SizedBox(
          child: Container(
            height: 55,
            width: double.infinity,
            color: Color(
              0XFF0D3B66,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Material(
                  child: TextFormField(
                    cursorColor: Colors.grey,
                    autofocus: true,
                    onFieldSubmitted: navigateToSearchingScreen,
                    style: TextStyle(
                      color: currentTheme.isDarkTheme()
                          ? GlobalVariables.text1darkbackgroundColor
                          : GlobalVariables.text1WhithegroundColor,
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: currentTheme.isDarkTheme()
                          ? GlobalVariables.darkbackgroundColor
                          : GlobalVariables.backgroundColor,
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.fromLTRB(8, 5, 8, 0),
                      hintText: 'Busca tu articulo ...',
                      hintStyle: TextStyle(color: Colors.grey),
                      prefixIcon: Icon(
                        Icons.search,
                        size: 20,
                        color: currentTheme.isDarkTheme()
                            ? Colors.grey
                            : Colors.grey,
                      ),
                    ),
                    onChanged: searchOrders,
                  ),
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }

  void searchOrders(String query) {}
}
