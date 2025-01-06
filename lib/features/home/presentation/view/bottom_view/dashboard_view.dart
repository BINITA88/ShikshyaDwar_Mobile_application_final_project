import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shikshyadwar_mobile_application_project/features/home/presentation/widget/mycart.dart';
import 'package:shikshyadwar_mobile_application_project/features/home/presentation/widget/top_categories.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shikshyadwar_mobile_application_project/features/home/presentation/view_model/home_cubit.dart';
import 'package:shikshyadwar_mobile_application_project/features/home/presentation/view_model/home_state.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  _DashboardViewState createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  late Timer _carouselTimer;

  @override
  void initState() {
    super.initState();
    _startCarouselAutoPlay();
  }

  @override
  void dispose() {
    _carouselTimer.cancel();
    super.dispose();
  }

  void _startCarouselAutoPlay() {
    _carouselTimer = Timer.periodic(const Duration(seconds: 3), (_) {
      final cubit = context.read<HomeCubit>();
      int nextIndex = (cubit.state.currentCarouselIndex + 1) %
          cubit.state.carouselImages.length;
      cubit.updateCarouselIndex(nextIndex);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Carousel Section
          SizedBox(
            height: 260,
            width: double.infinity,
            child: Stack(
              children: [
                BlocBuilder<HomeCubit, HomeState>(
                  builder: (context, state) {
                    return PageView.builder(
                      onPageChanged: (index) {
                        context.read<HomeCubit>().updateCarouselIndex(index);
                      },
                      itemCount: state.carouselImages.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10.0),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                            image: DecorationImage(
                              image: AssetImage(state.carouselImages[index]),
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
                Positioned(
                  bottom: 10,
                  left: 0,
                  right: 0,
                  child: BlocBuilder<HomeCubit, HomeState>(
                    builder: (context, state) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          state.carouselImages.length,
                          (index) => AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            width: state.currentCarouselIndex == index
                                ? 12.0
                                : 8.0,
                            height: 8.0,
                            margin: const EdgeInsets.symmetric(horizontal: 3.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: state.currentCarouselIndex == index
                                  ? Theme.of(context).primaryColor
                                  : Colors.grey,
                            ),
                          ),
                        ),
                      );
                    },
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
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
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
            child: BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: state.products.length,
                  itemBuilder: (context, i) {
                    var product = state.products[i];
                    return Mycart(
                      image: product["image"]!,
                      title: product["title"]!,
                      date: product["date"]!,
                      duration: product["duration"]!,
                      onPressed: () {
                        // Handle 'Add to Schedule' button press
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
