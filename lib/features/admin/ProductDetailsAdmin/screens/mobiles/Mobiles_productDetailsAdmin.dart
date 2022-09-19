import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:v1douvery/models/product.dart';

class MobilesProductDetailsAdmin extends StatefulWidget {
  final Product product;
  MobilesProductDetailsAdmin({Key? key, required this.product})
      : super(key: key);

  @override
  State<MobilesProductDetailsAdmin> createState() =>
      _MobilesProductDetailsAdminState();
}

class _MobilesProductDetailsAdminState
    extends State<MobilesProductDetailsAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(90),
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
                          'Product Details',
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
          ],
        ),
      ),
    );
  }
}
