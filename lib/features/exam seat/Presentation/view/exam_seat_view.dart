// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:shikshyadwar_mobile_application_project/app/di/di.dart';
// import 'package:shikshyadwar_mobile_application_project/features/exam%20seat/Presentation/exam_seat_bloc.dart';
// import 'package:shikshyadwar_mobile_application_project/features/exam%20seat/Presentation/exam_seat_event.dart';
// import 'package:shikshyadwar_mobile_application_project/features/exam%20seat/Presentation/exam_seat_state.dart';
// import 'package:shikshyadwar_mobile_application_project/features/exam%20seat/domain/entity/exam_seat_entity.dart';

// class ExamSeatScreen extends StatelessWidget {
//   const ExamSeatScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) {
//         final bloc = getIt<ExamSeatBloc>();
//         bloc.add(GetExamSeatsEvent());
//         return bloc;
//       },
//       child: Scaffold(
//         backgroundColor: Colors.black,
//         body: SafeArea(
//           child: Column(
//             children: [
//               // Title Section
//               Container(
//                 padding: const EdgeInsets.all(24),
//                 child: const Text(
//                   'Mock Test Seat Booking',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 32,
//                     fontWeight: FontWeight.bold,
//                     shadows: [
//                       Shadow(
//                         color: Colors.white24,
//                         blurRadius: 15,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),

//               // Test Details Section
//               Container(
//                 margin: const EdgeInsets.symmetric(horizontal: 20),
//                 padding: const EdgeInsets.all(16),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Row(
//                   children: [
//                     const Icon(Icons.calendar_today, color: Colors.black),
//                     const SizedBox(width: 12),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: const [
//                         Text(
//                           'Next Mock Test',
//                           style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                         Text(
//                           'This Saturday - 9:00 AM',
//                           style: TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.blue,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),

//               const SizedBox(height: 30),
//               const Text(
//                 'CHOOSE YOUR SEAT',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 20,
//                   letterSpacing: 2,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               const SizedBox(height: 20),

//               // Screen Indicator
//               Container(
//                 margin: const EdgeInsets.symmetric(horizontal: 40),
//                 height: 40,
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     colors: [
//                       Colors.blue.withOpacity(0.1),
//                       Colors.blue.withOpacity(0.3),
//                     ],
//                   ),
//                   borderRadius: BorderRadius.circular(5),
//                 ),
//                 child: const Center(
//                   child: Text(
//                     'EXAMINATION SCREEN',
//                     style: TextStyle(
//                       color: Colors.white60,
//                       fontSize: 12,
//                       letterSpacing: 3,
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 30),

//               // Seat Grid
//               Expanded(
//                 child: BlocBuilder<ExamSeatBloc, ExamSeatState>(
//                   builder: (context, state) {
//                     if (state is ExamSeatLoading) {
//                       return const Center(
//                         child: CircularProgressIndicator(color: Colors.white),
//                       );
//                     } else if (state is ExamSeatLoaded) {
//                       return ExamSeatGrid(
//                         seats: state.seats,
//                         onSeatBooked: () => _showBookingConfirmation(context),
//                       );
//                     } else if (state is ExamSeatError) {
//                       return Center(
//                         child: Text(
//                           state.message,
//                           style: const TextStyle(color: Colors.red),
//                         ),
//                       );
//                     }
//                     return const Center(
//                       child: Text(
//                         'No seats available',
//                         style: TextStyle(color: Colors.white),
//                       ),
//                     );
//                   },
//                 ),
//               ),

//               // Legend
//               Container(
//                 margin: const EdgeInsets.all(20),
//                 padding: const EdgeInsets.all(16),
//                 decoration: BoxDecoration(
//                   color: Colors.white.withOpacity(0.1),
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     _buildLegendItem(
//                       color: const Color.fromARGB(255, 124, 211, 227),
//                       label: 'Available',
//                     ),
//                     _buildLegendItem(
//                       color: Colors.green,
//                       label: 'Selected',
//                     ),
//                     _buildLegendItem(
//                       color: const Color.fromARGB(255, 123, 14, 14),
//                       label: 'Occupied',
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildLegendItem({required Color color, required String label}) {
//     return Row(
//       children: [
//         Container(
//           width: 24,
//           height: 24,
//           decoration: BoxDecoration(
//             color: color,
//             borderRadius: BorderRadius.circular(4),
//           ),
//         ),
//         const SizedBox(width: 8),
//         Text(
//           label,
//           style: const TextStyle(
//             color: Colors.white,
//             fontSize: 14,
//           ),
//         ),
//       ],
//     );
//   }

//   void _showBookingConfirmation(BuildContext context) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Row(
//           children: const [
//             Icon(Icons.check_circle, color: Colors.white),
//             SizedBox(width: 12),
//             Text('Your seat for this Saturday has been booked!'),
//           ],
//         ),
//         duration: const Duration(seconds: 3),
//         behavior: SnackBarBehavior.floating,
//         backgroundColor: Colors.green,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(10),
//         ),
//       ),
//     );
//   }
// }

// // Updated SeatPainter
// class SeatPainter extends CustomPainter {
//   final bool isBooked;

//   SeatPainter({required this.isBooked});

//   @override
//   void paint(Canvas canvas, Size size) {
//     final Paint seatPaint = Paint()
//       ..color = isBooked
//           ? const Color.fromARGB(255, 123, 14, 14)
//           : const Color.fromARGB(255, 124, 211, 227)
//       ..style = PaintingStyle.fill;

//     final Paint shadowPaint = Paint()
//       ..color = Colors.black.withOpacity(0.3)
//       ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3);

//     final double seatWidth = size.width * 0.85;
//     final double seatHeight = size.height * 0.85;
//     final double seatX = (size.width - seatWidth) / 2;
//     final double seatY = (size.height - seatHeight) / 2;

//     // Draw shadow
//     canvas.drawRRect(
//       RRect.fromRectAndRadius(
//         Rect.fromLTWH(seatX + 2, seatY + 2, seatWidth, seatHeight),
//         const Radius.circular(8),
//       ),
//       shadowPaint,
//     );

//     // Draw seat
//     canvas.drawRRect(
//       RRect.fromRectAndRadius(
//         Rect.fromLTWH(seatX, seatY, seatWidth, seatHeight),
//         const Radius.circular(8),
//       ),
//       seatPaint,
//     );
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) => false;
// }

// // Updated ExamSeatGrid
// class ExamSeatGrid extends StatelessWidget {
//   final List<ExamSeatEntity> seats;
//   final VoidCallback onSeatBooked;

//   const ExamSeatGrid({
//     Key? key,
//     required this.seats,
//     required this.onSeatBooked,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return GridView.builder(
//       padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
//       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 8,
//         crossAxisSpacing: 8,
//         mainAxisSpacing: 8,
//         childAspectRatio: 1,
//       ),
//       itemCount: seats.length,
//       itemBuilder: (context, index) {
//         final seat = seats[index];
//         return GestureDetector(
//           onTap: () {
//             if (!seat.booked && seat.examSeatId != null) {
//               context
//                   .read<ExamSeatBloc>()
//                   .add(BookExamSeatEvent(seat.examSeatId!));
//               onSeatBooked();
//             }
//           },
//           child: CustomPaint(
//             painter: SeatPainter(isBooked: seat.booked),
//             child: Center(
//               child: Text(
//                 (index + 1).toString(),
//                 style: TextStyle(
//                   color: seat.booked ? Colors.white60 : Colors.black87,
//                   fontSize: 12,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:shikshyadwar_mobile_application_project/app/di/di.dart';
// import 'package:shikshyadwar_mobile_application_project/features/exam%20seat/Presentation/exam_seat_bloc.dart';
// import 'package:shikshyadwar_mobile_application_project/features/exam%20seat/Presentation/exam_seat_event.dart';
// import 'package:shikshyadwar_mobile_application_project/features/exam%20seat/Presentation/exam_seat_state.dart';
// import 'package:shikshyadwar_mobile_application_project/features/exam%20seat/domain/entity/exam_seat_entity.dart';
// import 'package:shikshyadwar_mobile_application_project/features/payment/presentation/payment_bloc.dart';
// import 'package:shikshyadwar_mobile_application_project/features/payment/presentation/view/payment_screen.dart';

// class ExamSeatScreen extends StatelessWidget {
//   const ExamSeatScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) {
//         final bloc = getIt<ExamSeatBloc>();
//         bloc.add(GetExamSeatsEvent());
//         return bloc;
//       },
//       child: Scaffold(
//         backgroundColor: const Color.fromARGB(255, 244, 235, 238),
//         body: SafeArea(
//           child: Column(
//             children: [
//               // Title Section
//               Container(
//                 padding: const EdgeInsets.all(24),
//                 child: const Text(
//                   'Mock Test Seat Booking',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 32,
//                     fontWeight: FontWeight.bold,
//                     letterSpacing: 1.5,
//                     shadows: [
//                       Shadow(
//                         color: Colors.white24,
//                         blurRadius: 15,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),

//               // Test Details Section
//               Container(
//                 margin: const EdgeInsets.symmetric(horizontal: 20),
//                 padding: const EdgeInsets.all(16),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Row(
//                   children: [
//                     const Icon(Icons.calendar_today, color: Colors.black),
//                     const SizedBox(width: 12),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: const [
//                         Text(
//                           'Next Mock Test',
//                           style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                         Text(
//                           'This Saturday - 9:00 AM',
//                           style: TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.blue,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),

//               const SizedBox(height: 30),
//               const Text(
//                 'CHOOSE YOUR SEAT',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 20,
//                   letterSpacing: 2,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               const SizedBox(height: 20),

//               // Screen Indicator
//               Container(
//                 margin: const EdgeInsets.symmetric(horizontal: 40),
//                 height: 40,
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     colors: [
//                       Colors.blue.withOpacity(0.2),
//                       Colors.blue.withOpacity(0.4),
//                     ],
//                   ),
//                   borderRadius: BorderRadius.circular(5),
//                 ),
//                 child: const Center(
//                   child: Text(
//                     'EXAMINATION SCREEN',
//                     style: TextStyle(
//                       color: Colors.white70,
//                       fontSize: 14,
//                       letterSpacing: 3,
//                     ),
//                   ),
//                 ),
//               ),

//               const SizedBox(height: 30),

//               // Seat Grid
//               Expanded(
//                 child: BlocBuilder<ExamSeatBloc, ExamSeatState>(
//                   builder: (context, state) {
//                     if (state is ExamSeatLoading) {
//                       return Center(
//                         child: CircularProgressIndicator(
//                           color: Colors.blue.shade700,
//                         ),
//                       );
//                     } else if (state is ExamSeatLoaded) {
//                       return ExamSeatGrid(
//                         seats: state.seats,
//                         onSeatBooked: () => _showBookingConfirmation(context),
//                       );
//                     } else if (state is ExamSeatError) {
//                       return Center(
//                         child: Text(
//                           state.message,
//                           style: const TextStyle(color: Colors.red),
//                         ),
//                       );
//                     }
//                     return const Center(
//                       child: Text(
//                         'No seats available',
//                         style: TextStyle(color: Colors.black54),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildHeader() {
//     return Container(
//       padding: const EdgeInsets.all(24),
//       decoration: BoxDecoration(
//         color: Colors.blue.shade50,
//         borderRadius: const BorderRadius.only(
//           bottomLeft: Radius.circular(30),
//           bottomRight: Radius.circular(30),
//         ),
//       ),
//       child: Column(
//         children: const [
//           Text(
//             'Mock Test Seat Booking',
//             style: TextStyle(
//               color: Colors.black87,
//               fontSize: 28,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           SizedBox(height: 8),
//           Text(
//             'Select your preferred seat',
//             style: TextStyle(
//               color: Colors.black54,
//               fontSize: 16,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   void _showBookingConfirmation(BuildContext context) {
//     showDialog(
//       barrierDismissible: false,
//       context: context,
//       builder: (context) {
//         return Dialog(
//           shape:
//               RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
//           child: Padding(
//             padding: const EdgeInsets.all(20.0),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 const Icon(Icons.check_circle, color: Colors.green, size: 50),
//                 const SizedBox(height: 16),
//                 const Text(
//                   "Seat Booking Confirmed",
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                   textAlign: TextAlign.center,
//                 ),
//                 const SizedBox(height: 8),
//                 const Text(
//                   "Your seat has been booked! Do you want to proceed to the payment screen?",
//                   style: TextStyle(fontSize: 14),
//                   textAlign: TextAlign.center,
//                 ),
//                 const SizedBox(height: 16),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     TextButton(
//                       onPressed: () {
//                         Navigator.pop(context); // Close dialog
//                       },
//                       child: const Text("Cancel"),
//                     ),
//                     ElevatedButton(
//                       onPressed: () {
//                         Navigator.pop(context); // Close dialog
//                         _navigateToPaymentScreen(context);
//                       },
//                       child: const Text("Proceed"),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }

//   void _navigateToPaymentScreen(BuildContext context) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => BlocProvider(
//           create: (context) => getIt<PaymentBloc>(),
//           child: PaymentScreen(),
//         ),
//       ),
//     );
//   }
// }

// /// 🔹 **Embedded `ExamSeatGrid` Directly Inside `ExamSeatScreen.dart`**
// class ExamSeatGrid extends StatelessWidget {
//   final List<ExamSeatEntity> seats;
//   final VoidCallback onSeatBooked;

//   const ExamSeatGrid({
//     Key? key,
//     required this.seats,
//     required this.onSeatBooked,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return GridView.builder(
//       padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
//       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 8,
//         crossAxisSpacing: 8,
//         mainAxisSpacing: 8,
//         childAspectRatio: 1,
//       ),
//       itemCount: seats.length,
//       itemBuilder: (context, index) {
//         final seat = seats[index];

//         return GestureDetector(
//           onTap: () {
//             if (seat.booked) {
//               _showBookingConfirmation(context);
//             } else if (seat.examSeatId == null) {
//               _showBookingConfirmation(context);
//             } else {
//               context
//                   .read<ExamSeatBloc>()
//                   .add(BookExamSeatEvent(seat.examSeatId!));
//               onSeatBooked();
//               _showBookingConfirmation(context);
//             }
//           },
//           child: Container(
//             decoration: BoxDecoration(
//               color: seat.booked ? Colors.redAccent : Colors.greenAccent,
//               borderRadius: BorderRadius.circular(6),
//             ),
//             child: Center(
//               child: Text(
//                 (index + 1).toString(),
//                 style: TextStyle(
//                   color: seat.booked ? Colors.white : Colors.black,
//                   fontSize: 14,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   void _showBookingConfirmation(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text("Seat Booking"),
//         content: const Text("Your seat has been booked successfully!"),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text("OK"),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shikshyadwar_mobile_application_project/app/di/di.dart';
import 'package:shikshyadwar_mobile_application_project/features/exam%20seat/Presentation/exam_seat_bloc.dart';
import 'package:shikshyadwar_mobile_application_project/features/exam%20seat/Presentation/exam_seat_event.dart';
import 'package:shikshyadwar_mobile_application_project/features/exam%20seat/Presentation/exam_seat_state.dart';
import 'package:shikshyadwar_mobile_application_project/features/exam%20seat/domain/entity/exam_seat_entity.dart';
import 'package:shikshyadwar_mobile_application_project/features/payment/presentation/payment_bloc.dart';
import 'package:shikshyadwar_mobile_application_project/features/payment/presentation/view/payment_screen.dart';

class ExamSeatScreen extends StatelessWidget {
  const ExamSeatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final bloc = getIt<ExamSeatBloc>();
        bloc.add(GetExamSeatsEvent());
        return bloc;
      },
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 253, 253),
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              // Elegant App Bar
              SliverAppBar(
                floating: true,
                snap: true,
                backgroundColor: Colors.white,
                elevation: 4,
                automaticallyImplyLeading: false, // Removes the back arrow
                title: Text(
                  'Mock Test Seat Booking',
                  style: TextStyle(
                    color: const Color.fromARGB(255, 15, 15, 15),
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1,
                  ),
                ),
                centerTitle: true,
              ),

              // Test Details Section
              SliverToBoxAdapter(
                child: Container(
                  margin: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        const Color.fromARGB(255, 254, 251, 252),
                        const Color.fromARGB(255, 255, 252, 253),
                      ],
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.calendar_today,
                              color: const Color.fromARGB(255, 20, 20, 20),
                              size: 36,
                            ),
                            const SizedBox(width: 16),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Next Mock Test',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color:
                                        const Color.fromARGB(255, 16, 16, 16),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  'This Saturday - 9:00 AM',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color:
                                        const Color.fromARGB(255, 72, 79, 87),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Icon(
                              Icons.money,
                              color: const Color.fromARGB(255, 234, 106, 9),
                              size: 36,
                            ),
                            const SizedBox(width: 16),
                            Text(
                              'Price: Rs. 200',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: const Color.fromARGB(255, 72, 79, 87),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Screen Indicator
              SliverToBoxAdapter(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Text(
                    'CHOOSE YOUR SEAT',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color.fromARGB(255, 147, 11, 74),
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
              ),

              // Screen Divider
              SliverToBoxAdapter(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
                  child: Divider(
                    color: const Color.fromARGB(255, 156, 44, 70),
                    thickness: 2,
                  ),
                ),
              ),

              // Seat Grid
              SliverPadding(
                padding: const EdgeInsets.all(16),
                sliver: BlocBuilder<ExamSeatBloc, ExamSeatState>(
                  builder: (context, state) {
                    if (state is ExamSeatLoading) {
                      return SliverToBoxAdapter(
                        child: Center(
                          child: CircularProgressIndicator(
                            color: Colors.blue.shade700,
                          ),
                        ),
                      );
                    } else if (state is ExamSeatLoaded) {
                      return SliverGrid(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 8,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 1,
                        ),
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final seat = state.seats[index];
                            return ExamSeatItem(
                              seat: seat,
                              onSeatTap: () {
                                if (!seat.booked && seat.examSeatId != null) {
                                  context
                                      .read<ExamSeatBloc>()
                                      .add(BookExamSeatEvent(seat.examSeatId!));
                                  _showBookingConfirmation(context);
                                } else if (seat.booked) {
                                  _showSeatUnavailableDialog(context);
                                }
                              },
                            );
                          },
                          childCount: state.seats.length,
                        ),
                      );
                    } else if (state is ExamSeatError) {
                      return SliverToBoxAdapter(
                        child: Center(
                          child: Text(
                            state.message,
                            style: const TextStyle(color: Colors.red),
                          ),
                        ),
                      );
                    }
                    return const SliverToBoxAdapter(
                      child: Center(
                        child: Text(
                          'No seats available',
                          style: TextStyle(color: Colors.black54),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showBookingConfirmation(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        title: Row(
          children: [
            Icon(Icons.check_circle, color: Colors.green.shade700, size: 30),
            const SizedBox(width: 10),
            Text(
              'Seat Booked',
              style: TextStyle(
                color: Colors.green.shade900,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        content: const Text(
          'Your seat has been successfully booked. Would you like to proceed to payment?',
          textAlign: TextAlign.center,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue.shade700,
            ),
            onPressed: () {
              Navigator.pop(context);
              _navigateToPaymentScreen(context);
            },
            child: const Text('Proceed to Payment'),
          ),
        ],
      ),
    );
  }

  void _showSeatUnavailableDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        title: Row(
          children: [
            Icon(Icons.warning, color: Colors.orange.shade700, size: 30),
            const SizedBox(width: 10),
            Text(
              'Seat Unavailable',
              style: TextStyle(
                color: Colors.orange.shade900,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        content: const Text(
          'This seat is already booked. Please select another seat.',
          textAlign: TextAlign.center,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _navigateToPaymentScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BlocProvider(
          create: (context) => getIt<PaymentBloc>(),
          child: PaymentScreen(),
        ),
      ),
    );
  }
}

class ExamSeatItem extends StatelessWidget {
  final ExamSeatEntity seat;
  final VoidCallback onSeatTap;

  const ExamSeatItem({
    Key? key,
    required this.seat,
    required this.onSeatTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onSeatTap,
        child: Container(
          decoration: BoxDecoration(
            color: seat.booked
                ? const Color.fromARGB(255, 130, 15, 15)
                : Colors.blue.shade200,
            borderRadius: BorderRadius.circular(10),

            // child: Center(
            // child: Text(
            // (seat.examSeatId ?? '').toString(),
            // style: TextStyle(
            //   color: seat.booked ? Colors.white : Colors.blue.shade900,
            //   fontSize: 16,
            //   fontWeight: FontWeight.bold,
          ),
        ));
  }
}
