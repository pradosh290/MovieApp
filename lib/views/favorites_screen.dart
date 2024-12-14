import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_movies/controllers/movies_list_controller.dart';
import 'package:shimmer/shimmer.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final MoviesListController movieListCont = Get.find<MoviesListController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorites"),
      ),
      body: Obx(() {
        if (movieListCont.favoriteMovies.isEmpty) {
          return const Center(
            child: Text(
              'No favorites added yet.',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(8.0),
          itemCount: movieListCont.favoriteMovies.length,
          itemBuilder: (context, index) {
            final movie = movieListCont.favoriteMovies[index];
            return ListTile(
              leading: CachedNetworkImage(
                imageUrl: movie.posterUrl,
                width: 50,
                height: 75,
                fit: BoxFit.cover,
                placeholder: (context, url) => Shimmer.fromColors(
                  baseColor: Colors.grey,
                  highlightColor: Colors.grey.withOpacity(0.3),
                  child: Container(
                    width: 50,
                    height: 75,
                    color: Colors.white,
                  ),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
              title: Text(movie.title),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  movieListCont.toggleFavorite(movie);
                },
              ),
            );
          },
        );
      }),
    );
  }
}
