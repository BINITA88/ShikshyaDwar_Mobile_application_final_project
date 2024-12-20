import 'package:flutter/material.dart';

class MyCart extends StatelessWidget {
  final String image;
  final String title;
  final String date;
  final String duration;
  final VoidCallback onPressed;

  const MyCart({
    Key? key,
    required this.image,
    required this.title,
    required this.date,
    required this.duration,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 160,
        margin: const EdgeInsets.only(right: 12.0),
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: theme.shadowColor.withOpacity(0.2),
              blurRadius: 6,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              child: Image.asset(
                image,
                height: 100,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    date,
                    style: theme.textTheme.bodySmall,
                  ),
                  Text(
                    duration,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.primaryColor,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 130,
              height: 36,
              child: ElevatedButton(
                onPressed: onPressed,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.zero,
                ),
                child: const Text(
                  'Add to Schedule',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
