import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shikshyadwar_mobile_application_project/app/di/di.dart';
import 'package:shikshyadwar_mobile_application_project/features/exam%20seat/Presentation/exam_seat_bloc.dart';
import 'package:shikshyadwar_mobile_application_project/features/exam%20seat/Presentation/exam_seat_event.dart';
import 'package:shikshyadwar_mobile_application_project/features/exam%20seat/Presentation/exam_seat_state.dart';
import 'package:shikshyadwar_mobile_application_project/features/exam%20seat/domain/entity/exam_seat_entity.dart';

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
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Column(
            children: [
              // Title Section
              Container(
                padding: const EdgeInsets.all(24),
                child: const Text(
                  'Mock Test Seat Booking',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        color: Colors.white24,
                        blurRadius: 15,
                      ),
                    ],
                  ),
                ),
              ),

              // Test Details Section
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.calendar_today, color: Colors.black),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Next Mock Test',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          'This Saturday - 9:00 AM',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),
              const Text(
                'CHOOSE YOUR SEAT',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  letterSpacing: 2,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),

              // Screen Indicator
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 40),
                height: 40,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.blue.withOpacity(0.1),
                      Colors.blue.withOpacity(0.3),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: const Center(
                  child: Text(
                    'EXAMINATION SCREEN',
                    style: TextStyle(
                      color: Colors.white60,
                      fontSize: 12,
                      letterSpacing: 3,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // Seat Grid
              Expanded(
                child: BlocBuilder<ExamSeatBloc, ExamSeatState>(
                  builder: (context, state) {
                    if (state is ExamSeatLoading) {
                      return const Center(
                        child: CircularProgressIndicator(color: Colors.white),
                      );
                    } else if (state is ExamSeatLoaded) {
                      return ExamSeatGrid(
                        seats: state.seats,
                        onSeatBooked: () => _showBookingConfirmation(context),
                      );
                    } else if (state is ExamSeatError) {
                      return Center(
                        child: Text(
                          state.message,
                          style: const TextStyle(color: Colors.red),
                        ),
                      );
                    }
                    return const Center(
                      child: Text(
                        'No seats available',
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  },
                ),
              ),

              // Legend
              Container(
                margin: const EdgeInsets.all(20),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildLegendItem(
                      color: const Color.fromARGB(255, 124, 211, 227),
                      label: 'Available',
                    ),
                    _buildLegendItem(
                      color: Colors.green,
                      label: 'Selected',
                    ),
                    _buildLegendItem(
                      color: const Color.fromARGB(255, 123, 14, 14),
                      label: 'Occupied',
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

  Widget _buildLegendItem({required Color color, required String label}) {
    return Row(
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  void _showBookingConfirmation(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: const [
            Icon(Icons.check_circle, color: Colors.white),
            SizedBox(width: 12),
            Text('Your seat for this Saturday has been booked!'),
          ],
        ),
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.green,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}

// Updated SeatPainter
class SeatPainter extends CustomPainter {
  final bool isBooked;

  SeatPainter({required this.isBooked});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint seatPaint = Paint()
      ..color = isBooked
          ? const Color.fromARGB(255, 123, 14, 14)
          : const Color.fromARGB(255, 124, 211, 227)
      ..style = PaintingStyle.fill;

    final Paint shadowPaint = Paint()
      ..color = Colors.black.withOpacity(0.3)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3);

    final double seatWidth = size.width * 0.85;
    final double seatHeight = size.height * 0.85;
    final double seatX = (size.width - seatWidth) / 2;
    final double seatY = (size.height - seatHeight) / 2;

    // Draw shadow
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(seatX + 2, seatY + 2, seatWidth, seatHeight),
        const Radius.circular(8),
      ),
      shadowPaint,
    );

    // Draw seat
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(seatX, seatY, seatWidth, seatHeight),
        const Radius.circular(8),
      ),
      seatPaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

// Updated ExamSeatGrid
class ExamSeatGrid extends StatelessWidget {
  final List<ExamSeatEntity> seats;
  final VoidCallback onSeatBooked;

  const ExamSeatGrid({
    Key? key,
    required this.seats,
    required this.onSeatBooked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 8,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 1,
      ),
      itemCount: seats.length,
      itemBuilder: (context, index) {
        final seat = seats[index];
        return GestureDetector(
          onTap: () {
            if (!seat.booked && seat.examSeatId != null) {
              context
                  .read<ExamSeatBloc>()
                  .add(BookExamSeatEvent(seat.examSeatId!));
              onSeatBooked();
            }
          },
          child: CustomPaint(
            painter: SeatPainter(isBooked: seat.booked),
            child: Center(
              child: Text(
                (index + 1).toString(),
                style: TextStyle(
                  color: seat.booked ? Colors.white60 : Colors.black87,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

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
//         backgroundColor: const Color.fromARGB(255, 244, 235, 238),
//         body: SafeArea(
//           child: Column(
//             children: [
//               // Title Section
//               Container(
//                 padding: const EdgeInsets.all(24),
//                 decoration: BoxDecoration(
//                   color: Colors.blue.shade50,
//                   borderRadius: const BorderRadius.only(
//                     bottomLeft: Radius.circular(30),
//                     bottomRight: Radius.circular(30),
//                   ),
//                 ),
//                 child: Column(
//                   children: const [
//                     Text(
//                       'Mock Test Seat Booking',
//                       style: TextStyle(
//                         color: Colors.black87,
//                         fontSize: 28,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     SizedBox(height: 8),
//                     Text(
//                       'Select your preferred seat',
//                       style: TextStyle(
//                         color: Colors.black54,
//                         fontSize: 16,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),

//               // Test Details Section
//               Container(
//                 margin: const EdgeInsets.all(20),
//                 padding: const EdgeInsets.all(16),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(12),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.grey.withOpacity(0.1),
//                       spreadRadius: 1,
//                       blurRadius: 10,
//                     ),
//                   ],
//                 ),
//                 child: Row(
//                   children: [
//                     Container(
//                       padding: const EdgeInsets.all(12),
//                       decoration: BoxDecoration(
//                         color: Colors.blue.shade50,
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       child: Icon(Icons.calendar_today,
//                           color: Colors.blue.shade700),
//                     ),
//                     const SizedBox(width: 16),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const Text(
//                           'Next Mock Test',
//                           style: TextStyle(
//                             fontSize: 16,
//                             color: Colors.black54,
//                           ),
//                         ),
//                         const SizedBox(height: 4),
//                         Text(
//                           'This Saturday - 9:00 AM',
//                           style: TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.blue.shade700,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),

//               // Screen Indicator
//               Container(
//                 margin: const EdgeInsets.symmetric(horizontal: 40),
//                 height: 40,
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     colors: [
//                       Colors.blue.shade100,
//                       Colors.blue.shade50,
//                     ],
//                   ),
//                   borderRadius: BorderRadius.circular(5),
//                 ),
//                 child: Center(
//                   child: Text(
//                     'EXAMINATION SCREEN',
//                     style: TextStyle(
//                       color: Colors.blue.shade700,
//                       fontSize: 12,
//                       letterSpacing: 3,
//                       fontWeight: FontWeight.bold,
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

//               // Legend
//               Container(
//                 margin: const EdgeInsets.all(20),
//                 padding: const EdgeInsets.all(16),
//                 decoration: BoxDecoration(
//                   color: Colors.grey.shade50,
//                   borderRadius: BorderRadius.circular(12),
//                   border: Border.all(color: Colors.grey.shade200),
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     _buildLegendItem(
//                       color: const Color.fromARGB(255, 124, 211, 227),
//                       label: 'Available',
//                       textColor: Colors.black87,
//                     ),
//                     _buildLegendItem(
//                       color: Colors.green,
//                       label: 'Selected',
//                       textColor: Colors.black87,
//                     ),
//                     _buildLegendItem(
//                       color: const Color.fromARGB(255, 123, 14, 14),
//                       label: 'Occupied',
//                       textColor: Colors.black87,
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

//   Widget _buildLegendItem(
//       {required Color color, required String label, required Color textColor}) {
//     return Row(
//       children: [
//         Container(
//           width: 24,
//           height: 24,
//           decoration: BoxDecoration(
//             color: color,
//             borderRadius: BorderRadius.circular(4),
//             border: Border.all(color: Colors.grey.shade300),
//           ),
//         ),
//         const SizedBox(width: 8),
//         Text(
//           label,
//           style: TextStyle(
//             color: textColor,
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

// // Updated SeatPainter with lighter theme
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

//     final Paint borderPaint = Paint()
//       ..color = Colors.grey.shade300
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 1;

//     final Paint shadowPaint = Paint()
//       ..color = Colors.grey.withOpacity(0.2)
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
//     final RRect seatRRect = RRect.fromRectAndRadius(
//       Rect.fromLTWH(seatX, seatY, seatWidth, seatHeight),
//       const Radius.circular(8),
//     );

//     canvas.drawRRect(seatRRect, seatPaint);
//     canvas.drawRRect(seatRRect, borderPaint);
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) => false;
// }

// // Updated ExamSeatGrid remains the same as previous version
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
//                   color: seat.booked ? Colors.white : Colors.black87,
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
