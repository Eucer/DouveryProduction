import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:v1douvery/common/widgets/header_double.dart';
import 'package:v1douvery/constantes/global_variables.dart';

class OrdersUser extends StatefulWidget {
  const OrdersUser({Key? key}) : super(key: key);

  @override
  State<OrdersUser> createState() => _OrdersUserState();
}

List list = [
  'https://m.media-amazon.com/images/I/71rXSVqET9L._AC_SX679_.jpg',
  'https://m.media-amazon.com/images/I/71rXSVqET9L._AC_SX679_.jpg',
  'https://m.media-amazon.com/images/I/71rXSVqET9L._AC_SX679_.jpg',
  'https://m.media-amazon.com/images/I/71rXSVqET9L._AC_SX679_.jpg',
  'https://m.media-amazon.com/images/I/71rXSVqET9L._AC_SX679_.jpg',
];

class _OrdersUserState extends State<OrdersUser> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            color: Colors.white,
            child: headerDoubleText(
              textHeader: 'Orders',
              textAction: 'Ver mas',
            ),
          ),
          Container(
            height: 130,
            padding: EdgeInsets.only(top: 0, right: 0),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: list.length,
              itemBuilder: (context, index) {
                return SingleProduct(
                  imagen: list[index],
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

class SingleProduct extends StatelessWidget {
  final String imagen;
  const SingleProduct({Key? key, required this.imagen}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: GlobalVariables.backgroundColor,
      child: GestureDetector(
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0, top: 0.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(0),
            child: CachedNetworkImage(
              imageUrl: imagen,
              width: 150,
              height: 110.0,
              fit: BoxFit.scaleDown,
            ),
          ),
        ),
      ),
    );
  }
}
