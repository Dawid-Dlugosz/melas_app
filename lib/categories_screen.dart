import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/meals.dart';
import 'package:meals_app/model/category.dart';
import 'package:meals_app/model/meal.dart';
import 'package:meals_app/widgets/catagory_grid_item.dart';

class CatagoriesScreen extends StatefulWidget {
  const CatagoriesScreen({
    required this.activeMeals,
    super.key,
  });

  final List<Meal> activeMeals;

  @override
  State<CatagoriesScreen> createState() => _CatagoriesScreenState();
}

class _CatagoriesScreenState extends State<CatagoriesScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 300),
        lowerBound: 0,
        upperBound: 1);

    _controller.forward();

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onSelectedCategory({
    required BuildContext context,
    required Category category,
  }) {
    final filteredMeals = widget.activeMeals
        .where((element) => element.categories.contains(category.id))
        .toList();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => Meals(
          meals: filteredMeals,
          title: category.title,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SlideTransition(
        position: Tween(
          begin: const Offset(0, 0.3),
          end: const Offset(0, 0),
        ).animate(
          CurvedAnimation(
            parent: _controller,
            curve: Curves.easeIn,
          ),
        ),
        child: GridView(
          padding: const EdgeInsets.all(24),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
          ),
          children: [
            for (final category in availableCategories)
              CategoryGridItem(
                category: category,
                onSelectedCatagory: () => _onSelectedCategory(
                  context: context,
                  category: category,
                ),
              )
          ],
        ),
      ),
    );
  }
}
