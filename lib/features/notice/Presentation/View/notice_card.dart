import 'package:flutter/material.dart';
import '../../domain/entity/notice_entity.dart';

class NoticeCard extends StatelessWidget {
  final NoticeEntity notice;

  NoticeCard({required this.notice});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              notice.message,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: Text('Mark as read'),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text('Read More'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}





