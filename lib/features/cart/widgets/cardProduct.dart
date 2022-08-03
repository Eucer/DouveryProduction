import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:v1douvery/constantes/global_variables.dart';
import 'package:v1douvery/features/cart/services/cardServices.dart';
import 'package:v1douvery/features/pruductDetails/screens/productDetailsScrenn.dart';
import 'package:v1douvery/features/pruductDetails/services/pruductDetailsServices.dart';
import 'package:v1douvery/models/product.dart';
import 'package:v1douvery/provider/user_provider.dart';

class CartProduct extends StatefulWidget {
  final int index;
  const CartProduct({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  State<CartProduct> createState() => _CartProductState();
}

class _CartProductState extends State<CartProduct> {
  final ProductDetailsServices productDetailsServices =
      ProductDetailsServices();
  final CartServices cartServices = CartServices();

  void increaseQuantity(Product product) {
    productDetailsServices.addToCart(
      context: context,
      product: product,
    );
  }

  void decreaseQuantity(Product product) {
    cartServices.removeFromCart(
      context: context,
      product: product,
    );
  }

  @override
  Widget build(BuildContext context) {
    final productCart = context.watch<UserProvider>().user.cart[widget.index];
    final product = Product.fromMap(productCart['product']);
    final quantity = productCart['quantity'];

    return Container(
      child: Column(
        children: [
          GestureDetector(
            child: Container(
              margin: const EdgeInsets.only(
                left: 0,
              ),
              decoration: BoxDecoration(
                  color: GlobalVariables.backgroundColor,
                  border: Border(
                      bottom: BorderSide(
                          color: Color.fromARGB(8, 0, 0, 0), width: 1))),
              child: Row(
                children: [
                  CachedNetworkImage(
                    imageUrl: product.images[0],
                    fit: BoxFit.contain,
                    height: 120,
                    width: 130,
                  ),
                  Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 1.8,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 0, vertical: 5),
                        child: Text(
                          product.name,
                          style: const TextStyle(
                            fontSize: 15,
                          ),
                          maxLines: 2,
                        ),
                      ),
                      Container(
                        width: 235,
                        padding: const EdgeInsets.only(left: 10, top: 5),
                        child: Text(
                          '\$${product.price}',
                          style: const TextStyle(
                            color: GlobalVariables.colorPriceSecond,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.5,
                            fontSize: 18.0,
                          ),
                          maxLines: 2,
                        ),
                      ),
                      Container(
                        width: 235,
                        padding: const EdgeInsets.only(left: 10, top: 5),
                        child: const Text(
                          'Disponible',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xff212121),
                          ),
                          maxLines: 2,
                        ),
                      ),
                      Container(
                        margin:
                            const EdgeInsets.only(left: 15, top: 8, bottom: 8),
                        color: GlobalVariables.backgroundNavBarColor,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black12,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.black12,
                              ),
                              child: Row(
                                children: [
                                  InkWell(
                                    onTap: () => decreaseQuantity(product),
                                    child: Container(
                                      width: 32,
                                      height: 22,
                                      alignment: Alignment.center,
                                      child: const Icon(
                                        Icons.remove,
                                        color: Colors.white,
                                        size: 16,
                                      ),
                                    ),
                                  ),
                                  DecoratedBox(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.black12, width: 1.5),
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(0),
                                    ),
                                    child: Container(
                                      width: 25,
                                      height: 22,
                                      alignment: Alignment.center,
                                      child: Text(
                                        quantity.toString(),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () => increaseQuantity(product),
                                    child: Container(
                                      width: 32,
                                      height: 22,
                                      alignment: Alignment.center,
                                      child: const Icon(
                                        Icons.add,
                                        color: Colors.white,
                                        size: 16,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
