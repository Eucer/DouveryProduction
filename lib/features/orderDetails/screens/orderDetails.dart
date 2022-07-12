import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:v1douvery/NAV/centerSearchNav.dart';
import 'package:v1douvery/NAV/topTitleButtom.dart';
import 'package:v1douvery/common/widgets/custon_button.dart';
import 'package:v1douvery/constantes/global_variables.dart';
import 'package:v1douvery/features/admin/servicios/adminServices.dart';
import 'package:v1douvery/models/order.dart';
import 'package:v1douvery/provider/user_provider.dart';

class OrderDetailScreen extends StatefulWidget {
  static const String routeName = '/order-details';
  final Order order;
  const OrderDetailScreen({
    Key? key,
    required this.order,
  }) : super(key: key);

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  int currentStep = 0;
  final AdminServices adminServices = AdminServices();

  @override
  void initState() {
    super.initState();
    currentStep = widget.order.status;
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;

    return Scaffold(
      backgroundColor: GlobalVariables.greyBackgroundCOlor,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(45),
        child: TopTitleButtom(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CenterSearchNav(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: EdgeInsets.all(10),
                color: GlobalVariables.backgroundColor,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'View order details',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black12,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Order ID:          ${widget.order.id}'),
                            Text(
                                'Order Total:      \$${widget.order.totalPrice}'),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Purchase Details',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black12,
                            ),
                            color: GlobalVariables.backgroundColor),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            for (int i = 0;
                                i < widget.order.products.length;
                                i++)
                              Row(
                                children: [
                                  Image.network(
                                    widget.order.products[i].images[0],
                                    height: 120,
                                    width: 120,
                                  ),
                                  const SizedBox(width: 5),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          widget.order.products[i].name,
                                          style: const TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          'Qty: ${widget.order.quantity[i]}',
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Tracking',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black12,
                          ),
                        ),
                        child: Stepper(
                          currentStep: currentStep,
                          controlsBuilder: (context, details) {
                            if (user.type == 'admin') {
                              return CustomButton(
                                text: 'Done',
                                onTap: () {},
                              );
                            }
                            return const SizedBox();
                          },
                          steps: [
                            Step(
                              title: const Text('Pending'),
                              content: const Text(
                                'Your order is yet to be delivered',
                              ),
                              isActive: currentStep > 0,
                              state: currentStep > 0
                                  ? StepState.complete
                                  : StepState.indexed,
                            ),
                            Step(
                              title: const Text('Completed'),
                              content: const Text(
                                'Your order has been delivered, you are yet to sign.',
                              ),
                              isActive: currentStep > 1,
                              state: currentStep > 1
                                  ? StepState.complete
                                  : StepState.indexed,
                            ),
                            Step(
                              title: const Text('Received'),
                              content: const Text(
                                'Your order has been delivered and signed by you.',
                              ),
                              isActive: currentStep > 2,
                              state: currentStep > 2
                                  ? StepState.complete
                                  : StepState.indexed,
                            ),
                            Step(
                              title: const Text('Delivered'),
                              content: const Text(
                                'Your order has been delivered and signed by you!',
                              ),
                              isActive: currentStep >= 3,
                              state: currentStep >= 3
                                  ? StepState.complete
                                  : StepState.indexed,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
