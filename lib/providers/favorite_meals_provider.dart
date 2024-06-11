import 'package:meals_app/model/meal.dart';
import 'package:riverpod/riverpod.dart';

class FavoriteMealsNotifier extends StateNotifier<List<Meal>> {
  FavoriteMealsNotifier() : super([]);

  bool toogleFavoriteMeal(Meal meal) {
    final isFavoriteMeal = state.contains(meal);

    if (isFavoriteMeal) {
      state = state.where((m) => m.id != meal.id).toList();
      return false;
    } else {
      state = [...state, meal];
      return true;
    }
  }
}

final favoriteMealsProvider =
    StateNotifierProvider<FavoriteMealsNotifier, List<Meal>>(
  (ref) => FavoriteMealsNotifier(),
);
