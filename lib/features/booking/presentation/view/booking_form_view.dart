import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shikshyadwar_mobile_application_project/features/booking/domain/entity/bookings_entity.dart';
import 'package:shikshyadwar_mobile_application_project/features/booking/presentation/view_model/booking/booking_bloc.dart';
import 'package:shikshyadwar_mobile_application_project/features/booking/presentation/view_model/booking/booking_event.dart';
import 'package:shikshyadwar_mobile_application_project/features/booking/presentation/view_model/booking/booking_state.dart';

class BookingFormView extends StatefulWidget {
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
  bool? _interestedInCounseling = false;

  final List<String> _classModes = ["Online", "Offline"];
  final List<String> _shifts = ["Morning", "Afternoon", "Evening"];

  void _submitBooking(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      final booking = BookingsEntity(
        bookId: null, // Backend generates ID
        Address: _addressController.text.trim().isEmpty
            ? null
            : _addressController.text.trim(), // ✅ Null if empty
        city: _cityController.text.trim(),
        country: _countryController.text.trim(),
        shift: _selectedShift, // ✅ Store dropdown selection
        classMode: _selectedClassMode, // ✅ Store dropdown selection
        interestedInCounseling:
            _interestedInCounseling ?? false, // ✅ Default to false if null
      );

      BlocProvider.of<BookingBloc>(context)
          .add(CreateBookingEvent(booking: booking));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<BookingBloc, BookingState>(
        listener: (context, state) {
          if (state is BookingCreated) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("✅ Booking created successfully!")),
            );
            Navigator.pop(context); // Close form after success
          } else if (state is BookingError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("❌ Error: ${state.message}")),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                // Address
                TextFormField(
                  controller: _addressController,
                  decoration: InputDecoration(
                    labelText: "Address",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                // City
                TextFormField(
                  controller: _cityController,
                  decoration: InputDecoration(
                    labelText: "City",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) =>
                      value!.isEmpty ? "City is required" : null,
                ),
                const SizedBox(height: 10),

                // Country
                TextFormField(
                  controller: _countryController,
                  decoration: InputDecoration(
                    labelText: "Country",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) =>
                      value!.isEmpty ? "Country is required" : null,
                ),
                const SizedBox(height: 10),

                // Shift Dropdown
                DropdownButtonFormField<String>(
                  value: _selectedShift,
                  decoration: InputDecoration(
                    labelText: "Select Shift",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  items: _shifts.map((shift) {
                    return DropdownMenuItem(
                      value: shift,
                      child: Text(shift),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedShift = value;
                    });
                  },
                  validator: (value) =>
                      value == null ? "Please select a shift" : null,
                ),
                const SizedBox(height: 10),

                // Class Mode Dropdown
                DropdownButtonFormField<String>(
                  value: _selectedClassMode,
                  decoration: InputDecoration(
                    labelText: "Class Mode",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  items: _classModes.map((mode) {
                    return DropdownMenuItem(
                      value: mode,
                      child: Text(mode),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedClassMode = value;
                    });
                  },
                  validator: (value) =>
                      value == null ? "Please select a class mode" : null,
                ),
                const SizedBox(height: 10),

                // Interested in Counseling Switch
                SwitchListTile(
                  title: const Text("Interested in Counseling?"),
                  value: _interestedInCounseling ?? false,
                  onChanged: (value) {
                    setState(() {
                      _interestedInCounseling = value;
                    });
                  },
                ),
                const SizedBox(height: 20),

                // Submit Button
                ElevatedButton(
                  onPressed: () => _submitBooking(context),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    "Submit Booking",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
