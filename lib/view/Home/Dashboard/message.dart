import 'package:flutter/material.dart';
import 'package:shikshyadwar_mobile_application_project/view/Home/Dashboard/classes.dart';
import 'package:shikshyadwar_mobile_application_project/view/Home/Dashboard/profile.dart';
import 'package:shikshyadwar_mobile_application_project/view/Home/home_view.dart';

class Message extends StatefulWidget {
  const Message({super.key});

  @override
  State<Message> createState() => _MessageState();
}

class _MessageState extends State<Message> {
  int _selectedIndex = 2; // Default to "Message" tab

  void _onNavBarTap(int index) {
    if (_selectedIndex != index) {
      setState(() {
        _selectedIndex = index;
      });
      Widget nextPage;
      switch (index) {
        case 0:
          nextPage = const HomepageView();
          break;
        case 1:
          nextPage = const Classes();
          break;
        case 2:
          nextPage = const Message(); // Current Page
          break;
        case 3:
          nextPage = const Profile();
          break;
        default:
          nextPage = const HomepageView();
      }
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => nextPage),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Example message data for specific classes
    final List<Map<String, String>> classMessages = [
      {
        "class": "IELTS - Reading",
        "message": "Upcoming class on 10th Jan 2024 at 10:00 AM",
        "link": "View Class Messages"
      },
      {
        "class": "IELTS - Listening",
        "message": "Instructor's note: Practice test uploaded.",
        "link": "View Class Messages"
      },
      {
        "class": "SAT - Writing",
        "message": "Homework: Submit essay by 5 PM tomorrow.",
        "link": "View Class Messages"
      },
      {
        "class": "PTE - Speaking",
        "message": "Live session scheduled for next Friday.",
        "link": "View Class Messages"
      },
    ];

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Messages",
          style: theme.appBarTheme.titleTextStyle,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  "Messages from Instructors",
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: classMessages.length,
                itemBuilder: (context, index) {
                  var messageData = classMessages[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 4.0),
                    child: ListTile(
                      leading: const Icon(
                        Icons.class_,
                        color: Color.fromARGB(255, 224, 176, 33),
                      ),
                      title: Text(
                        messageData["class"]!,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(messageData["message"]!),
                      trailing: TextButton(
                        onPressed: () {
                          // Navigate to detailed class messages
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ClassMessagesPage(
                                  className: messageData["class"]!),
                            ),
                          );
                        },
                        child: Text(messageData["link"]!),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: theme.appBarTheme.backgroundColor,
        selectedItemColor: theme.colorScheme.onSecondary,
        unselectedItemColor: theme.colorScheme.onPrimary.withOpacity(0.5),
        onTap: _onNavBarTap,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.class_),
            label: 'Classes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Message',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

// A placeholder for the detailed class messages page
class ClassMessagesPage extends StatelessWidget {
  final String className;

  const ClassMessagesPage({super.key, required this.className});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Messages - $className"),
      ),
      body: Center(
        child: Text(
          "Detailed messages for $className will appear here.",
          style: Theme.of(context).textTheme.bodyLarge,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
