import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:v1douvery/common/widgets/header_double.dart';
import 'package:v1douvery/constantes/global_variables.dart';
import 'package:v1douvery/features/home/widgets/vertRecomd.dart';
import 'package:v1douvery/provider/user_provider.dart';

class Import extends StatelessWidget {
  const Import({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;

    return Column(
      children: [
        Container(
            margin: EdgeInsets.only(top: 10, right: 8, bottom: 0, left: 8),
            child: Column(
              children: [
                Container(
                    color: GlobalVariables.backgroundColor,
                    padding: EdgeInsets.all(10),
                    child: headerDoubleText(
                        textHeader: 'Para ti', textAction: 'Ver mas')),
                Container(
                  height: 380,
                  color: GlobalVariables.backgroundColor,
                  child: ListView.builder(
                    itemCount: 3,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Container(
                        child: RecomendProduct(
                          index: index,
                        ),
                      );
                    },
                  ),
                ),
              ],
            )),
      ],
    );
  }
}