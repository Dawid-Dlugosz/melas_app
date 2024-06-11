import 'package:flutter/material.dart';
import 'package:meals_app/meal_details.dart';
import 'package:meals_app/model/meal.dart';
import 'package:meals_app/widgets/meal_item.dart';

class Meals extends StatelessWidget {
  const Meals({
    required this.meals,
    this.title,
    super.key,
  });

  final List<Meal> meals;

  final String? title;

  void selectMeal(BuildContext context, Meal meal) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => MealDetails(
          meal: meal,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (meals.isEmpty) {}
    return Scaffold(
      appBar: title != null
          ? AppBar(
              title: Text(title!),
            )
          : null,
      body: meals.isEmpty
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Uh noo... Nothing here',
                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Try selected another category',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                  )
                ],
              ),
            )
          : ListView.builder(
              itemCount: meals.length,
              itemBuilder: (ctx, index) {
                return MealItem(
                  meals[index],
                  selectMeal,
                );
              },
            ),
    );
  }
}
