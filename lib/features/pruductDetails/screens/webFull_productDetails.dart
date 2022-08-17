import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:contained_tab_bar_view_with_custom_page_navigator/contained_tab_bar_view_with_custom_page_navigator.dart';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hovering/hovering.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:v1douvery/NAV/web/Web_bottomNavSearchTitle.dart';
import 'package:v1douvery/common/widgets/IconButton.dart';
import 'package:v1douvery/common/widgets/custom_textfiels.dart';
import 'package:v1douvery/common/widgets/stars.dart';
import 'package:v1douvery/constantes/global_variables.dart';
import 'package:v1douvery/features/address/screens/addresScreens.dart';
import 'package:v1douvery/features/brands/screens/brandsScreen.dart';
import 'package:v1douvery/features/home/screens/home_screensModiles.dart';
import 'package:v1douvery/features/orderDetails/screens/orderDetails.dart';
import 'package:v1douvery/features/pruductDetails/services/pruductDetailsServices.dart';
import 'package:v1douvery/features/pruductDetails/widgets/modalScreen.dart';
import 'package:v1douvery/models/ratings.dart';
import 'package:v1douvery/provider/user_provider.dart';

import '../../../common/widgets/loader.dart';
import '../../../models/product.dart';
import '../../auth/responsive/authResponsivelayout.dart';

class WebFull_productDetails extends StatefulWidget {
  final Product product;
  WebFull_productDetails({Key? key, required this.product}) : super(key: key);

  @override
  State<WebFull_productDetails> createState() => _WebFull_productDetailsState();
}

class _WebFull_productDetailsState extends State<WebFull_productDetails> {
  List<Rating>? rating;
  final ProductDetailsServices productDetailsServices =
      ProductDetailsServices();

  double avgRating = 0;
  double myRating = 0;
  double totalRating = 0;
  @override
  void initState() {
    super.initState();
    double totalRating = 0;
    for (int i = 0; i < widget.product.rating!.length; i++) {
      totalRating += widget.product.rating![i].rating;
      if (widget.product.rating![i].userId ==
          Provider.of<UserProvider>(context, listen: false).user.id) {
        myRating = widget.product.rating![i].rating;
      }
    }

    if (totalRating != 0) {
      avgRating = totalRating / widget.product.rating!.length;
    }
  }

  void addToCart() {
    productDetailsServices.addToCart(
      context: context,
      product: widget.product,
    );
  }

  int _current = 0;
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    final userCartLen = context.watch<UserProvider>().user.cart.length;
    Future _delayedFuture = Future.delayed(
      const Duration(milliseconds: 100),
      () {},
    );

    //*ModalCart

    _modalIconsCart(BuildContext context) async {
      showModalBottomSheet(
          context: context,
          builder: (BuildContext bc) {
            return ModalCartProductDetails();
          });
    }

    return Scaffold(
      backgroundColor: GlobalVariables.greyBackgroundCOlor,
      body: SingleChildScrollView(
        child: Container(
          child: Column(children: [
            Product == null
                ? const Loader()
                : Column(children: [
                    WebFull_NavCategory(),
                    ConPricer(context),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Container(
                              color: Colors.white,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Carousel(context),
                                  Container(
                                    alignment: Alignment.bottomLeft,
                                    padding: const EdgeInsets.only(top: 30.0),
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2,
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  GestureDetector(
                                                    onTap: () => Navigator.push(
                                                      context,
                                                      PageRouteBuilder(
                                                        pageBuilder:
                                                            (_, __, ___) =>
                                                                BrandsScreen(
                                                          brands: widget
                                                              .product.marca,
                                                        ),
                                                        settings: RouteSettings(
                                                          arguments: widget
                                                              .product.marca,
                                                        ),
                                                      ),
                                                    ),
                                                    child: Container(
                                                      width: 800,
                                                      height: 30,
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: RichText(
                                                        text: TextSpan(
                                                          children: [
                                                            WidgetSpan(
                                                              child: Icon(
                                                                Icons
                                                                    .house_outlined,
                                                                size: 16,
                                                                color: Color(
                                                                    0xff10375C),
                                                              ),
                                                            ),
                                                            TextSpan(
                                                              text: widget
                                                                  .product
                                                                  .marca,
                                                              style: TextStyle(
                                                                color: Color(
                                                                    0xff10375C),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 18.0),
                                                    child: Container(
                                                      width: 800,
                                                      height: 60,
                                                      child: Text(
                                                        widget.product.name,
                                                        style: const TextStyle(
                                                          color:
                                                              Color(0xff1C2833),
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          letterSpacing: 0.4,
                                                          fontSize: 20.0,
                                                        ),
                                                        textAlign:
                                                            TextAlign.start,
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                  ),
                                                ]),
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2,
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        border: Border(
                                                          bottom: BorderSide(
                                                              width: 1,
                                                              color: Color(
                                                                  0xfff1f5f9)),
                                                        ),
                                                        color: Colors.white,
                                                      ),
                                                      width: 400,
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      height: 500,
                                                      child:
                                                          ContainedTabBarView(
                                                        tabBarProperties:
                                                            const TabBarProperties(
                                                          indicatorColor:
                                                              Colors.red,
                                                        ),
                                                        tabs: const [
                                                          Text(
                                                            'Descripcion',
                                                            style: TextStyle(
                                                              color: Color
                                                                  .fromARGB(206,
                                                                      0, 0, 0),
                                                            ),
                                                          ),
                                                          Text(
                                                            'Servicio',
                                                            style: TextStyle(
                                                              color: Color
                                                                  .fromARGB(206,
                                                                      0, 0, 0),
                                                            ),
                                                          ),
                                                        ],
                                                        views: [
                                                          ContainerDescription(),
                                                          Container(
                                                              child:
                                                                  Text('text')),
                                                        ],
                                                        // ignore: avoid_print
                                                        onChange: (index) =>
                                                            print(index),
                                                      ),
                                                    ),
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        border: Border(
                                                          bottom: BorderSide(
                                                              width: 1,
                                                              color: Color(
                                                                  0xfff1f5f9)),
                                                        ),
                                                        color: Colors.white,
                                                      ),
                                                      width: 400,
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      height: 500,
                                                      child:
                                                          ContainedTabBarView(
                                                        tabBarProperties:
                                                            TabBarProperties(
                                                          indicatorWeight: 1.0,
                                                          indicatorColor: Provider
                                                                      .of<UserProvider>(
                                                                          context)
                                                                  .user
                                                                  .token
                                                                  .isNotEmpty
                                                              ? GlobalVariables
                                                                  .colorUser
                                                              : GlobalVariables
                                                                  .colorgreen,
                                                        ),
                                                        tabs: const [
                                                          Text(
                                                            'Reviews',
                                                            style: TextStyle(
                                                              color: Color
                                                                  .fromARGB(206,
                                                                      0, 0, 0),
                                                            ),
                                                          ),
                                                        ],
                                                        views: [
                                                          StackReviews(context),
                                                        ],
                                                        // ignore: avoid_print
                                                        onChange: (index) =>
                                                            print(index),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          )
                                        ]),
                                  )
                                ],
                              )),
                        ],
                      ),
                    ),
                  ]),
          ]),
        ),
      ),
    );
  }

  Container ContainerDescription() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          widget.product.description,
        ),
      ),
    );
  }

  Stack StackReviews(BuildContext context) {
    final TextEditingController reviewClient = TextEditingController();
    final user = Provider.of<UserProvider>(context).user;

    return Stack(
      children: [
        Provider.of<UserProvider>(context).user.token.isNotEmpty
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Column(
                    children: [
                      Container(
                        width: 600,
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.only(top: 10, right: 10),
                              child: Text(
                                user.name,
                                style: TextStyle(fontSize: 13),
                              ),
                            ),
                            RatingBar.builder(
                              initialRating: myRating,
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemBuilder: (context, _) => Icon(
                                Iconsax.star_15,
                                color: Color(0xffFF2E4C),
                              ),
                              onRatingUpdate: (rating) {
                                productDetailsServices.rateProduct(
                                  context: context,
                                  product: widget.product,
                                  rating: rating,
                                );
                                setState(() {});
                              },
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 8.0, bottom: 8, right: 10),
                            child: Container(child: Text('Tu rating :  ')),
                          ),
                          Column(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 7,
                                height: 100,
                                color: Colors.white,
                                child: Column(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(top: 10),
                                      width: 600,
                                      height: 90,
                                      child: CustomTextField(
                                        controller: reviewClient,
                                        hintText: '',
                                        maxLines: 2,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            : Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Container(
                  width: MediaQuery.of(context).size.width / 1,
                  height: 80,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      bottom: BorderSide(
                        width: 1,
                        color: Color.fromARGB(5, 0, 0, 0),
                      ),
                    ),
                  ),
                  padding: const EdgeInsets.only(bottom: 0.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text(
                        'Inicia session para comentar ...  ',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => WebFullResponsiveLayaout(),
                            ),
                          );
                        },
                        child: const Text(
                          'Iniciar Session',
                          style: TextStyle(color: GlobalVariables.colorgreen),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
        Padding(
          padding: const EdgeInsets.only(top: 90.0),
          child: Container(
            
            margin: Provider.of<UserProvider>(context).user.token.isNotEmpty
                ? EdgeInsets.only(top: 90.0)
                : EdgeInsets.only(top: 000.0),
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: widget.product.rating!.length,
                itemBuilder: ((context, index) {
                  final rating = widget.product.rating![index];
                  return Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(bottom: 5),
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          rating.userId,
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(bottom: 5),
                        alignment: Alignment.bottomLeft,
                        child: Row(
                          children: [
                            Stars(rating: rating.rating),
                            Text(
                              '(' +
                                  avgRating.toString() +
                                  ') ' +
                                  widget.product.rating!.length.toString(),
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 13),
                            ),
                            Text(
                              widget.product.name.length.toString(),
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 13),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                })),
          ),
        ),
      ],
    );
  }

  Padding Carousel(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            Container(
              width: 800,
              decoration: const BoxDecoration(
                color: GlobalVariables.backgroundColor,
                border: Border(
                  bottom: BorderSide(
                    width: 1,
                    color: Color.fromARGB(5, 0, 0, 0),
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  HoverWidget(
                    hoverChild: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.arrow_left,
                            color: GlobalVariables.secondaryColor,
                          ),
                          Text(
                            'Regresar',
                            style: GoogleFonts.openSans(fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                    onHover: (PointerEnterEvent event) {},
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Row(
                        children: [
                          Icon(Icons.arrow_left),
                          Text(
                            'Regresar',
                            style: GoogleFonts.openSans(fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 800,
              height: 700,
              color: Color.fromARGB(180, 255, 255, 255),
              child: Padding(
                padding: const EdgeInsets.all(1.0),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          color: Colors.white,
                          child: CarouselSlider(
                            items: widget.product.images.map(
                              (i) {
                                return Builder(
                                  builder: (BuildContext context) => Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.network(
                                      i,
                                      height: 1500,
                                      fit: BoxFit.contain,
                                      width: 700,
                                    ),
                                  ),
                                );
                              },
                            ).toList(),
                            options: CarouselOptions(
                              viewportFraction: 1,
                              height: 600,
                              aspectRatio: 16 / 9,
                              initialPage: 0,
                              enableInfiniteScroll: false,
                              reverse: false,
                              autoPlayCurve: Curves.fastOutSlowIn,
                              enlargeCenterPage: true,
                              scrollDirection: Axis.horizontal,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      color: GlobalVariables.backgroundColor,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: widget.product.images.asMap().entries.map(
                          (entry) {
                            return GestureDetector(
                              onTap: () => _controller.animateToPage(entry.key),
                              child: Container(
                                width: 9.0,
                                height: 9.0,
                                margin: EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 4.0),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: (Theme.of(context).brightness ==
                                                Brightness.dark
                                            ? Color.fromARGB(255, 68, 62, 62)
                                            : Colors.black)
                                        .withOpacity(
                                            _current == entry.key ? 0.5 : 0.1)),
                              ),
                            );
                          },
                        ).toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container ConPricer(BuildContext context) {
    _modalIconsCart(BuildContext context) async {
      showModalBottomSheet(
          context: context,
          builder: (BuildContext bc) {
            return ModalCartProductDetails();
          });
    }

    return Container(
      height: 53,
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (avgRating >= 5) ...[
                    Flash(child: Stars(rating: avgRating)),
                  ] else ...[
                    Stars(rating: avgRating),
                  ],
                ],
              ),
            ),

            Container(
              width: 50,
              child: Text(
                '(' +
                    avgRating.toString() +
                    ') ' +
                    widget.product.rating!.length.toString(),
                style: const TextStyle(color: Colors.grey, fontSize: 15),
                textAlign: TextAlign.start,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 18),
            const Text(
              'Precio: ',
              style: TextStyle(color: Colors.black54, fontSize: 18),
            ),

            Text(
              '\$${widget.product.price}',
              style: const TextStyle(
                color: Color(0xff1C2833),
                fontWeight: FontWeight.w500,
                letterSpacing: 0.4,
                fontSize: 20.0,
              ),
            ),
            const SizedBox(width: 18),
            //

            const Text(
              'Envio Gratis',
              style: TextStyle(
                  color: Color.fromARGB(255, 4, 161, 17), fontSize: 15),
            ),

            Container(
              height: 60,
              width: 300,
              padding: EdgeInsets.all(0),
              color: Colors.white,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Row(
                        children: [
                          const SizedBox(width: 10),
                          Provider.of<UserProvider>(context)
                                  .user
                                  .token
                                  .isNotEmpty
                              ? ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                    primary: Color(0xff1a49ab), // background
                                    // foreground
                                  ),
                                  onPressed: () {
                                    addToCart();
                                    _modalIconsCart(context);
                                  },
                                  icon: Icon(
                                    IconlyLight.buy,
                                    size: 16,
                                    color: Colors.white,
                                  ),
                                  label: Text(
                                    "Añadir al Carrito",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              : ButtomAggCartNosessions(),
                          SizedBox(width: 10),
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              primary: Color(0xffed174f), // background
                              // foreground
                            ),
                            onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddressScreen(
                                  totalAmount: widget.product.price.toString(),
                                  cantid: widget.product.name.toString(),
                                ),
                              ),
                            ),
                            icon: Icon(
                              Icons.payments,
                              size: 16,
                              color: Colors.white,
                            ),
                            label: Text("Pagar",
                                style: TextStyle(
                                  color: Colors.white,
                                )),
                          ),
                        ],
                      ),
                    ),
                  ]),
            ),
          ],
        ),
      ]),
    );
  }
}

class ButtomAggCartNosessions extends StatelessWidget {
  const ButtomAggCartNosessions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        primary: Color(0xff1a49ab), // background
        // foreground
      ),
      onPressed: () {
        ElegantNotification.info(
          width: 500,
          title: Text("Info"),
          description: Text('Upps... parece que no has iniciado session '),
          animationDuration: const Duration(milliseconds: 200),
          toastDuration: const Duration(milliseconds: 3500),
        ).show(context);
        ;
      },
      icon: Icon(
        IconlyLight.buy,
        size: 16,
        color: Colors.white,
      ),
      label: Text(
        "Añadir al Carrito",
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
