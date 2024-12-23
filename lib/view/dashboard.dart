import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        leading: BackButton(
          onPressed: () {
            Navigator.pushNamed(
                context, '/signup'); // Navigate to '/signup' page
          },
        ),
      ),
      body: const Center(
        child: Text("Welcome to the Dashboard!"),
      ),
    );
  }
}
