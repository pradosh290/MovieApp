import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_movies/controllers/movies_list_controller.dart';
import 'package:my_movies/models/movies_list_model.dart';
import 'package:shimmer/shimmer.dart';

class MovieDetailScreen extends StatelessWidget {
  MovieDetailScreen({
    super.key,
  });
  final MovieListModel movieListModelData = Get.arguments;

  @override
  Widget build(BuildContext context) {
    final MoviesListController movieListCont = Get.find<MoviesListController>();
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            onPressed: () {
              movieListCont.toggleFavorite(movieListModelData);
            },
            icon: Obx(() => Icon(
                  movieListCont.isFavorite(movieListModelData)
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color: Colors.red,
                )),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: Column(
        children: [
          Container(
            height: 300,
            width: double.maxFinite,
            color: Colors.white,
            child: CachedNetworkImage(
              imageUrl: movieListModelData.posterUrl,
              fit: BoxFit.cover,
              width: double.maxFinite,
              placeholder: (context, url) => Shimmer.fromColors(
                baseColor: Colors.grey,
                highlightColor: Colors.grey.withOpacity(0.3),
                child: Center(
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: Colors.white,
                  ),
                ),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    movieListModelData.title,
                    style: const TextStyle(
                        fontSize: 25, fontWeight: FontWeight.w500),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  "ID: ${movieListModelData.id}",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey.shade500,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    "Imdb ID : ${movieListModelData.imdbId}",
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
