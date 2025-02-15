// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_stripe/flutter_stripe.dart';
// import 'package:shikshyadwar_mobile_application_project/features/payment/presentation/payment_bloc.dart';
// import 'package:shikshyadwar_mobile_application_project/features/payment/presentation/payment_event.dart';
// import 'package:shikshyadwar_mobile_application_project/features/payment/presentation/payment_state.dart';

// class PaymentScreen extends StatefulWidget {
//   @override
//   _PaymentScreenState createState() => _PaymentScreenState();
// }

// class _PaymentScreenState extends State<PaymentScreen> {
//   final TextEditingController _amountController = TextEditingController();

//   Future<void> initPaymentSheet(String clientSecret) async {
//     try {
//       await Stripe.instance.initPaymentSheet(
//         paymentSheetParameters: SetupPaymentSheetParameters(
//           paymentIntentClientSecret: clientSecret,
//           merchantDisplayName: "Your Business Name",
//           style: ThemeMode.light,
//         ),
//       );
//       print("Payment Sheet initialized successfully");
//     } catch (e) {
//       print("Error initializing payment sheet: $e");
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Error initializing payment: $e")),
//       );
//     }
//   }

//   Future<void> presentPaymentSheet() async {
//     try {
//       await Stripe.instance.presentPaymentSheet();
//       print("Payment Successful!");

//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("✅ Payment Successful!")),
//       );
//     } catch (e) {
//       print("Error presenting payment sheet: $e");

//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("❌ Payment Failed: $e")),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Stripe Payment")),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             // ✅ User enters the price here
//             TextField(
//               controller: _amountController,
//               keyboardType: TextInputType.number,
//               decoration: InputDecoration(
//                 labelText: "Enter Amount",
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             const SizedBox(height: 20),

//             BlocConsumer<PaymentBloc, PaymentState>(
//               listener: (context, state) async {
//                 if (state is PaymentSuccess) {
//                   await initPaymentSheet(state.paymentEntity.clientSecret);

//                   await presentPaymentSheet();
//                 } else if (state is PaymentError) {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(content: Text(state.message)),
//                   );
//                 }
//               },
//               builder: (context, state) {
//                 return ElevatedButton(
//                   onPressed: () {
//                     // ✅ Validate amount before proceeding
//                     final enteredAmount = int.tryParse(_amountController.text);
//                     if (enteredAmount == null || enteredAmount <= 0) {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         const SnackBar(
//                             content: Text("❌ Please enter a valid amount")),
//                       );
//                       return;
//                     }

//                     // ✅ Trigger payment event with entered amount
//                     context.read<PaymentBloc>().add(
//                           ProcessPaymentEvent(
//                               amount: enteredAmount, paymentMethodId: ''),
//                         );
//                   },
//                   child: const Text("Pay Now"),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:shikshyadwar_mobile_application_project/features/payment/presentation/payment_bloc.dart';
import 'package:shikshyadwar_mobile_application_project/features/payment/presentation/payment_event.dart';
import 'package:shikshyadwar_mobile_application_project/features/payment/presentation/payment_state.dart';

class PaymentScreen extends StatefulWidget {
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();
  final TextEditingController _cvcController = TextEditingController();

  Future<void> initPaymentSheet(String clientSecret) async {
    try {
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: clientSecret,
          merchantDisplayName: "Your Business Name",
          style: ThemeMode.light,
        ),
      );
      print("Payment Sheet initialized successfully");
    } catch (e) {
      print("Error initializing payment sheet: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error initializing payment: $e")),
      );
    }
  }

  Future<void> presentPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet();
      print("Payment Successful!");

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("✅ Payment Successful!")),
      );
    } catch (e) {
      print("Error presenting payment sheet: $e");

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("❌ Payment Failed: $e")),
      );
    }
  }

  bool validateCardNumber(String cardNumber) {
    return RegExp(r"^[0-9]{13,19}$").hasMatch(cardNumber);
  }

  bool validateExpiryDate(String expiryDate) {
    if (!RegExp(r"^(0[1-9]|1[0-2])\/?([0-9]{2})$").hasMatch(expiryDate)) {
      return false;
    }
    final now = DateTime.now();
    final parts = expiryDate.split('/');
    final month = int.parse(parts[0]);
    final year = int.parse("20" + parts[1]);

    // Expiry date is valid if it is not in the past
    final expiry = DateTime(year, month);
    return expiry.isAfter(now);
  }

  bool validateCVC(String cvc) {
    return RegExp(r"^[0-9]{3,4}$").hasMatch(cvc);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Stripe Payment")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ✅ User enters the amount here
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Enter Amount",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            // ✅ Card Number
            TextField(
              controller: _cardNumberController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Card Number",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            // ✅ Expiry Date
            TextField(
              controller: _expiryDateController,
              keyboardType: TextInputType.datetime,
              decoration: InputDecoration(
                labelText: "Expiry Date (MM/YY)",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            // ✅ CVC
            TextField(
              controller: _cvcController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "CVC",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            BlocConsumer<PaymentBloc, PaymentState>(
              listener: (context, state) async {
                if (state is PaymentSuccess) {
                  await initPaymentSheet(state.paymentEntity.clientSecret);

                  await presentPaymentSheet();
                } else if (state is PaymentError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.message)),
                  );
                }
              },
              builder: (context, state) {
                return ElevatedButton(
                  onPressed: () {
                    // ✅ Validate amount before proceeding
                    final enteredAmount = int.tryParse(_amountController.text);
                    if (enteredAmount == null || enteredAmount <= 0) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text("❌ Please enter a valid amount")),
                      );
                      return;
                    }

                    // ✅ Validate Card Number
                    if (!validateCardNumber(_cardNumberController.text)) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content:
                                Text("❌ Please enter a valid card number")),
                      );
                      return;
                    }

                    // ✅ Validate Expiry Date
                    if (!validateExpiryDate(_expiryDateController.text)) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content:
                                Text("❌ Please enter a valid expiry date")),
                      );
                      return;
                    }

                    // ✅ Validate CVC
                    if (!validateCVC(_cvcController.text)) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text("❌ Please enter a valid CVC")),
                      );
                      return;
                    }

                    // ✅ Trigger payment event with entered amount
                    context.read<PaymentBloc>().add(
                          ProcessPaymentEvent(
                              amount: enteredAmount, paymentMethodId: ''),
                        );
                  },
                  child: const Text("Pay Now"),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
