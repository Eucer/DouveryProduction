import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:v1douvery/common/widgets/header_double.dart';
import 'package:v1douvery/common/widgets/loader.dart';
import 'package:v1douvery/constantes/global_variables.dart';
import 'package:v1douvery/features/account/widgets/ordenesUser.dart';
import 'package:v1douvery/features/home/services/homeServices.dart';
import 'package:v1douvery/features/pruductDetails/screens/productDetailsScrenn.dart';
import 'package:v1douvery/models/product.dart';

class Web_CarRandom extends StatefulWidget {
  const Web_CarRandom({Key? key}) : super(key: key);

  @override
  State<Web_CarRandom> createState() => _Web_CarRandomState();
}

class _Web_CarRandomState extends State<Web_CarRandom> {
  List<Product>? productList;
  final HomeServices homeServices = HomeServices();

  @override
  void initState() {
    super.initState();
    fetchTest();
  }

  fetchTest() async {
    productList = await homeServices.fetchTest(
      context: context,
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final CarouselController _controller = CarouselController();

    @override
    void initState() {
      super.initState();
    }

    return Container(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            color: Colors.white,
            child: headerDoubleText(
              textHeader: 'Historial Click',
              textAction: 'Ver mas',
            ),
          ),
          productList == null
              ? const Loader()
              : Container(
                  width: 1500,
                  color: GlobalVariables.backgroundColor,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Flexible(
                            child: ElevatedButton(
                              onPressed: () => _controller.previousPage(),
                              child: Text('←'),
                            ),
                          ),
                          Flexible(
                            child: ElevatedButton(
                              onPressed: () => _controller.nextPage(),
                              child: Text('→'),
                            ),
                          ),
                        ],
                      ),
                      Container(
                          height: 135,
                          width: 1500,
                          child: CarouselSlider.builder(
                            itemCount: productList!.length,
                            itemBuilder: (context, index, realIndex) {
                              final product = productList![index];
                              return Container(
                                width: 200,
                                child: GestureDetector(
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
                                    width: 135.0,
                                    height: 110.0,
                                    child: productList == null
                                        ? const Loader()
                                        : Container(
                                            width: 200,
                                            child: CachedNetworkImage(
                                              imageUrl: product.images[0],
                                            )),
                                  ),
                                ),
                              );
                            },
                            options: CarouselOptions(
                              enableInfiniteScroll: false,
                              viewportFraction: 0.2,
                              enlargeStrategy: CenterPageEnlargeStrategy.height,
                              aspectRatio: 1 / 2,
                              disableCenter: true,
                              pageSnapping: false,
                              padEnds: false,
                              pauseAutoPlayOnTouch: false,
                            ),
                            carouselController: _controller,
                          )),
                    ],
                  ),
                ),
        ],
      ),
    );
  }
}
