import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:my_movies/models/movies_list_model.dart';

class MoviesListController extends GetxController {
  //------------ Original Movies List fetch from Api ----------
  var movieList = <MovieListModel>[].obs;
  var isLoading = false.obs;

  //---------- Filtered List Movies --------------
  var filteredMovies = <MovieListModel>[].obs;

  //--------- TextEditing COntroller ------------
  TextEditingController searchController = TextEditingController();

  //-------- Get Storage ---------
  final storage = GetStorage(); // Instance of GetStorage
  final favoritesKey = "favoriteMovies";

  RxList<MovieListModel> favoriteMovies = <MovieListModel>[].obs;

  Future<void> fetchMovies() async {
    try {
      isLoading.value = true;
      var response = await http
          .get(Uri.parse("https://api.sampleapis.com/movies/animation"));
      if (response.statusCode == 200) {
        var data = (json.decode(response.body) ?? []) as List;
        movieList.value =
            data.map((obj) => MovieListModel.fromJson(obj)).toList();
        filteredMovies.assignAll(movieList);
      }
    } catch (e) {
      debugPrint("Error fetching movies : $e");
    } finally {
      isLoading.value = false;
    }
  }

  //---------- Filter Method ----------
  void filterMovies(String query) {
    if (query.isEmpty) {
      filteredMovies.assignAll(movieList);
    } else {
      filteredMovies.assignAll(movieList.where(
          (movie) => movie.title.toLowerCase().contains(query.toLowerCase())));
    }
  }

  //----------Toggle favorite movie----------
  void toggleFavorite(MovieListModel movie) {
    if (favoriteMovies.contains(movie)) {
      favoriteMovies.remove(movie);
    } else {
      favoriteMovies.add(movie);
    }
    saveFavorites();
  }

  //-----------Check if a movie is a favorite------------
  bool isFavorite(MovieListModel movie) {
    return favoriteMovies.contains(movie);
  }

  //-----------Save favorites to GetStorage----------------
  void saveFavorites() {
    List<Map<String, dynamic>> jsonList =
        favoriteMovies.map((movie) => movie.toJson()).toList();
    storage.write(favoritesKey, jsonEncode(jsonList));
  }

  //----------Load favorites from GetStorage-----------------
  void loadFavorites() {
    String? jsonString = storage.read<String>(favoritesKey);
    if (jsonString != null) {
      List<dynamic> jsonList = jsonDecode(jsonString);
      favoriteMovies.value = jsonList
          .map((jsonItem) => MovieListModel.fromJson(jsonItem))
          .toList();
    }
  }
}
