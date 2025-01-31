import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shikshyadwar_mobile_application_project/features/splash/presentation/view_model/onboarding_cubit.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingContent> _pages = [
    OnboardingContent(
      image: 'assets/images/sign.png',
      title: 'Welcome to ShikshyaDwar',
      description:
          'Your gateway to excellence in education. Book classes for IELTS, PTE, SAT, and more, all in one place.',
      features: [
        FeatureItem(Icons.school, 'Expert\nTeachers'),
        FeatureItem(Icons.timer, 'Flexible\nTiming'),
        FeatureItem(Icons.phonelink, 'Online\nAccess'),
      ],
    ),
    OnboardingContent(
      image: 'assets/images/hee.png',
      title: 'Interactive Learning',
      description:
          'Join live study groups, participate in discussions, and learn from peers around the world.',
      features: [
        FeatureItem(Icons.group, 'Study\nGroups'),
        FeatureItem(Icons.chat, 'Live\nDiscussions'),
        FeatureItem(Icons.public, 'Global\nNetwork'),
      ],
    ),
    OnboardingContent(
      image: 'assets/images/onboard1.png',
      title: 'Track Your Progress',
      description: 'Monitor your performance with detailed analytics.',
      // features: [
      //   FeatureItem(Icons.analytics, 'Progress\nAnalytics'),
      //   FeatureItem(Icons.trending_up, 'Performance\nMetrics'),
      //   FeatureItem(Icons.psychology, 'Recommendations'),
      // ],
      features: [
        FeatureItem(Icons.library_books, 'Progress\nAnalytics'),
        FeatureItem(Icons.quiz, 'Performance\nTests'),
        FeatureItem(Icons.bolt, 'Global\nNetwork'),
      ],
    ),
    OnboardingContent(
      image: 'assets/images/download.png',
      title: 'Rich Resources',
      description:
          'Access comprehensive study materials, practice tests, and exam preparation guides.',
      features: [
        FeatureItem(Icons.library_books, 'Study\nMaterials'),
        FeatureItem(Icons.quiz, 'Practice\nTests'),
        FeatureItem(Icons.bolt, 'Quick\nRevision'),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.pink[50]!, Colors.white],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (int page) {
                    setState(() {
                      _currentPage = page;
                    });
                  },
                  itemCount: _pages.length,
                  itemBuilder: (context, index) {
                    return _buildPage(_pages[index]);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: _buildPageIndicator(),
                    ),
                    const SizedBox(height: 24),
                    _buildButton(context),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPage(OnboardingContent content) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 240,
            width: 240,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.pink[800]!.withOpacity(0.2),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Image.asset(
              content.image,
              width: 250, // Match the container size
              height: 250, // Match the container size
              fit: BoxFit
                  .cover, // This will ensure the image covers the container
            ),
          ),
          const SizedBox(height: 12),
          Text(
            content.title,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.pink[800],
              fontFamily: 'Brand Bold',
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Text(
            content.description,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: content.features.map((feature) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: _buildFeatureItem(feature.icon, feature.label),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildPageIndicator() {
    List<Widget> indicators = [];
    for (int i = 0; i < _pages.length; i++) {
      indicators.add(
        Container(
          width: 8,
          height: 8,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: i == _currentPage ? Colors.pink[800] : Colors.grey[300],
          ),
        ),
      );
    }
    return indicators;
  }

  Widget _buildButton(BuildContext context) {
    final isLastPage = _currentPage == _pages.length - 1;
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        color: Colors.pink[800],
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.pink[800]!.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            if (isLastPage) {
              context.read<OnboardingCubit>().openLoginView(context);
            } else {
              _pageController.nextPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  isLastPage ? 'Get Started' : 'Next',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                    fontFamily: 'Brand Bold',
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.arrow_forward_rounded,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureItem(IconData icon, String label) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.pink[100]!.withOpacity(0.5),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Icon(
            icon,
            color: Colors.pink[800],
            size: 28,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.grey[700],
            height: 1.2,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class OnboardingContent {
  final String image;
  final String title;
  final String description;
  final List<FeatureItem> features;

  OnboardingContent({
    required this.image,
    required this.title,
    required this.description,
    required this.features,
  });
}

class FeatureItem {
  final IconData icon;
  final String label;

  FeatureItem(this.icon, this.label);
}
