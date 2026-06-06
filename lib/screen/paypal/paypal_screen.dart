import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_paypal_payment_checkout_v2/flutter_paypal_payment_checkout_v2.dart';

class PaypalScreen extends StatelessWidget {
  const PaypalScreen({super.key});

  static const String _paypalClientId =
      'AWRRJy2dv9EyT_47T72w3IR2pxFinZOznKA-aeqUWRVAZ0f-ieXceIsBJrQxIDFHTMm0mn56_ohG0wfn';
  static const String _paypalSecretKey =
      'EDScH3kfhYIrqicoxXeJbBuXcuhkRG9ItlbAynjEMupi76-iMvKRKp98VN2zYxvMNZynedrIRZYuFI3R';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('PayPal Payment'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton(
                onPressed: () => _startV2MobileFlow(context),
                child: const Text('Checkout'),
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
          invoiceId: 'INV-123456',
          amount: PayPalAmountV2(
            currency: 'USD',
            value: 410.0, // total amount
            itemTotal: 400.0, // sum of items
            taxTotal: 10.0, // total tax
          ),
          items: [
            PaypalTransactionV2Item(
              name: 'Apple',
              description: 'Fresh red apples',
              quantity: 1,
              unitAmount: 100.0,
              currency: 'USD',
              category: PayPalItemCategoryV2.physicalGoods,
              sku: 'SKU_APPLE',
            ),
            PaypalTransactionV2Item(
              name: 'Banana',
              description: 'Fresh yellow bananas',
              quantity: 5,
              unitAmount: 30.0,
              currency: 'USD',
              category: PayPalItemCategoryV2.physicalGoods,
              sku: 'SKU_BANANA',
            ),
            PaypalTransactionV2Item(
              name: 'Orange',
              description: 'Fresh orange',
              quantity: 3,
              unitAmount: 50.0,
              currency: 'USD',
              category: PayPalItemCategoryV2.physicalGoods,
              sku: 'SKU_ORANGE',
            ),
          ],
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
