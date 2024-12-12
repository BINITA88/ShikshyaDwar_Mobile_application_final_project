import 'dart:async';
import 'package:flutter/material.dart';

import 'package:shikshyadwar_mobile_application_project/constants/global_variable.dart';
import 'package:shikshyadwar_mobile_application_project/view/Home/top_categories.dart';

class HomepageView extends StatefulWidget {
  const HomepageView({Key? key}) : super(key: key);

  @override
  State<HomepageView> createState() => _CardViewState();
}

class _CardViewState extends State<HomepageView> {
  final List<String> carouselImages = [
    'assets/images/cr1.png',
    'assets/images/cr2.png',
    'assets/images/cr3.png',
  ];

  final List<Map<String, String?>> products = [
    {
      "image": "assets/images/reading.png",
      "title": "IELTS Class",
      "date": "10 Dec 2024",
      "duration": "2 Months"
    },
    {
      "image": "assets/images/pte.png",
      "title": "PTE Class",
      "date": "11 Dec 2024",
      "duration": "2 Months"
    },
    {
      "image": "assets/images/reading.png",
      "title": "SAT Class",
      "date": "12 Dec 2024",
      "duration": "2 Months"
    },
    {
      "image": "assets/images/pte.png",
      "title": "TOEFL Class",
      "date": "13 Dec 2024",
      "duration": "2 Months"
    },
  ];

  int _currentIndex = 0;
  late PageController _pageController;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_currentIndex < carouselImages.length - 1) {
        _currentIndex++;
      } else {
        _currentIndex = 0;
      }
      _pageController.animateToPage(
        _currentIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient:
                GlobalVariables.appBarGradient, // Ensure this is correctly set
            // Ensure there is no border or unnecessary decoration
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(
              left: 8.0), // Adjust padding for left spacing
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.menu, color: Color.fromARGB(255, 19, 19, 19)),
              // const SizedBox(
              //     width: 8), // Space between the menu icon and the logo
              // Image.asset(
              //   'assets/images/logo.png', // Correct path to the image
              //   height: 30, // Adjust the height of the logo
              //   width: 50, // Adjust the width according to your preference
              // ),
            ],
          ),
        ),
        title: const Text(
          "ShikshyaDwar",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 7, 7, 7),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.person,
                color: Color.fromARGB(255, 18, 17, 17)),
            onPressed: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => const Profile()),
              // );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Carousel Section
              SizedBox(
                height: 290,
                width: double.infinity, // Take full width
                child: Stack(
                  children: [
                    PageView.builder(
                      controller: _pageController,
                      onPageChanged: (index) {
                        setState(() {
                          _currentIndex = index;
                        });
                      },
                      itemCount: carouselImages.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10.0),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              )
                            ],
                            image: DecorationImage(
                              image: AssetImage(carouselImages[index]),
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                    ),
                    Positioned(
                      bottom: 10,
                      left: 0,
                      right: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          carouselImages.length,
                          (index) => AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            width: _currentIndex == index ? 12.0 : 8.0,
                            height: 8.0,
                            margin: const EdgeInsets.symmetric(horizontal: 3.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: _currentIndex == index
                                  ? Colors.redAccent
                                  : Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Positioned(
                      bottom: -5,
                      left: 0,
                      right: 0,
                      child: TopCategories(),
                    ),
                  ],
                ),
              ),

              // Recommended Classes Section
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Recommended Classes",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text("View All"),
                    ),
                  ],
                ),
              ),

              // Product List Section
              SizedBox(
                height: 220,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: products.length,
                  itemBuilder: (context, i) {
                    var product = products[i];
                    return GestureDetector(
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => ProductDetailsPage(
                        //       imageUrl: product["image"]!,
                        //       title: product["title"]!,
                        //       date: product["date"]!,
                        //       duration: product["duration"]!,
                        //     ),
                        //   ),
                        // );
                      },
                      child: Container(
                        width: 160,
                        margin: const EdgeInsets.only(right: 12.0),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 245, 245, 245),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color:
                                  Colors.grey.withOpacity(0.5), // Shadow color
                              blurRadius: 6, // Spread of the shadow
                              offset: const Offset(0, 6), // Shadow offset
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
                                product["image"]!,
                                height: 100,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product["title"]!,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(
                                    product["date"]!,
                                    style: const TextStyle(
                                      color: Colors.blueGrey,
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text(
                                    product["duration"]!,
                                    style: const TextStyle(
                                      color: Colors.green,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color.fromARGB(
                                    255, 53, 201, 110), // Button color
                              ),
                              onPressed: () {
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (context) => ProductDetailsPage(
                                //       imageUrl: product["image"]!,
                                //       title: product["title"]!,
                                //       date: product["date"]!,
                                //       duration: product["duration"]!,
                                //     ),
                                //   ),
                                // );
                              },
                              child: const Text('Add to Schedule'),
                            ),
                          ],
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
}
