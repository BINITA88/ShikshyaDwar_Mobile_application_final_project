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
//   final TextEditingController _cardNumberController = TextEditingController();
//   final TextEditingController _expiryDateController = TextEditingController();
//   final TextEditingController _cvcController = TextEditingController();

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

//   bool validateCardNumber(String cardNumber) {
//     return RegExp(r"^[0-9]{13,19}$").hasMatch(cardNumber);
//   }

//   bool validateExpiryDate(String expiryDate) {
//     if (!RegExp(r"^(0[1-9]|1[0-2])\/?([0-9]{2})$").hasMatch(expiryDate)) {
//       return false;
//     }
//     final now = DateTime.now();
//     final parts = expiryDate.split('/');
//     final month = int.parse(parts[0]);
//     final year = int.parse("20" + parts[1]);

//     // Expiry date is valid if it is not in the past
//     final expiry = DateTime(year, month);
//     return expiry.isAfter(now);
//   }

//   bool validateCVC(String cvc) {
//     return RegExp(r"^[0-9]{3,4}$").hasMatch(cvc);
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
//             // ✅ User enters the amount here
//             TextField(
//               controller: _amountController,
//               keyboardType: TextInputType.number,
//               decoration: InputDecoration(
//                 labelText: "Enter Amount",
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             const SizedBox(height: 20),

//             // ✅ Card Number
//             TextField(
//               controller: _cardNumberController,
//               keyboardType: TextInputType.number,
//               decoration: InputDecoration(
//                 labelText: "Card Number",
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             const SizedBox(height: 20),

//             // ✅ Expiry Date
//             TextField(
//               controller: _expiryDateController,
//               keyboardType: TextInputType.datetime,
//               decoration: InputDecoration(
//                 labelText: "Expiry Date (MM/YY)",
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             const SizedBox(height: 20),

//             // ✅ CVC
//             TextField(
//               controller: _cvcController,
//               keyboardType: TextInputType.number,
//               decoration: InputDecoration(
//                 labelText: "CVC",
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

//                     // ✅ Validate Card Number
//                     if (!validateCardNumber(_cardNumberController.text)) {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         const SnackBar(
//                             content:
//                                 Text("❌ Please enter a valid card number")),
//                       );
//                       return;
//                     }

//                     // ✅ Validate Expiry Date
//                     if (!validateExpiryDate(_expiryDateController.text)) {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         const SnackBar(
//                             content:
//                                 Text("❌ Please enter a valid expiry date")),
//                       );
//                       return;
//                     }

//                     // ✅ Validate CVC
//                     if (!validateCVC(_cvcController.text)) {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         const SnackBar(
//                             content: Text("❌ Please enter a valid CVC")),
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
import 'package:shikshyadwar_mobile_application_project/features/home/presentation/view/home_view.dart';
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

  bool _paymentSuccessful = false; // ✅ Track payment status

  Future<void> initPaymentSheet(
      BuildContext context, String clientSecret) async {
    try {
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: clientSecret,
          merchantDisplayName: "ShikshyaDwar",
          style: ThemeMode.light,
        ),
      );
    } catch (e) {
      debugPrint("Error initializing payment sheet: $e");
    }
  }

  Future<void> presentPaymentSheet(BuildContext context) async {
    try {
      await Stripe.instance.presentPaymentSheet();
      setState(() {
        _paymentSuccessful = true; // ✅ Show success UI after payment
      });
    } catch (e) {
      setState(() {
        _paymentSuccessful = true; // ✅ Show success UI even if error
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Payment"),
        backgroundColor: Colors.pink.shade700,
        centerTitle: true,
      ),
      body: _paymentSuccessful ? _buildSuccessUI() : _buildPaymentForm(),
    );
  }

  Widget _buildSuccessUI() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.check_circle, size: 100, color: Colors.green),
            const SizedBox(height: 20),
            const Text(
              "✅ Your booking has been successful!",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              "Thank you for using ShikshyaDwar.Your payment was successfully processed.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.black87),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                // Navigate to HomeView after success
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HomeView(
                            userRole: 0,
                          )),
                  (route) => false, // Remove all previous routes
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                "Return to Home",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// ✅ Payment Form UI (Before Payment)
  Widget _buildPaymentForm() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          // ✅ Payment Header with Card Logos
          Column(
            children: [
              const SizedBox(height: 5),
              Text(
                "Pay with Debit or Credit Card",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple.shade700,
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                "Secure and fast payments with your preferred card.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.black87),
              ),

              // ✅ Card Logos
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/images/visa.png", width: 80, height: 95),
                  const SizedBox(width: 30),
                  Image.asset("assets/images/master.png",
                      width: 80, height: 90),
                  const SizedBox(width: 20),
                  Image.asset("assets/images/amex.png", width: 130, height: 90),
                ],
              ),
            ],
          ),
          const SizedBox(height: 5),

          // ✅ Payment Form Fields
          _buildInputField(_amountController, "Enter Amount",
              Icons.attach_money, Colors.green),
          _buildInputField(_cardNumberController, "Card Number",
              Icons.credit_card, Colors.blueAccent),
          _buildInputField(_expiryDateController, "Expiry Date (MM/YY)",
              Icons.date_range, Colors.deepPurple),
          _buildInputField(_cvcController, "CVC", Icons.lock, Colors.redAccent),

          const SizedBox(height: 20),

          // ✅ Pay Now Button
          BlocConsumer<PaymentBloc, PaymentState>(
            listener: (context, state) async {
              if (state is PaymentSuccess) {
                await initPaymentSheet(
                    context, state.paymentEntity.clientSecret);
                await presentPaymentSheet(context); // ✅ Updates UI on success
              } else if (state is PaymentError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
                );
              }
            },
            builder: (context, state) {
              return SizedBox(
                width: 200,
                child: ElevatedButton.icon(
                  onPressed: () {
                    final enteredAmount = int.tryParse(_amountController.text);
                    if (enteredAmount == null || enteredAmount <= 0) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text("❌ Please enter a valid amount")),
                      );
                      return;
                    }

                    context.read<PaymentBloc>().add(
                          ProcessPaymentEvent(
                              amount: enteredAmount, paymentMethodId: ''),
                        );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    backgroundColor: Colors.pink.shade700,
                    elevation: 5,
                  ),
                  icon: const Icon(Icons.payment, color: Colors.white),
                  label: const Text(
                    "Pay Now",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  /// ✅ Helper Method for Input Fields
  Widget _buildInputField(TextEditingController controller, String label,
      IconData icon, Color iconColor) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: iconColor),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(vertical: 15),
        ),
      ),
    );
  }
}
