import 'package:meals_app/data/dummy_data.dart';
import 'package:riverpod/riverpod.dart';

final mealsPorivder = Provider((ref) => dummyMeals);
