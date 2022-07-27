import 'package:animate_do/animate_do.dart';
import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:v1douvery/NAV/bottomNavSearchTitle.dart';
import 'package:v1douvery/NAV/centerSearchNav.dart';
import 'package:v1douvery/common/widgets/header_double.dart';
import 'package:v1douvery/common/widgets/loader.dart';
import 'package:v1douvery/constantes/global_variables.dart';
import 'package:v1douvery/features/account/widgets/ordenesUser.dart';
import 'package:v1douvery/features/home/screens/home_screens.dart';
import 'package:v1douvery/features/home/services/homeServices.dart';
import 'package:v1douvery/features/pruductDetails/screens/productDetailsScrenn.dart';
import 'package:v1douvery/models/product.dart';
import 'package:v1douvery/provider/user_provider.dart';

class CategoryDealsScreen extends StatefulWidget {
  static const String routeName = '/category-deals';
  final String category;
  const CategoryDealsScreen({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  State<CategoryDealsScreen> createState() => _CategoryDealsScreenState();
}

class _CategoryDealsScreenState extends State<CategoryDealsScreen> {
  List<Product>? productList;
  final HomeServices homeServices = HomeServices();

  @override
  void initState() {
    super.initState();
    fetchCategoryProducts();
  }

  fetchCategoryProducts() async {
    productList = await homeServices.fetchCategoryProducts(
      context: context,
      category: widget.category,
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final userCartLen = context.watch<UserProvider>().user.cart.length;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(105),
        child: Center(
          child: AppBar(
            elevation: 0,
            title: Row(
              children: [
                Text(
                  'Douvery ',
                  style: GoogleFonts.lato(
                      color: Color(0xffFCFCFC), fontWeight: FontWeight.bold),
                ),
                Icon(Icons.wifi_2_bar_sharp),
              ],
            ),
            actions: [
              IconButton(
                icon: const Icon(IconlyLight.addUser),
                onPressed: () {},
              ),
              Badge(
                toAnimate: false,
                position: BadgePosition.topEnd(top: 2, end: 3),
                animationDuration: Duration(milliseconds: 300),
                badgeColor: Color(0xffe84118),
                badgeContent: Text(
                  userCartLen.toString(),
                  style: TextStyle(color: Colors.white, fontSize: 13),
                ),
                child: IconButton(
                  icon: const Icon(IconlyLight.buy),
                  onPressed: () {},
                ),
              ),
            ],
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(15),
              child: CenterSearchNav(),
            ),
            backgroundColor: GlobalVariables.appBarbackgroundColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xff05595B)),
                    alignment: Alignment.center,
                    child: const Text(
                      'Puede que te interesen',
                      style: TextStyle(
                          fontSize: 17,
                          color: GlobalVariables.colorTextWhiteLight),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 5),
                        color: Colors.white,
                        child: headerDoubleText(
                          textHeader: '${widget.category}',
                          textAction: 'Ver mas',
                        ),
                      ),
                      productList == null
                          ? const Loader()
                          : CategoriNamed(productList: productList),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CategoriNamed extends StatelessWidget {
  const CategoriNamed({
    Key? key,
    required this.productList,
  }) : super(key: key);

  final List<Product>? productList;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: GlobalVariables.backgroundColor,
      child: SizedBox(
        height: 200,
        width: double.infinity,
        child: ListView.builder(
          itemCount: productList!.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            final product = productList![index];
            return GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailsScreen(
                    product: product,
                  ),
                ),
              ),
              child: Container(
                width: 150,
                decoration: const BoxDecoration(
                  border: Border(
                      left: BorderSide(
                    color: GlobalVariables.colorTextGreylv10,
                    width: 1,
                  )),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        border: Border(
                            top: BorderSide(
                          color: GlobalVariables.colorTextGreylv10,
                          width: 1,
                        )),
                        color: Colors.white,
                      ),
                      width: 200,
                      height: 120,
                      child: productList == null
                          ? const Loader()
                          : SingleProduct(
                              imagen: product.images[0],
                            ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 10),
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 2),
                            alignment: Alignment.center,
                            width: double.infinity,
                            color: Colors.white,
                            child: Text(
                              product.name,
                              style: const TextStyle(
                                color: Color(0xff1C2833),
                                fontWeight: FontWeight.w400,
                                letterSpacing: 0.4,
                                fontSize: 12.0,
                              ),
                              textAlign: TextAlign.start,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(bottom: 2),
                            width: double.infinity,
                            color: Colors.white,
                            child: Text(
                              product.marca,
                              style: const TextStyle(
                                color: Color(0xff1C2833),
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0.4,
                                fontSize: 11.0,
                              ),
                              textAlign: TextAlign.start,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              '\$${product.price}',
                              style: const TextStyle(
                                color: GlobalVariables.colorPriceSecond,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.5,
                                fontSize: 14.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
