// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:shikshyadwar_mobile_application_project/view/Home/Dashboard/classes.dart';
// import 'package:shikshyadwar_mobile_application_project/view/Home/Dashboard/message.dart';
// import 'package:shikshyadwar_mobile_application_project/view/Home/Dashboard/profile.dart';
// import 'package:shikshyadwar_mobile_application_project/view/Home/top_categories.dart';

// class HomepageView extends StatefulWidget {
//   const HomepageView({super.key});

//   @override
//   State<HomepageView> createState() => _CardViewState();
// }

// class _CardViewState extends State<HomepageView> {
//   final List<String> carouselImages = [
//     'assets/images/cr1.png',
//     'assets/images/cr2.png',
//     'assets/images/cr3.png',
//   ];

//   final List<Map<String, String?>> products = [
//     {
//       "image": "assets/images/reading.png",
//       "title": "IELTS Class",
//       "date": "10 Dec 2024",
//       "duration": "2 Months"
//     },
//     {
//       "image": "assets/images/pte.png",
//       "title": "PTE Class",
//       "date": "11 Dec 2024",
//       "duration": "2 Months"
//     },
//     {
//       "image": "assets/images/reading.png",
//       "title": "SAT Class",
//       "date": "12 Dec 2024",
//       "duration": "2 Months"
//     },
//     {
//       "image": "assets/images/pte.png",
//       "title": "TOEFL Class",
//       "date": "13 Dec 2024",
//       "duration": "2 Months"
//     },
//   ];

//   int _selectedIndex = 0;
//   int _currentIndex = 0;
//   late PageController _pageController;
//   late Timer _timer;

//   @override
//   void initState() {
//     super.initState();
//     _pageController = PageController();
//     _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
//       if (_currentIndex < carouselImages.length - 1) {
//         _currentIndex++;
//       } else {
//         _currentIndex = 0;
//       }
//       _pageController.animateToPage(
//         _currentIndex,
//         duration: const Duration(milliseconds: 300),
//         curve: Curves.easeInOut,
//       );
//     });
//   }

//   @override
//   void dispose() {
//     _pageController.dispose();
//     _timer.cancel();
//     super.dispose();
//   }

//   void _onNavBarTap(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//     Widget nextPage;
//     switch (index) {
//       case 0:
//         nextPage = const HomepageView();
//         break;
//       case 1:
//         nextPage = const Classes();
//         break;
//       case 2:
//         nextPage = const Message();
//         break;
//       case 3:
//         nextPage = const Profile();
//         break;
//       default:
//         nextPage = const HomepageView();
//     }
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(builder: (context) => nextPage),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);

//     return Scaffold(
//       backgroundColor: theme.scaffoldBackgroundColor,
//       appBar: AppBar(
//         elevation: 0,
//         centerTitle: true,
//         title: Text(
//           "ShikshyaDwar",
//           style: theme.appBarTheme.titleTextStyle,
//         ),
//       ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               // Carousel Section
//               SizedBox(
//                 height: 260,
//                 width: double.infinity,
//                 child: Stack(
//                   children: [
//                     PageView.builder(
//                       controller: _pageController,
//                       onPageChanged: (index) {
//                         setState(() {
//                           _currentIndex = index;
//                         });
//                       },
//                       itemCount: carouselImages.length,
//                       itemBuilder: (context, index) {
//                         return Container(
//                           margin: const EdgeInsets.symmetric(horizontal: 10.0),
//                           decoration: BoxDecoration(
//                             boxShadow: [
//                               BoxShadow(
//                                 color: theme.shadowColor.withOpacity(0.5),
//                                 blurRadius: 8,
//                                 offset: const Offset(0, 4),
//                               )
//                             ],
//                             image: DecorationImage(
//                               image: AssetImage(carouselImages[index]),
//                               fit: BoxFit.cover,
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                     Positioned(
//                       bottom: 10,
//                       left: 0,
//                       right: 0,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: List.generate(
//                           carouselImages.length,
//                           (index) => AnimatedContainer(
//                             duration: const Duration(milliseconds: 300),
//                             width: _currentIndex == index ? 12.0 : 8.0,
//                             height: 8.0,
//                             margin: const EdgeInsets.symmetric(horizontal: 3.0),
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(4),
//                               color: _currentIndex == index
//                                   ? theme.primaryColor
//                                   : theme.disabledColor,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     const Positioned(
//                       bottom: -5,
//                       left: 0,
//                       right: 0,
//                       child: TopCategories(),
//                     ),
//                   ],
//                 ),
//               ),

//               // Recommended Classes Section
//               const SizedBox(height: 10),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       "Recommended Classes",
//                       style: theme.textTheme.titleLarge?.copyWith(
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     TextButton(
//                       onPressed: () {},
//                       child: const Text("View All"),
//                     ),
//                   ],
//                 ),
//               ),

//               // Product List Section
//               SizedBox(
//                 height: 220,
//                 child: ListView.builder(
//                   scrollDirection: Axis.horizontal,
//                   itemCount: products.length,
//                   itemBuilder: (context, i) {
//                     var product = products[i];
//                     return GestureDetector(
//                       onTap: () {},
//                       child: Container(
//                         width: 160,
//                         margin: const EdgeInsets.only(right: 12.0),
//                         decoration: BoxDecoration(
//                           color: theme.cardColor,
//                           borderRadius: BorderRadius.circular(10),
//                           boxShadow: [
//                             BoxShadow(
//                               color: theme.shadowColor.withOpacity(0.2),
//                               blurRadius: 6,
//                               offset: const Offset(0, 6),
//                             ),
//                           ],
//                         ),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: [
//                             ClipRRect(
//                               borderRadius: const BorderRadius.only(
//                                 topLeft: Radius.circular(10),
//                                 topRight: Radius.circular(10),
//                               ),
//                               child: Image.asset(
//                                 product["image"]!,
//                                 height: 100,
//                                 width: double.infinity,
//                                 fit: BoxFit.cover,
//                               ),
//                             ),
//                             Padding(
//                               padding:
//                                   const EdgeInsets.symmetric(horizontal: 8.0),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     product["title"]!,
//                                     style: theme.textTheme.bodyLarge?.copyWith(
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                   Text(
//                                     product["date"]!,
//                                     style: theme.textTheme.bodySmall,
//                                   ),
//                                   Text(
//                                     product["duration"]!,
//                                     style: theme.textTheme.bodySmall?.copyWith(
//                                       color: theme.primaryColor,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             SizedBox(
//                               width:
//                                   130, // Increase width to ensure the text fits
//                               height: 36,
//                               child: ElevatedButton(
//                                 onPressed: () {},
//                                 style: ElevatedButton.styleFrom(
//                                   padding: EdgeInsets
//                                       .zero, // Remove padding to ensure no space is wasted
//                                 ),
//                                 child: const Text(
//                                   'Add to Schedule',
//                                   style: TextStyle(
//                                     fontSize: 13,
//                                     fontWeight: FontWeight.bold,
//                                     color: Color.fromARGB(255, 7, 7,
//                                         7), // Make sure text color is visible
//                                   ),
//                                   overflow:
//                                       TextOverflow.ellipsis, // Prevent overflow
//                                   maxLines: 1, // Keep text in one line
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _selectedIndex,
//         type: BottomNavigationBarType.fixed,
//         backgroundColor: theme.appBarTheme.backgroundColor,
//         selectedItemColor: theme.colorScheme.onSecondary,
//         unselectedItemColor: theme.colorScheme.onPrimary.withOpacity(0.5),
//         onTap: _onNavBarTap,
//         items: const [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.class_),
//             label: 'Classes',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.message),
//             label: 'Message',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person),
//             label: 'Profile',
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shikshyadwar_mobile_application_project/core/common/my_card.dart';
import 'package:shikshyadwar_mobile_application_project/view/Home/Dashboard/classes.dart';
import 'package:shikshyadwar_mobile_application_project/view/Home/Dashboard/message.dart';
import 'package:shikshyadwar_mobile_application_project/view/Home/Dashboard/profile.dart';
import 'package:shikshyadwar_mobile_application_project/view/Home/top_categories.dart';

class HomepageView extends StatefulWidget {
  const HomepageView({super.key});

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

  int _selectedIndex = 0;
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

  void _onNavBarTap(int index) {
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
        nextPage = const Message();
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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          "ShikshyaDwar",
          style: theme.appBarTheme.titleTextStyle,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Carousel Section
              SizedBox(
                height: 260,
                width: double.infinity,
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
                                color: theme.shadowColor.withOpacity(0.5),
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
                                  ? theme.primaryColor
                                  : theme.disabledColor,
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
                    Text(
                      "Recommended Classes",
                      style: theme.textTheme.titleLarge?.copyWith(
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
                    return MyCart(
                      image: product["image"]!,
                      title: product["title"]!,
                      date: product["date"]!,
                      duration: product["duration"]!,
                      onPressed: () {
                        // Handle 'Add to Schedule' button press
                      },
                    );
                  },
                ),
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
