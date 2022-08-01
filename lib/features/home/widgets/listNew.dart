import 'package:animate_do/animate_do.dart';
import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:v1douvery/common/widgets/loader.dart';
import 'package:v1douvery/common/widgets/stars.dart';
import 'package:v1douvery/constantes/global_variables.dart';
import 'package:v1douvery/features/account/widgets/ordenesUser.dart';
import 'package:v1douvery/features/address/screens/addresScreens.dart';
import 'package:v1douvery/features/home/services/homeServices.dart';
import 'package:v1douvery/features/pruductDetails/screens/productDetailsScrenn.dart';
import 'package:v1douvery/features/pruductDetails/services/pruductDetailsServices.dart';
import 'package:v1douvery/models/product.dart';
import 'package:v1douvery/models/ratings.dart';
import 'package:v1douvery/provider/user_provider.dart';

class CardsOneWidget extends StatefulWidget {
  const CardsOneWidget({Key? key}) : super(key: key);

  @override
  State<CardsOneWidget> createState() => _CardsOneWidget();
}

class _CardsOneWidget extends State<CardsOneWidget> {
  double scrollPosition = 0;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 10,
            right: 10,
            top: 5,
            bottom: 10,
          ),
          child: ClipRRect(
            child: Container(
              height: 180,
              color: const Color(0xffC70039),
              width: 85.0,
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 50.0),
                    child: Center(
                      child: Text(
                        'Articulos Nuevos',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Color(0xffe9ebee),
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  const Divider(
                    color: Colors.white,
                    indent: 10,
                    endIndent: 10,
                  ),
                  Container(
                    child: TextButton(
                      onPressed: () {
                        // Respond to button press
                      },
                      child: const Text(
                        'Ver mas',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Color(0xffe9ebee),
                            fontWeight: FontWeight.w900),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SliderCards(),
      ],
    );
  }
}

class SliderCards extends StatefulWidget {
  @override
  State<SliderCards> createState() => _SliderCardsState();
}

class _SliderCardsState extends State<SliderCards> {
  PageController _controller = PageController(
    viewportFraction: 0.4,
  );

  List<Product>? productList;

  final HomeServices homeServices = HomeServices();

  @override
  void initState() {
    super.initState();
    fetchNewProducts();
  }

  fetchNewProducts() async {
    productList = await homeServices.fetchNewProducts(
      context: context,
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) => Padding(
        padding:
            const EdgeInsets.only(left: 100.0, top: 5.0, right: 0, bottom: 0),
        child: CarouselProductToNamedCategory(
          productList: productList,
        ),
      );
}

class CarouselProductToNamedCategory extends StatefulWidget {
  CarouselProductToNamedCategory({
    Key? key,
    required this.productList,
  }) : super(key: key);
  final List<Product>? productList;

  @override
  State<CarouselProductToNamedCategory> createState() =>
      _CarouselProductToNamedCategoryState();
}

class _CarouselProductToNamedCategoryState
    extends State<CarouselProductToNamedCategory> {
  List<Rating>? rating;
  final ProductDetailsServices productDetailsServices =
      ProductDetailsServices();

  @override
  Widget build(BuildContext context) {
    //edit modal
    final userCartLen = context.watch<UserProvider>().user.cart.length;
    return widget.productList == null
        ? const Loader()
        : Container(
            color: GlobalVariables.backgroundColor,
            child: SizedBox(
              height: 180,
              width: double.infinity,
              child: ListView.builder(
                itemCount: widget.productList!.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final product = widget.productList![index];

                  double avgRating = 0;
                  double myRating = 0;
                  double totalRating = 0;
                  @override
                  void initState() {
                    super.initState();
                    double totalRating = 0;
                    for (int i = 0; i < product.rating!.length; i++) {
                      totalRating += product.rating![i].rating;
                      if (product.rating![i].userId ==
                          Provider.of<UserProvider>(context, listen: false)
                              .user
                              .id) {
                        myRating = product.rating![i].rating;
                      }
                    }

                    if (totalRating != 0) {
                      avgRating = totalRating / product.rating!.length;
                    }
                  }

                  void addToCart() {
                    final product = widget.productList![index];
                    productDetailsServices.addToCart(
                      context: context,
                      product: product,
                    );
                  }

                  //* MOballlll ********************************
                  void _modalInteriorFerce(BuildContext context) {
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext bc) {
                        final product = widget.productList![index];
                        return Container(
                          height: 600,
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Scrollbar(
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 1.0, bottom: 1.0),
                                          child: Container(
                                            height: 33,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            color: Colors.white,
                                            child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Row(
                                                    children: [
                                                      CarouselSlider(
                                                        options:
                                                            CarouselOptions(
                                                                height: 400.0),
                                                        items: product.images
                                                            .map((i) {
                                                          return Builder(
                                                            builder:
                                                                (BuildContext
                                                                    context) {
                                                              return Container(
                                                                  width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width,
                                                                  margin: EdgeInsets
                                                                      .symmetric(
                                                                          horizontal:
                                                                              5.0),
                                                                  decoration:
                                                                      BoxDecoration(
                                                                          color:
                                                                              Colors.amber),
                                                                  child: Text(
                                                                    'text $i',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            16.0),
                                                                  ));
                                                            },
                                                          );
                                                        }).toList(),
                                                      ),
                                                      Container(
                                                        width: 130,
                                                        child: Text(
                                                          'Rating no disponible',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.grey,
                                                              fontSize: 13),
                                                          textAlign:
                                                              TextAlign.start,
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ),
                                                      SizedBox(width: 10),
                                                      Text(
                                                        'Precio: ',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black54,
                                                            fontSize: 15),
                                                      ),

                                                      Text(
                                                        '\$${product.price}',
                                                        style: TextStyle(
                                                          color:
                                                              Color(0xff1C2833),
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          letterSpacing: 0.4,
                                                          fontSize: 15.0,
                                                        ),
                                                      ),
                                                      SizedBox(width: 10),
                                                      //
                                                      Text(
                                                        'Envio: ',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black54,
                                                            fontSize: 15),
                                                      ),

                                                      Text(
                                                        'Gratis',
                                                        style: TextStyle(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    4,
                                                                    161,
                                                                    17),
                                                            fontSize: 15),
                                                      ),
                                                    ],
                                                  ),
                                                ]),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 200,
                                          child: CachedNetworkImage(
                                              imageUrl: product.images[0]),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.only(
                                              top: 15, left: 10),
                                          width: double.infinity,
                                          height: 40,
                                          child: Text(
                                            product.name,
                                            style: TextStyle(
                                                color: Color(0xff1C2833),
                                                fontWeight: FontWeight.w400,
                                                letterSpacing: 0.4,
                                                fontSize: 18.0),
                                          ),
                                        ),
                                        Container(
                                          height: 30,
                                          alignment: Alignment.centerLeft,
                                          margin: EdgeInsets.only(
                                            left: 10,
                                          ),
                                          child: RichText(
                                            text: TextSpan(
                                              children: [
                                                WidgetSpan(
                                                  child: Icon(
                                                    Icons.house_outlined,
                                                    size: 16,
                                                    color: Color(0xff10375C),
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: product.marca,
                                                  style: TextStyle(
                                                    color: Color(0xff10375C),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 1.0, bottom: 1.0),
                                          child: Container(
                                            height: 50,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            padding: EdgeInsets.all(0),
                                            color: Colors.white,
                                            child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            4.0),
                                                    child: Row(
                                                      children: [
                                                        const SizedBox(
                                                            width: 10),
                                                        ElevatedButton.icon(
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            primary: Color(
                                                                0xff1a49ab), // background
                                                            // foreground
                                                          ),
                                                          onPressed: () {
                                                            addToCart();
                                                            var show =
                                                                AnimatedSnackBar
                                                                    .material(
                                                              'Aggregado Correctamente,  ' +
                                                                  '( ' +
                                                                  userCartLen
                                                                      .toString() +
                                                                  ' )' +
                                                                  ' Carrito  ',
                                                              type:
                                                                  AnimatedSnackBarType
                                                                      .success,
                                                            ).show(context);
                                                          },
                                                          icon: Icon(
                                                              IconlyLight.buy,
                                                              size: 16),
                                                          label: Text(
                                                              "Añadir al Carrito"),
                                                        ),
                                                        SizedBox(width: 10),
                                                        ElevatedButton.icon(
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            primary: Color(
                                                                0xff3A4750), // background
                                                            // foreground
                                                          ),
                                                          onPressed: () =>
                                                              Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (context) =>
                                                                  ProductDetailsScreen(
                                                                product:
                                                                    product,
                                                              ),
                                                            ),
                                                          ),
                                                          icon: Icon(
                                                              Icons
                                                                  .preview_outlined,
                                                              size: 16),
                                                          label: Text(
                                                              "Ver details"),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ]),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }

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
                          Center(
                            child: Container(
                              margin: const EdgeInsets.only(top: 2.0),
                              width: 130.0,
                              height: 40,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 10.0, right: 5, bottom: 5),
                                child: Center(
                                  child: Text(
                                    product.name,
                                    style: TextStyle(
                                      color: Color(0xff1C2833),
                                      fontWeight: FontWeight.w400,
                                      letterSpacing: 0.4,
                                      fontSize: 11.0,
                                    ),
                                    textAlign: TextAlign.start,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: 120.0,
                            height: 100.0,
                            child: widget.productList == null
                                ? const Loader()
                                : SingleProduct(
                                    imagen: product.images[0],
                                  ),
                          ),
                          Container(
                            height: 30,
                            width: 120.0,
                            color: Color(0xffFffffff),
                            child: FlatButton(
                              onPressed: () {
                                _modalInteriorFerce(context);
                              },
                              child: Icon(Icons.keyboard_control),
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
