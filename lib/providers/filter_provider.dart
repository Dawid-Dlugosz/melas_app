import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/model/meal.dart';
import 'package:meals_app/providers/meals_providers.dart';

enum Filter {
  gluttenFree,
  lactosFree,
  vegetarian,
  vegan,
}

const kInitialFilter = {
  Filter.gluttenFree: false,
  Filter.lactosFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false,
};

class FilterNotifier extends StateNotifier<Map<Filter, bool>> {
  FilterNotifier() : super(kInitialFilter);

  void setAllFilters(Map<Filter, bool> choosenFilters) {
    state = choosenFilters;
  }

  void setFilter(Filter filter, bool value) {
    state = {
      ...state,
      filter: value,
    };
  }
}

final filterProvider = StateNotifierProvider<FilterNotifier, Map<Filter, bool>>(
    (ref) => FilterNotifier());

final filterMealsProvider = Provider<List<Meal>>((ref) {
  final meals = ref.watch(mealsPorivder);
  final filters = ref.watch(filterProvider);

  return meals.where((meal) {
    if (filters[Filter.gluttenFree]! && !meal.isGlutenFree) {
      return false;
    }
    if (filters[Filter.lactosFree]! && !meal.isLactoseFree) {
      return false;
    }
    if (filters[Filter.vegetarian]! && !meal.isVegetarian) {
      return false;
    }
    if (filters[Filter.vegan]! && !meal.isVegan) {
      return false;
    }
    return true;
  }).toList();
});
