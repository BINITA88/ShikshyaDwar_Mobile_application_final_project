// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:shikshyadwar_mobile_application_project/features/exam%20seat/Presentation/exam_seat_bloc.dart';
// import 'package:shikshyadwar_mobile_application_project/features/exam%20seat/Presentation/exam_seat_event.dart';
// import 'package:shikshyadwar_mobile_application_project/features/exam%20seat/domain/entity/exam_seat_entity.dart';

// class ExamSeatGrid extends StatelessWidget {
//   final List<ExamSeatEntity> seats;

//   const ExamSeatGrid({super.key, required this.seats});

//   @override
//   Widget build(BuildContext context) {
//     return GridView.builder(
//       padding: const EdgeInsets.all(12.0),
//       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 5, // ✅ Adjust the number of seats per row
//         crossAxisSpacing: 10,
//         mainAxisSpacing: 10,
//       ),
//       itemCount: seats.length,
//       itemBuilder: (context, index) {
//         final seat = seats[index];

//         return GestureDetector(
//           onTap: () {
//             if (seat.booked) {
//               context
//                   .read<ExamSeatBloc>()
//                   .add(UnbookExamSeatEvent(seat.examSeatId!));
//             } else {
//               context
//                   .read<ExamSeatBloc>()
//                   .add(BookExamSeatEvent(seat.examSeatId!));
//             }
//           },
//           child: Container(
//             decoration: BoxDecoration(
//               color: seat.booked
//                   ? Colors.grey
//                   : Colors.lightBlue, // ✅ Change color based on status
//               borderRadius: BorderRadius.circular(10),
//             ),
//             child: Center(
//               child: Icon(
//                 seat.booked ? Icons.person : Icons.event_seat,
//                 color: Colors.white,
//                 size: 24,
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shikshyadwar_mobile_application_project/features/exam%20seat/Presentation/exam_seat_bloc.dart';
import 'package:shikshyadwar_mobile_application_project/features/exam%20seat/Presentation/exam_seat_event.dart';
import 'package:shikshyadwar_mobile_application_project/features/exam%20seat/domain/entity/exam_seat_entity.dart';

class ExamSeatGrid extends StatelessWidget {
  final List<ExamSeatEntity> seats;

  const ExamSeatGrid({super.key, required this.seats});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(12.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 36,
        mainAxisSpacing: 20,
        childAspectRatio: 0.8,
      ),
      itemCount: seats.length,
      itemBuilder: (context, index) {
        final seat = seats[index];

        return GestureDetector(
          onTap: () {
            if (seat.booked) {
              context
                  .read<ExamSeatBloc>()
                  .add(UnbookExamSeatEvent(seat.examSeatId!));
            } else {
              context
                  .read<ExamSeatBloc>()
                  .add(BookExamSeatEvent(seat.examSeatId!));
            }
          },
          child: CustomPaint(
            painter: seat.booked ? BookedSeatPainter() : EmptySeatPainter(),
            child: Stack(
              children: [
                // Seat number
                // Positioned(
                //   top: 0,
                //   left: 0,
                //   child: Container(
                //     padding: const EdgeInsets.all(4),
                //     decoration: BoxDecoration(
                //       color: const Color.fromARGB(137, 65, 2, 2),
                //       borderRadius: BorderRadius.circular(4),
                //     ),
                //     child: Text(
                //       '${index + 1}',
                //       style: const TextStyle(
                //         color: Colors.white,
                //         fontSize: 12,
                //         fontWeight: FontWeight.bold,
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class EmptySeatPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint seatPaint = Paint()
      ..color = const Color.fromARGB(255, 139, 14, 43)!
      ..style = PaintingStyle.fill;

    final Paint borderPaint = Paint()
      ..color = Colors.brown[600]!
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    // Draw desk
    final deskPath = Path()
      ..moveTo(size.width * 0.1, size.height * 0.6)
      ..lineTo(size.width * 0.9, size.height * 0.6)
      ..lineTo(size.width * 0.85, size.height)
      ..lineTo(size.width * 0.15, size.height)
      ..close();

    // Draw seat back
    final seatBackPath = Path()
      ..moveTo(size.width * 0.2, size.height * 0.3)
      ..lineTo(size.width * 0.8, size.height * 0.3)
      ..lineTo(size.width * 0.8, size.height * 0.6)
      ..lineTo(size.width * 0.2, size.height * 0.6)
      ..close();

    canvas.drawPath(deskPath, seatPaint);
    canvas.drawPath(deskPath, borderPaint);
    canvas.drawPath(seatBackPath, seatPaint);
    canvas.drawPath(seatBackPath, borderPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class BookedSeatPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // First paint the empty seat
    EmptySeatPainter().paint(canvas, size);

    final Paint personPaint = Paint()
      ..color = Colors.blue[700]!
      ..style = PaintingStyle.fill;

    final Paint skinPaint = Paint()
      ..color = Colors.pink[100]!
      ..style = PaintingStyle.fill;

    // Draw body
    final bodyPath = Path()
      ..moveTo(size.width * 0.3, size.height * 0.25)
      ..lineTo(size.width * 0.7, size.height * 0.25)
      ..lineTo(size.width * 0.6, size.height * 0.55)
      ..lineTo(size.width * 0.4, size.height * 0.55)
      ..close();

    // Draw head
    final headCenter = Offset(size.width * 0.5, size.height * 0.2);
    final headRadius = size.width * 0.15;

    canvas.drawPath(bodyPath, personPaint);
    canvas.drawCircle(headCenter, headRadius, skinPaint);

    // Draw simple face details
    final Paint facePaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    // Eyes
    canvas.drawCircle(
      Offset(headCenter.dx - headRadius * 0.3, headCenter.dy),
      2,
      facePaint,
    );
    canvas.drawCircle(
      Offset(headCenter.dx + headRadius * 0.3, headCenter.dy),
      2,
      facePaint,
    );

    // Smile
    final smilePath = Path()
      ..moveTo(
          headCenter.dx - headRadius * 0.3, headCenter.dy + headRadius * 0.3)
      ..quadraticBezierTo(
        headCenter.dx,
        headCenter.dy + headRadius * 0.5,
        headCenter.dx + headRadius * 0.3,
        headCenter.dy + headRadius * 0.3,
      );
    canvas.drawPath(smilePath, facePaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
