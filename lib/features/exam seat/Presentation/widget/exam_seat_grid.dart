import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shikshyadwar_mobile_application_project/features/exam%20seat/Presentation/exam_seat_bloc.dart';
import 'package:shikshyadwar_mobile_application_project/features/exam%20seat/Presentation/exam_seat_event.dart';
import 'package:shikshyadwar_mobile_application_project/features/exam%20seat/domain/entity/exam_seat_entity.dart';

class ExamSeatGrid extends StatelessWidget {
  final List<ExamSeatEntity> seats;

  const ExamSeatGrid(
      {super.key, required this.seats, required void Function() onSeatBooked});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4, // Number of seats per row
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1.1,
      ),
      itemCount: seats.length,
      itemBuilder: (context, index) {
        final seat = seats[index];

        return GestureDetector(
          onTap: () {
            if (!seat.booked && seat.examSeatId != null) {
              // ✅ Ensure valid seat ID
              context
                  .read<ExamSeatBloc>()
                  .add(BookExamSeatEvent(seat.examSeatId!));
              _showBookingSnackbar(context);
            } else {
              _showErrorSnackbar(context);
            }
          },
          child: CustomPaint(
            painter: SeatPainter(isBooked: seat.booked),
            child: Center(
              child: Text(
                seat.booked ? "Booked" : "Seat ${index + 1}",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _showBookingSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("✅ Your seat for this Saturday has been booked!"),
        duration: Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.green,
      ),
    );
  }

  void _showErrorSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content:
            Text("⚠️ Invalid seat number format. Please try another seat."),
        duration: Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.redAccent,
      ),
    );
  }
}

/// **🎨 Custom Seat Painter for Rounded Cute Seats**
class SeatPainter extends CustomPainter {
  final bool isBooked;

  SeatPainter({required this.isBooked});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint seatPaint = Paint()
      ..color = isBooked
          ? const Color.fromARGB(255, 123, 14, 14)
          : const Color.fromARGB(
              255, 124, 211, 227)! // Deep Red for booked, Gray for available
      ..style = PaintingStyle.fill;

    final Paint shadowPaint = Paint()
      ..color = Colors.black.withOpacity(0.2)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 5);

    final double seatWidth = size.width * 0.8;
    final double seatHeight = size.height * 0.5;
    final double seatX = (size.width - seatWidth) / 2;
    final double seatY = (size.height - seatHeight) / 2;

    // **Draw Soft Shadow**
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(seatX, seatY + 4, seatWidth, seatHeight),
        const Radius.circular(12),
      ),
      shadowPaint,
    );

    // **Draw Seat**
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(seatX, seatY, seatWidth, seatHeight),
        const Radius.circular(12),
      ),
      seatPaint,
    );

    // **Draw Seat Backrest**
    final double backrestHeight = seatHeight * 0.6;
    final double backrestY = seatY - backrestHeight * 0.8;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(seatX, backrestY, seatWidth, backrestHeight),
        const Radius.circular(8),
      ),
      seatPaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
