// import 'package:flutter/material.dart';
// import '../../domain/entity/notice_entity.dart';

// class NoticeCard extends StatelessWidget {
//   final NoticeEntity notice;

//   NoticeCard({required this.notice});

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 4,
//       margin: EdgeInsets.symmetric(vertical: 8),
//       child: Padding(
//         padding: EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               notice.message,
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 8),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 ElevatedButton(
//                   onPressed: () {},
//                   child: Text('Mark as read'),
//                 ),
//                 TextButton(
//                   onPressed: () {},
//                   child: Text('Read More'),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import '../../domain/entity/notice_entity.dart';

// class NoticeCard extends StatelessWidget {
//   final NoticeEntity notice;

//   NoticeCard({required this.notice});

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 6,
//       margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: Padding(
//         padding: EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(height: 2),
//             Row(
//               children: [
//                 Icon(
//                   Icons.notification_important,
//                   color: Colors.orange,
//                   size: 28,
//                 ),
//                 SizedBox(width: 10),
//                 Expanded(
//                   child: Text(
//                     notice.message,
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black87,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: 16),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 ElevatedButton.icon(
//                   onPressed: () {
//                     // TODO: Mark as read action
//                   },
//                   icon: Icon(Icons.check_circle_outline, color: Colors.white),
//                   label: Text('Mark as Read'),
//                   style: ElevatedButton.styleFrom(
//                     foregroundColor: Color.fromARGB(255, 255, 253, 253),
//                   ),
//                 ),
//                 TextButton.icon(
//                   onPressed: () {
//                     // TODO: Read more action
//                   },
//                   icon: Icon(Icons.more_horiz, color: Colors.blue),
//                   label: Text('Read More'),
//                   style: TextButton.styleFrom(
//                     foregroundColor:
//                         Colors.blue, // Use foregroundColor instead of primary
//                     textStyle: TextStyle(fontWeight: FontWeight.bold),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import '../../domain/entity/notice_entity.dart';

// class NoticeCard extends StatefulWidget {
//   final NoticeEntity notice;

//   NoticeCard({required this.notice});

//   @override
//   _NoticeCardState createState() => _NoticeCardState();
// }

// class _NoticeCardState extends State<NoticeCard> {
//   bool isExpanded = false; // Track if full text should be shown

//   @override
//   Widget build(BuildContext context) {
//     String shortText = widget.notice.message.length > 100
//         ? '${widget.notice.message.substring(0, 100)}...' // Show first 100 chars
//         : widget.notice.message;

//     return Card(
//       elevation: 6,
//       margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: Padding(
//         padding: EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 Icon(Icons.notifications_active,
//                     color: Colors.orange, size: 28),
//                 SizedBox(width: 10),
//                 Expanded(
//                   child: Text(
//                     "📢 Notice",
//                     style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black87),
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: 10),
//             Text(
//               isExpanded
//                   ? widget.notice.message
//                   : shortText, // Toggle text display
//               style: TextStyle(fontSize: 16, color: Colors.black87),
//             ),
//             if (widget.notice.message.length >
//                 5) // Show "Read More" only if text is long
//               TextButton(
//                 onPressed: () {
//                   setState(() {
//                     isExpanded = !isExpanded;
//                   });
//                 },
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     Text(
//                       isExpanded ? "Read Less" : "Read More",
//                       style: TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.blue),
//                     ),
//                     Icon(isExpanded ? Icons.expand_less : Icons.expand_more,
//                         color: Colors.blue),
//                   ],
//                 ),
//               ),
//             SizedBox(height: 10),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 ElevatedButton.icon(
//                   onPressed: () {
//                     // TODO: Mark as read action
//                   },
//                   icon: Icon(Icons.check_circle_outline, color: Colors.white),
//                   label: Text('Mark as Read'),
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.pink[800],
//                     foregroundColor: Colors.white,
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import '../../domain/entity/notice_entity.dart';

class NoticeCard extends StatefulWidget {
  final NoticeEntity notice;

  NoticeCard({required this.notice});

  @override
  _NoticeCardState createState() => _NoticeCardState();
}

class _NoticeCardState extends State<NoticeCard> {
  bool isExpanded = false; // Toggle for Read More

  @override
  Widget build(BuildContext context) {
    String shortText = widget.notice.message.length > 120
        ? '${widget.notice.message.substring(0, 120)}...' // Show first 120 chars
        : widget.notice.message;

    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05), // Soft shadow for depth
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Notice Header
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.pink[100],
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.notifications_active,
                    color: Colors.pink[800], size: 22),
              ),
              SizedBox(width: 10),
              Text(
                "📢 Notice",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.pink[800],
                ),
              ),
            ],
          ),

          SizedBox(height: 10),

          // Notice Message
          AnimatedCrossFade(
            duration: Duration(milliseconds: 300),
            firstChild: Text(
              shortText,
              style:
                  TextStyle(fontSize: 15, color: Colors.black87, height: 1.5),
            ),
            secondChild: Text(
              widget.notice.message,
              style:
                  TextStyle(fontSize: 15, color: Colors.black87, height: 1.5),
            ),
            crossFadeState: isExpanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
          ),

          // Read More Button
          if (widget.notice.message.length >
              120) // Show Read More only for long texts
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton(
                onPressed: () {
                  setState(() {
                    isExpanded = !isExpanded;
                  });
                },
                child: Text(
                  isExpanded ? "Read Less" : "Read More",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),
              ),
            ),

          SizedBox(height: 10),

          // Bottom Row: Mark as Read Button
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.pink[50],
              borderRadius: BorderRadius.circular(8),
            ),
            child: TextButton.icon(
              onPressed: () {
                // TODO: Mark as read action
              },
              icon: Icon(Icons.check_circle_outline, color: Colors.pink[800]),
              label: Text(
                "Mark as Read",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.pink[800]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import '../../domain/entity/notice_entity.dart';

// class NoticeCard extends StatefulWidget {
//   final NoticeEntity notice;

//   NoticeCard({required this.notice});

//   @override
//   _NoticeCardState createState() => _NoticeCardState();
// }

// class _NoticeCardState extends State<NoticeCard> {
//   bool isExpanded = false; // Toggle for Read More

//   @override
//   Widget build(BuildContext context) {
//     String shortText = widget.notice.message.length > 100
//         ? '${widget.notice.message.substring(0, 100)}...' // Show first 100 chars
//         : widget.notice.message;

//     return Container(
//       margin:
//           EdgeInsets.symmetric(vertical: 6, horizontal: 12), // Compact spacing
//       padding: EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(10), // Rounded corners
//         border:
//             Border.all(color: Colors.grey.shade300, width: 1), // Thin border
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05), // Light shadow for depth
//             blurRadius: 5,
//             offset: Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Notice Header
//           Row(
//             children: [
//               Container(
//                 padding: EdgeInsets.all(5),
//                 decoration: BoxDecoration(
//                   color: Colors.pink[100],
//                   shape: BoxShape.circle,
//                 ),
//                 child: Icon(Icons.notifications,
//                     color: Colors.pink[800], size: 20),
//               ),
//               SizedBox(width: 8),
//               Text(
//                 "📢 Notice",
//                 style: TextStyle(
//                   fontSize: 14,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.pink[800],
//                 ),
//               ),
//             ],
//           ),

//           SizedBox(height: 8),

//           // Notice Message
//           AnimatedCrossFade(
//             duration: Duration(milliseconds: 300),
//             firstChild: Text(
//               shortText,
//               style:
//                   TextStyle(fontSize: 14, color: Colors.black87, height: 1.4),
//             ),
//             secondChild: Text(
//               widget.notice.message,
//               style:
//                   TextStyle(fontSize: 14, color: Colors.black87, height: 1.4),
//             ),
//             crossFadeState: isExpanded
//                 ? CrossFadeState.showSecond
//                 : CrossFadeState.showFirst,
//           ),

//           // Read More Button
//           if (widget.notice.message.length >
//               100) // Show Read More only for long texts
//             Align(
//               alignment: Alignment.centerLeft,
//               child: TextButton(
//                 onPressed: () {
//                   setState(() {
//                     isExpanded = !isExpanded;
//                   });
//                 },
//                 style: TextButton.styleFrom(
//                   padding: EdgeInsets.zero, // Removes default padding
//                   minimumSize: Size(0, 20), // Compact button
//                 ),
//                 child: Text(
//                   isExpanded ? "Read Less" : "Read More",
//                   style: TextStyle(
//                     fontSize: 13,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.blueAccent,
//                   ),
//                 ),
//               ),
//             ),

//           SizedBox(height: 5),

//           // Divider for separation
//           Divider(height: 10, thickness: 1, color: Colors.grey[200]),

//           // Bottom Row: Mark as Read Button
//           SizedBox(height: 5),
//           Align(
//             alignment: Alignment.centerRight,
//             child: OutlinedButton.icon(
//               onPressed: () {
//                 // TODO: Mark as read action
//               },
//               icon: Icon(Icons.check_circle_outline,
//                   color: Colors.pink[800], size: 18),
//               label: Text(
//                 "Mark as Read",
//                 style: TextStyle(
//                     fontSize: 13,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.pink[800]),
//               ),
//               style: OutlinedButton.styleFrom(
//                 padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
//                 // side: BorderSide(color: Colors.pink[800], width: 1.5),
//                 shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8)),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
