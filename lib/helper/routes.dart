import 'package:flutter/material.dart';
import 'package:movie/screens/auth/login_screen.dart';
import 'package:movie/screens/auth/sign-up-screen.dart';
import 'package:movie/screens/categories_screen.dart';
import 'package:movie/screens/inner_screens/actor_movies.dart';
import 'package:movie/screens/main_screen.dart';
import 'package:movie/screens/inner_screens/movie_details.dart';
import 'package:movie/screens/myhome_screen.dart';
import 'package:movie/screens/profile_screen.dart';
import 'package:movie/screens/inner_screens/search_screen.dart';
import 'package:movie/screens/inner_screens/series_detail_screen.dart';
import 'package:movie/screens/watchList_screen.dart';

class StaticRoutes {
  static const String authGate = '/';
  static const String loginScreen = '/login-screen';
  static const String signUpScreen = '/sign-up-screen';
  static const String searchScreen = '/searchScreen';
  static const String mainScreen = '/mainScreen';
  static const String homeScreen = '/homeScreen';
  static const String movieDetails = '/movieDetails';
  static const String watchList = '/watchList';
  static const String seriesDetails = '/seriesDetails';
  static const String profileScreen = '/profileScreen';
  static const String categoriesScreen = '/categoriesScreen';
  static const String actorListMovies = '/actorListMovies';

  static Map<String, Widget Function(BuildContext context)> routes = {
    mainScreen: (context) => const MainScreen(),
    loginScreen: (context) => const LoginScreen(),
    signUpScreen: (context) => const SignUpScreen(),
    homeScreen: (context) => const MyHomePage(),
    movieDetails: (context) => const MovieDetails(),
    watchList: (context) => const WatchListScreen(),
    seriesDetails: (context) => const SeriesDetailsScreen(),
    profileScreen: (context) => const ProfileScreen(),
    searchScreen: (context) => const SearchScreen(),
    categoriesScreen: (context) => const CategoriesScreen(),
    actorListMovies: (context) => ActorListMovies(),
  };
}
