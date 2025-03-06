// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:get_it/get_it.dart';
// import 'package:shikshyadwar_mobile_application_project/app/di/di.dart';
// import 'package:shikshyadwar_mobile_application_project/features/booking/domain/entity/bookings_entity.dart';
// import 'package:shikshyadwar_mobile_application_project/features/booking/domain/use_case/create_booking_usecase.dart';
// import 'package:shikshyadwar_mobile_application_project/features/booking/presentation/view_model/booking/booking_bloc.dart';
// import 'package:shikshyadwar_mobile_application_project/features/booking/presentation/view_model/booking/booking_event.dart';
// import 'package:shikshyadwar_mobile_application_project/features/booking/presentation/view_model/booking/booking_state.dart';
// import 'package:shikshyadwar_mobile_application_project/features/payment/presentation/payment_bloc.dart';
// import 'package:shikshyadwar_mobile_application_project/features/payment/presentation/view/payment_screen.dart';

// class BookingFormView extends StatefulWidget {
//   @override
//   _BookingFormViewState createState() => _BookingFormViewState();
// }

// class _BookingFormViewState extends State<BookingFormView> {
//   final _formKey = GlobalKey<FormState>();

//   final TextEditingController _addressController = TextEditingController();
//   final TextEditingController _cityController = TextEditingController();
//   final TextEditingController _countryController = TextEditingController();

//   String? _selectedClassMode;
//   String? _selectedShift;
//   bool? _interestedInCounseling = false;

//   final List<String> _classModes = ["Online", "Offline"];
//   final List<String> _shifts = ["Morning", "Afternoon", "Evening"];

//   void _submitBooking(BuildContext context) {
//     if (_formKey.currentState!.validate()) {
//       final booking = BookingsEntity(
//         bookId: null, // Backend generates ID
//         Address: _addressController.text.trim().isEmpty
//             ? null
//             : _addressController.text.trim(), // ✅ Null if empty
//         city: _cityController.text.trim(),
//         country: _countryController.text.trim(),
//         shift: _selectedShift, // ✅ Store dropdown selection
//         classMode: _selectedClassMode, // ✅ Store dropdown selection
//         interestedInCounseling:
//             _interestedInCounseling ?? false, // ✅ Default to false if null
//       );

//       BlocProvider.of<BookingBloc>(context)
//           .add(CreateBookingEvent(booking: booking));
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         // ✅ Added AppBar
//         title: const Text("Book Your Course"),
//         centerTitle: true,
//       ),
//       body: BlocListener<BookingBloc, BookingState>(
//         listener: (context, state) {
//           if (state is BookingCreated) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               const SnackBar(content: Text("✅ Booking created successfully!")),
//             );
//             Navigator.pop(context); // Close form after success
//           } else if (state is BookingError) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(content: Text("❌ Error: ${state.message}")),
//             );
//           }
//         },
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Form(
//             key: _formKey,
//             child: ListView(
//               children: [
//                 // Address
//                 TextFormField(
//                   controller: _addressController,
//                   decoration: InputDecoration(
//                     labelText: "Address",
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 10),

//                 // City
//                 TextFormField(
//                   controller: _cityController,
//                   decoration: InputDecoration(
//                     labelText: "City",
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                   ),
//                   validator: (value) =>
//                       value!.isEmpty ? "City is required" : null,
//                 ),
//                 const SizedBox(height: 10),

//                 // Country
//                 TextFormField(
//                   controller: _countryController,
//                   decoration: InputDecoration(
//                     labelText: "Country",
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                   ),
//                   validator: (value) =>
//                       value!.isEmpty ? "Country is required" : null,
//                 ),
//                 const SizedBox(height: 10),

//                 // Shift Dropdown
//                 DropdownButtonFormField<String>(
//                   value: _selectedShift,
//                   decoration: InputDecoration(
//                     labelText: "Select Shift",
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                   ),
//                   items: _shifts.map((shift) {
//                     return DropdownMenuItem(
//                       value: shift,
//                       child: Text(shift),
//                     );
//                   }).toList(),
//                   onChanged: (value) {
//                     setState(() {
//                       _selectedShift = value;
//                     });
//                   },
//                   validator: (value) =>
//                       value == null ? "Please select a shift" : null,
//                 ),
//                 const SizedBox(height: 10),

//                 // Class Mode Dropdown
//                 DropdownButtonFormField<String>(
//                   value: _selectedClassMode,
//                   decoration: InputDecoration(
//                     labelText: "Class Mode",
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                   ),
//                   items: _classModes.map((mode) {
//                     return DropdownMenuItem(
//                       value: mode,
//                       child: Text(mode),
//                     );
//                   }).toList(),
//                   onChanged: (value) {
//                     setState(() {
//                       _selectedClassMode = value;
//                     });
//                   },
//                   validator: (value) =>
//                       value == null ? "Please select a class mode" : null,
//                 ),
//                 const SizedBox(height: 10),

//                 // Interested in Counseling Switch
//                 SwitchListTile(
//                   title: const Text("Interested in Counseling?"),
//                   value: _interestedInCounseling ?? false,
//                   onChanged: (value) {
//                     setState(() {
//                       _interestedInCounseling = value;
//                     });
//                   },
//                 ),
//                 const SizedBox(height: 20),

//                ElevatedButton(
//                       onPressed: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => BlocProvider(
//                               create: (context) => PaymentBloc(processPaymentUseCase: getIt(), getStripeApiKeyUseCase: getIt(),
//                                 // ✅ Correctly provide use case
//                               ),
//                               child: PaymentScreen(),
//                             ),
//                           ),
//                         );
//                       },
//                       style: ElevatedButton.styleFrom(
//                         padding: const EdgeInsets.symmetric(
//                             vertical: 16, horizontal: 32),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                       ),
//                       child: const Text(
//                         "Submit Booking",
//                         style: TextStyle(fontSize: 18),
//                       ),
//                     ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:get_it/get_it.dart';
// import 'package:shikshyadwar_mobile_application_project/app/di/di.dart';
// import 'package:shikshyadwar_mobile_application_project/features/booking/domain/entity/bookings_entity.dart';
// import 'package:shikshyadwar_mobile_application_project/features/booking/domain/use_case/create_booking_usecase.dart';
// import 'package:shikshyadwar_mobile_application_project/features/booking/presentation/view_model/booking/booking_bloc.dart';
// import 'package:shikshyadwar_mobile_application_project/features/booking/presentation/view_model/booking/booking_event.dart';
// import 'package:shikshyadwar_mobile_application_project/features/booking/presentation/view_model/booking/booking_state.dart';
// import 'package:shikshyadwar_mobile_application_project/features/payment/presentation/payment_bloc.dart';
// import 'package:shikshyadwar_mobile_application_project/features/payment/presentation/view/payment_screen.dart';

// class BookingFormView extends StatefulWidget {
//   @override
//   _BookingFormViewState createState() => _BookingFormViewState();
// }

// class _BookingFormViewState extends State<BookingFormView> {
//   final _formKey = GlobalKey<FormState>();

//   final TextEditingController _addressController = TextEditingController();
//   final TextEditingController _cityController = TextEditingController();
//   final TextEditingController _countryController = TextEditingController();

//   String? _selectedClassMode;
//   String? _selectedShift;
//   bool? _interestedInCounseling = false;

//   final List<String> _classModes = ["Online", "Offline"];
//   final List<String> _shifts = ["Morning", "Afternoon", "Evening"];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Book Your Course"),
//         backgroundColor: Colors.pink.shade700, // Pink 700 Navbar
//         centerTitle: true,
//       ),
//       body: BlocListener<BookingBloc, BookingState>(
//         listener: (context, state) {
//           if (state is BookingCreated) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               const SnackBar(content: Text("✅ Booking created successfully!")),
//             );
//             Navigator.pop(context);
//           } else if (state is BookingError) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(content: Text("❌ Error: ${state.message}")),
//             );
//           }
//         },
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             children: [
//               // ✅ Header with Icon and Text
//               Column(
//                 children: [
//                   const Icon(Icons.school,
//                       color: Color.fromARGB(255, 62, 20, 146), size: 50),
//                   const SizedBox(height: 10),
//                   Text(
//                     "Enroll in Your Favorite Course!",
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       fontSize: 22,
//                       fontWeight: FontWeight.bold,
//                       color: const Color.fromARGB(255, 5, 5, 5),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 20),

//               // ✅ Booking Form
//               Form(
//                 key: _formKey,
//                 child: Column(
//                   children: [
//                     _buildInputField(
//                         controller: _addressController,
//                         label: "Address",
//                         icon: Icons.home,
//                         iconColor: Colors.orange),
//                     _buildInputField(
//                         controller: _cityController,
//                         label: "City",
//                         icon: Icons.location_city,
//                         iconColor: Colors.green,
//                         isRequired: true),
//                     _buildInputField(
//                         controller: _countryController,
//                         label: "Country",
//                         icon: Icons.public,
//                         iconColor: Colors.purple,
//                         isRequired: true),

//                     // ✅ Shift Dropdown
//                     _buildDropdown(
//                       label: "Select Shift",
//                       value: _selectedShift,
//                       icon: Icons.access_time,
//                       iconColor: Colors.red,
//                       items: _shifts,
//                       onChanged: (value) {
//                         setState(() {
//                           _selectedShift = value;
//                         });
//                       },
//                     ),

//                     // ✅ Class Mode Dropdown
//                     _buildDropdown(
//                       label: "Class Mode",
//                       value: _selectedClassMode,
//                       icon: Icons.computer,
//                       iconColor: Colors.blue,
//                       items: _classModes,
//                       onChanged: (value) {
//                         setState(() {
//                           _selectedClassMode = value;
//                         });
//                       },
//                     ),

//                     // ✅ Interested in Counseling Switch
//                     SwitchListTile(
//                       title: const Text(
//                         "Interested in Counseling?",
//                         style: TextStyle(fontSize: 16),
//                       ),
//                       activeColor: Colors.pink.shade700,
//                       value: _interestedInCounseling ?? false,
//                       onChanged: (value) {
//                         setState(() {
//                           _interestedInCounseling = value;
//                         });
//                       },
//                     ),
//                     const SizedBox(height: 20),

//                     // ✅ Submit Booking Button
//                     SizedBox(
//                       width: 220, // Increased width for better appearance
//                       child: ElevatedButton.icon(
//                         onPressed: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => BlocProvider(
//                                 create: (context) => PaymentBloc(
//                                   processPaymentUseCase: getIt(),
//                                   getStripeApiKeyUseCase: getIt(),
//                                 ),
//                                 child: PaymentScreen(),
//                               ),
//                             ),
//                           );
//                         },
//                         style: ElevatedButton.styleFrom(
//                           padding: const EdgeInsets.symmetric(vertical: 14),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                           backgroundColor:
//                               const Color.fromARGB(255, 194, 92, 24),
//                           elevation: 5,
//                         ),
//                         icon: const Icon(Icons.payment, color: Colors.white),
//                         label: const Text(
//                           "Submit Booking",
//                           style: TextStyle(
//                               fontSize: 18, fontWeight: FontWeight.bold),
//                         ),
//                       ),
//                     ),

//                     const SizedBox(height: 20),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   // ✅ Helper Method for Input Fields
//   Widget _buildInputField({
//     required TextEditingController controller,
//     required String label,
//     required IconData icon,
//     required Color iconColor,
//     bool isRequired = false,
//   }) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 12.0),
//       child: TextFormField(
//         controller: controller,
//         decoration: InputDecoration(
//           labelText: label,
//           prefixIcon: Icon(icon, color: iconColor),
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(10),
//           ),
//           filled: true,
//           fillColor: Colors.white,
//           contentPadding: const EdgeInsets.symmetric(vertical: 15),
//         ),
//         validator: isRequired
//             ? (value) => value!.isEmpty ? "$label is required" : null
//             : null,
//       ),
//     );
//   }

//   // ✅ Helper Method for Dropdowns
//   Widget _buildDropdown({
//     required String label,
//     required String? value,
//     required IconData icon,
//     required Color iconColor,
//     required List<String> items,
//     required void Function(String?) onChanged,
//   }) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 12.0),
//       child: DropdownButtonFormField<String>(
//         value: value,
//         decoration: InputDecoration(
//           labelText: label,
//           prefixIcon: Icon(icon, color: iconColor),
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(10),
//           ),
//           filled: true,
//           fillColor: Colors.white,
//         ),
//         items: items.map((item) {
//           return DropdownMenuItem(
//             value: item,
//             child: Text(item),
//           );
//         }).toList(),
//         onChanged: onChanged,
//         validator: (value) => value == null ? "Please select $label" : null,
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shikshyadwar_mobile_application_project/app/di/di.dart';
import 'package:shikshyadwar_mobile_application_project/features/booking/domain/entity/bookings_entity.dart';
import 'package:shikshyadwar_mobile_application_project/features/booking/presentation/view_model/booking/booking_bloc.dart';
import 'package:shikshyadwar_mobile_application_project/features/booking/presentation/view_model/booking/booking_event.dart';
import 'package:shikshyadwar_mobile_application_project/features/booking/presentation/view_model/booking/booking_state.dart';
import 'package:shikshyadwar_mobile_application_project/features/payment/presentation/payment_bloc.dart';
import 'package:shikshyadwar_mobile_application_project/features/payment/presentation/view/payment_screen.dart';

class BookingFormView extends StatefulWidget {
  const BookingFormView({super.key});

  @override
  _BookingFormViewState createState() => _BookingFormViewState();
}

class _BookingFormViewState extends State<BookingFormView> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();

  String? _selectedClassMode;
  String? _selectedShift;
  bool _interestedInCounseling = false;

  final List<String> _classModes = ["Online", "Offline"];
  final List<String> _shifts = ["Morning", "Afternoon", "Evening"];

  /// ✅ Submit Booking Method
  void _submitBooking(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      final booking = BookingsEntity(
        bookId: null, // Backend generates ID
        Address: _addressController.text.trim().isEmpty
            ? null
            : _addressController.text.trim(),
        city: _cityController.text.trim(),
        country: _countryController.text.trim(),
        shift: _selectedShift,
        classMode: _selectedClassMode,
        interestedInCounseling: _interestedInCounseling,
      );

      BlocProvider.of<BookingBloc>(context)
          .add(CreateBookingEvent(booking: booking));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<BookingBloc>(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Book Your Course"),
          backgroundColor: Colors.pink.shade700, // Pink 700 Navbar
          centerTitle: true,
        ),
        body: BlocListener<BookingBloc, BookingState>(
          listener: (context, state) {
            if (state is BookingCreated) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text("✅ Booking created successfully!")),
              );
              Navigator.pop(context);
            } else if (state is BookingError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("❌ Error: ${state.message}")),
              );
            }
          },
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // ✅ Header with Icon and Text
                Column(
                  children: [
                    const Icon(Icons.school,
                        color: Color.fromARGB(255, 62, 20, 146), size: 50),
                    const SizedBox(height: 10),
                    Text(
                      "Enroll in Your Favorite Course!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 5, 5, 5),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // ✅ Booking Form
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      _buildInputField(
                          controller: _addressController,
                          label: "Address",
                          icon: Icons.home,
                          iconColor: Colors.orange),
                      _buildInputField(
                          controller: _cityController,
                          label: "City",
                          icon: Icons.location_city,
                          iconColor: Colors.green,
                          isRequired: true),
                      _buildInputField(
                          controller: _countryController,
                          label: "Country",
                          icon: Icons.public,
                          iconColor: Colors.purple,
                          isRequired: true),

                      // ✅ Shift Dropdown
                      _buildDropdown(
                        label: "Select Shift",
                        value: _selectedShift,
                        icon: Icons.access_time,
                        iconColor: Colors.red,
                        items: _shifts,
                        onChanged: (value) {
                          setState(() {
                            _selectedShift = value;
                          });
                        },
                      ),

                      // ✅ Class Mode Dropdown
                      _buildDropdown(
                        label: "Class Mode",
                        value: _selectedClassMode,
                        icon: Icons.computer,
                        iconColor: Colors.blue,
                        items: _classModes,
                        onChanged: (value) {
                          setState(() {
                            _selectedClassMode = value;
                          });
                        },
                      ),

                      // ✅ Interested in Counseling Switch
                      SwitchListTile(
                        title: const Text(
                          "Interested in Counseling?",
                          style: TextStyle(fontSize: 16),
                        ),
                        activeColor: Colors.pink.shade700,
                        value: _interestedInCounseling ?? false,
                        onChanged: (value) {
                          setState(() {
                            _interestedInCounseling = value;
                          });
                        },
                      ),
                      const SizedBox(height: 20),

                      // ✅ Submit Booking Button
                      SizedBox(
                        width: 220, // Increased width for better appearance
                        child: ElevatedButton.icon(
                          onPressed: () {
                            _submitBooking(context);

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BlocProvider(
                                  create: (context) => PaymentBloc(
                                    processPaymentUseCase: getIt(),
                                    // getStripeApiKeyUseCase: getIt(),
                                  ),
                                  child: PaymentScreen(),
                                ),
                              ),
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
                            "Submit Booking",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

//   // ✅ Helper Method for Input Fields
  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required Color iconColor,
    bool isRequired = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: TextFormField(
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
        validator: isRequired
            ? (value) => value!.isEmpty ? "$label is required" : null
            : null,
      ),
    );
  }

  // ✅ Helper Method for Dropdowns
  Widget _buildDropdown({
    required String label,
    required String? value,
    required IconData icon,
    required Color iconColor,
    required List<String> items,
    required void Function(String?) onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: DropdownButtonFormField<String>(
        value: value,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: iconColor),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
        items: items.map((item) {
          return DropdownMenuItem(
            value: item,
            child: Text(item),
          );
        }).toList(),
        onChanged: onChanged,
        validator: (value) => value == null ? "Please select $label" : null,
      ),
    );
  }
}
