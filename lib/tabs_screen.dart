import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/categories_screen.dart';
import 'package:meals_app/filters_screen.dart';
import 'package:meals_app/main_drawer.dart';
import 'package:meals_app/meals.dart';
import 'package:meals_app/providers/favorite_meals_provider.dart';
import 'package:meals_app/providers/filter_provider.dart';

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedPageIndex = 0;

  void _selectPageIndex(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _selectScreen(String identifer) async {
    Navigator.pop(context);
    if (identifer == 'filters') {
      Navigator.push<Map<Filter, bool>>(
        context,
        MaterialPageRoute(
          builder: (ctx) => FiltersScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage = CatagoriesScreen(
      activeMeals: ref.watch(filterMealsProvider),
    );
    String activeTitle = 'Categories';

    if (_selectedPageIndex == 1) {
      final favoriteMeals = ref.watch(favoriteMealsProvider);
      activePage = Meals(
        meals: favoriteMeals,
      );

      activeTitle = 'Favorites';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activeTitle),
      ),
      drawer: MainDrawer(
        onSelectScreen: _selectScreen,
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPageIndex,
        onTap: _selectPageIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favorites',
          )
        ],
      ),
    );
  }
}
