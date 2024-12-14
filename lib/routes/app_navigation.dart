import 'package:get/get.dart';
import 'package:my_movies/views/favorites_screen.dart';
import 'package:my_movies/views/home_screen.dart';
import 'package:my_movies/views/movie_detail_screen.dart';

class Routes {
  static const String homePage = '/';
  static const String movieDetailPage = '/movieDetailPage';
  static const String favoriteScreen = '/favoriteScreen';
}

final getRoutes = [
  GetPage(
    name: Routes.homePage,
    page: () => const HomeScreen(),
  ),
  GetPage(
    name: Routes.movieDetailPage,
    page: () => MovieDetailScreen(),
  ),
  GetPage(
    name: Routes.favoriteScreen,
    page: () => const FavoriteScreen(),
  ),
];
