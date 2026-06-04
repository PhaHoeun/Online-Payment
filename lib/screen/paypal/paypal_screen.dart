import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';
import 'package:online_payment/model/paypal_model/paypal_model.dart';

class PaypalScreen extends StatefulWidget {
  const PaypalScreen({super.key});

  @override
  State<PaypalScreen> createState() => _PaypalScreenState();
}

class _PaypalScreenState extends State<PaypalScreen> {
  var paymentModel = PaypalModel(
    amount: Amount(
      total: '100',
      currency: 'USD',
      details: AmountDetails(
        subtotal: '100',
        shipping: '0',
        shippingDiscount: 0,
      ),
    ),
    description: 'The payment transaction description.',
    itemList: ItemList(
      items: [
        Item(name: 'Apple', quantity: 4, price: '10', currency: 'USD'),
        Item(name: 'Pineapple', quantity: 5, price: '12', currency: 'USD'),
      ],
    ),
  );

  // {
  //                     "amount": {
  //                       "total": '100',
  //                       "currency": "USD",
  //                       "details": {
  //                         "subtotal": '100',
  //                         "shipping": '0',
  //                         "shipping_discount": 0,
  //                       },
  //                     },
  //                     "description": "The payment transaction description.",
  //                     "item_list": {
  //                       "items": [
  //                         {
  //                           "name": "Apple",
  //                           "quantity": 4,
  //                           "price": '10',
  //                           "currency": "USD",
  //                         },
  //                         {
  //                           "name": "Pineapple",
  //                           "quantity": 5,
  //                           "price": '12',
  //                           "currency": "USD",
  //                         },
  //                       ],
  //                     },
  //                   },

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Paypal Payment')),
      body: Center(
        child: TextButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) => PaypalCheckoutView(
                  sandboxMode: true,
                  clientId:
                      "AfOHBCBh8ugL6dxRhtE_264b6ueJA37TWt4iGnOUm9h0pftkaYCccw9h3y7ljg3RN9ntUehKQctaxHli",
                  secretKey:
                      "EN40zSNhSJEQT3F5WxCtH_6Iy-ACA3arlvl6gx_mcGTffRPDzLTt20nUEhi3H4dBXjV9LU1NmYdW13vR",
                  transactions: [paymentModel.toJson()],
                  note: "Contact us for any questions on your order.",
                  onSuccess: (Map params) async {
                    log("onSuccess: $params");
                    Navigator.pop(context);
                  },
                  onError: (error) {
                    log("onError: $error");
                    Navigator.pop(context);
                  },
                  onCancel: () {
                    debugPrint('cancelled:');
                    Navigator.pop(context);
                  },
                ),
              ),
            );
          },
          child: const Text('Pay with paypal'),
        ),
      ),
    );
  }
}
