import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_paypal_payment_checkout_v2/flutter_paypal_payment_checkout_v2.dart'
    hide State;
import 'package:gap/gap.dart';

class PaypalScreen extends StatefulWidget {
  const PaypalScreen({super.key});

  @override
  State<PaypalScreen> createState() => _PaypalScreenState();
}

class _PaypalScreenState extends State<PaypalScreen> {
  static const String _paypalClientId =
      'AWRRJy2dv9EyT_47T72w3IR2pxFinZOznKA-aeqUWRVAZ0f-ieXceIsBJrQxIDFHTMm0mn56_ohG0wfn';
  static const String _paypalSecretKey =
      'EDScH3kfhYIrqicoxXeJbBuXcuhkRG9ItlbAynjEMupi76-iMvKRKp98VN2zYxvMNZynedrIRZYuFI3R';
  var items = <PaypalTransactionV2Item>[
    PaypalTransactionV2Item(
      name: 'Apple',
      description: 'Fresh red apples',
      quantity: 1,
      unitAmount: 100.0,
      currency: 'USD',
      category: PayPalItemCategoryV2.physicalGoods,
      sku: 'SKU_APPLE',
      imageUrl:
          'https://img.lb.wbmdstatic.com/vim/live/webmd/consumer_assets/site_images/articles/health_tools/healing_foods_slideshow/1800ss_getty_rf_apples.jpg?resize=750px:*&output-quality=75',
    ),
    PaypalTransactionV2Item(
      name: 'Banana',
      description: 'Fresh yellow bananas',
      quantity: 5,
      unitAmount: 30.0,
      currency: 'USD',
      category: PayPalItemCategoryV2.physicalGoods,
      sku: 'SKU_BANANA',
      imageUrl:
          'https://www.dole.com/sites/default/files/styles/512w512h-80/public/media/2025-02/Dole_HP_Motiv_1080x1080px_Banane_0.jpg?itok=_qbPhqIY-_u0SMyQV',
    ),
    PaypalTransactionV2Item(
      name: 'Orange',
      description: 'Fresh orange',
      quantity: 3,
      unitAmount: 50.0,
      currency: 'USD',
      category: PayPalItemCategoryV2.physicalGoods,
      sku: 'SKU_ORANGE',
      imageUrl: 'https://www.fruitsmith.com/pub/media/wysiwyg/Orange.jpg',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Checkout'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ...items.map(
                        (item) => ListTile(
                          leading: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.grey[200],
                              image: DecorationImage(
                                image: NetworkImage(item.imageUrl!),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          title: Text(
                            item.name,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          subtitle: Text(
                            item.description,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          trailing: Text(
                            '${item.quantity} x \$${item.unitAmount.toStringAsFixed(2)}',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Gap(16),
              Divider(),
              Gap(10),
              SafeArea(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Subtotal: \$400.00',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        Text(
                          'Tax: \$10.00',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),

                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Text(
                            'Total: \$410.00',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () => _startV2MobileFlow(context),
                      child: Card(
                        shadowColor: Colors.transparent,
                        color: Colors.cyan,
                        margin: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
                        child:  Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text(
                            'Checkout',
                           style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------- V2 EXAMPLE ----------------
  void _startV2MobileFlow(BuildContext context) {
    // Build a simple V2 order with 1 purchase unit
    final order = PayPalOrderRequestV2(
      intent: PayPalOrderIntentV2.capture,
      paymentSource: PayPalPaymentSourceV2(
        paymentMethodPreference:
            PayPalPaymentMethodPreferenceV2.immediatePaymentRequired,
        shippingPreference: PayPalShippingPreferenceV2.noShipping,
      ),
      purchaseUnits: [
        PayPalPurchaseUnitV2(
          invoiceId: 'INV-000002',
          amount: PayPalAmountV2(
            currency: 'USD',
            value: 410.0, // total amount
            itemTotal: 400.0, // sum of items
            taxTotal: 10.0, // total tax
          ),
          items: [...items],
        ),
      ],
    );

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PaypalCheckoutView(
          config: PaypalCheckoutConfig(
            version: PayPalApiVersion.v2,
            // 👇 In production, prefer getting approvalUrl / accessToken from backend
            getAccessToken: null,
            // using clientId/secret (sandbox ONLY)
            approvalUrl: null,

            sandboxMode: true,
            clientId: _paypalClientId,
            secretKey: _paypalSecretKey,

            payPalOrder: order,
            onUserPayment: (success, payment) async {
              log(
                'V2 onSuccess payment: ----------------------------- ${payment.toJson()}',
              );
              log(
                'V2 onSuccess capture data: -------------------------------- ${success?.data}',
              );
              Navigator.pop(context);
              return const Right<PayPalErrorModel, dynamic>(null);
            },
            onError: (error) {
              // Log as much info as possible for debugging network/order creation failures
              log('V2 onError: ${error.message} (${error.key})');
              try {
                // Some error models provide a toJson() method
                log('V2 onError details: $error');
              } catch (e) {
                log('V2 onError details (raw): $error');
              }

              // Show a dialog so you can see the error on-device
              showDialog<void>(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: const Text('PayPal Error'),
                  content: SingleChildScrollView(child: Text(error.message)),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(ctx).pop(),
                      child: const Text('OK'),
                    ),
                  ],
                ),
              );

              Navigator.pop(context);
            },
            onCancel: () {
              log('V2 cancelled by user');
              Navigator.pop(context);
            },
          ),
        ),
      ),
    );
  }
}
