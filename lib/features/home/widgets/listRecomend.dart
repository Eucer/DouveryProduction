import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:v1douvery/common/widgets/header_bold.dart';
import 'package:v1douvery/common/widgets/header_text.dart';
import 'package:v1douvery/common/widgets/loader.dart';
import 'package:v1douvery/common/widgets/stars.dart';
import 'package:v1douvery/constantes/global_variables.dart';
import 'package:v1douvery/features/cart/services/cardServices.dart';
import 'package:v1douvery/features/home/services/homeServices.dart';
import 'package:v1douvery/features/pruductDetails/screens/productDetailsScrenn.dart';
import 'package:v1douvery/features/pruductDetails/services/pruductDetailsServices.dart';
import 'package:v1douvery/main.dart';
import 'package:v1douvery/models/product.dart';
import 'package:v1douvery/provider/user_provider.dart';

class RecomendProduct extends StatefulWidget {
  const RecomendProduct({
    Key? key,
  }) : super(key: key);

  @override
  State<RecomendProduct> createState() => _RecomendProductState();
}

class _RecomendProductState extends State<RecomendProduct> {
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
      category: 'Electronics',
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return productList == null
        ? const Loader()
        : Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              color: GlobalVariables.backgroundColor,
              height: 390,
              width: double.infinity,
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: productList!.length,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: ((context, index) {
                    final product = productList![index];
                    double totalRating = 0;
                    for (int i = 0; i < product.rating!.length; i++) {
                      totalRating += product.rating![i].rating;
                    }
                    double avgRating = 0;
                    if (totalRating != 0) {
                      avgRating = totalRating / product.rating!.length;
                    }
                    return product == null
                        ? const Loader()
                        : Container(
                            child: Column(
                              children: [
                                GestureDetector(
                                  onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ProductDetailsScreen(
                                        product: product,
                                      ),
                                    ),
                                  ),
                                  child: Container(
                                    margin: EdgeInsets.only(
                                        top: 0, right: 8, bottom: 0, left: 0),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10.0, horizontal: 3.0),
                                    child: Row(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: CachedNetworkImage(
                                              imageUrl: product.images[0],
                                              width: 100,
                                              height: 100,
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding:
                                              const EdgeInsets.only(left: 10.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: 200,
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 5.0),
                                                child: headerText(
                                                    texto: product.name,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 12.0),
                                              ),
                                              Container(
                                                width: 200,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    Stars(rating: avgRating),
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50),
                                                        color: const Color
                                                                .fromARGB(
                                                            255, 4, 161, 17),
                                                      ),
                                                      alignment:
                                                          Alignment.center,
                                                      width: 80.0,
                                                      height: 20.0,
                                                      child: Text(
                                                        'You',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Container(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    margin: EdgeInsets.only(
                                                        bottom: 15.0),
                                                    child: Text(
                                                      'Envio Gratis',
                                                      style: GoogleFonts.roboto(
                                                        color: Color.fromARGB(
                                                            255, 4, 161, 17),
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        letterSpacing: 1,
                                                        fontSize: 10.0,
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 7.0),
                                                    child: Text(
                                                      r'$' +
                                                          product.price
                                                              .toString(),
                                                      style: GoogleFonts.roboto(
                                                        color:
                                                            Color(0xff1C2833),
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        letterSpacing: 0.4,
                                                        fontSize: 15.0,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ) // ClipRRect
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                  })),
            ),
          );
  }
}
