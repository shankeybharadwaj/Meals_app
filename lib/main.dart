import 'package:flutter/material.dart';
import './dummy_data.dart';
import './screens/filters_screen.dart';
import './screens/tabs_screen.dart';
import './screens/meal_detail_screen.dart';
import './screens/category_meals_screen.dart';
import './screens/categories_screen.dart';
import './models/meal.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'vegan': false,
    'lactose': false,
    'vegetarion': false,
  };

  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favouriteMeals = [];

  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;
      _availableMeals = DUMMY_MEALS.where((element) {
        if (_filters['gluten'] && !element.isGlutenFree) {
          return false;
        }
        if (_filters['vegan'] && !element.isVegan) {
          return false;
        }
        if (_filters['lactose'] && !element.isLactoseFree) {
          return false;
        }
        if (_filters['vegetarion'] && !element.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void _toggleFavourites(String mealId) {
    final existingIndex =
        _favouriteMeals.indexWhere((element) => element.id == mealId);
    if (existingIndex >= 0) {
      setState(() {
        _favouriteMeals.removeAt(existingIndex);
      });
    } else {
      setState(() {
        _favouriteMeals
            .add(DUMMY_MEALS.firstWhere((element) => element.id == mealId));
      });
    }
  }

  bool _isMealFavourite(String mealId) {
    return _favouriteMeals.any((element) => element.id == mealId);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
            body1: TextStyle(
              color: Color.fromRGBO(20, 51, 51, 1),
            ),
            body2: TextStyle(
              color: Color.fromRGBO(20, 51, 51, 1),
            ),
            title: TextStyle(
              fontSize: 20,
              fontFamily: 'RobotoCondensed',
              fontWeight: FontWeight.bold,
            )),
      ),
      //home: CategoriesScreen(),
      initialRoute: '/', // default is '/'
      routes: {
        '/': (ctx) => TabsScreen(_favouriteMeals),
        CategoryMealsScreen.routeName: (ctx) =>
            CategoryMealsScreen(_availableMeals),
        MealDetailScreen.routeName: (ctx) =>
            MealDetailScreen(_toggleFavourites, _isMealFavourite),
        FiltersScreen.routeName: (ctx) => FiltersScreen(_filters, _setFilters),
      },
      onGenerateRoute: (settings) {
        // if some requested route is not found, then it will navigate to CategoriesScreen()
        print(settings.arguments);
        //return MaterialPageRoute(builder: (ctx) => CategoriesScreen());
      },
      onUnknownRoute: (settings) {
        // when no routes found and its going into an error page, then this..
        return MaterialPageRoute(builder: (ctx) => CategoriesScreen());
      },
    );
  }
}
