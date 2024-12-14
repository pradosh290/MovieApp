import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_movies/controllers/movies_list_controller.dart';
import 'package:my_movies/routes/app_navigation.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MoviesListController>(
      initState: (state) {
        Get.find<MoviesListController>().fetchMovies();
        Get.find<MoviesListController>().loadFavorites();
      },
      builder: (movieListCont) => Scaffold(
          appBar: AppBar(
            surfaceTintColor: Colors.transparent,
            title: TextFormField(
              controller: movieListCont.searchController,
              decoration: const InputDecoration(
                hintText: 'Search movies...',
                border: InputBorder.none,
              ),
              onChanged: (value) {
                movieListCont.filterMovies(value);
              },
            ),
            actions: [
              //-------- Search ---------
              IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
              //-------- Favorite -------
              IconButton(
                  onPressed: () {
                    Get.toNamed(Routes.favoriteScreen);
                  },
                  icon: const Icon(Icons.favorite_border))
            ],
          ),
          body: Obx(
            () {
              return movieListCont.isLoading.value
                  ? const Center(child: CircularProgressIndicator())
                  : movieListCont.filteredMovies.isEmpty
                      ? const Center(
                          child: Text(
                          'No movies found.',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ))
                      : GridView.builder(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 15),
                          itemCount: movieListCont.filteredMovies.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 15,
                            crossAxisSpacing: 15,
                            mainAxisExtent: 280,
                          ),
                          itemBuilder: (context, index) {
                            final movieData =
                                movieListCont.filteredMovies[index];
                            return InkWell(
                              onTap: () {
                                //------ Navigate to Movie Detail page
                                Get.toNamed(Routes.movieDetailPage,
                                    arguments: movieData);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 4,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: CachedNetworkImage(
                                        imageUrl: movieData.posterUrl,
                                        fit: BoxFit.cover,
                                        width: double.maxFinite,
                                        placeholder: (context, url) =>
                                            Shimmer.fromColors(
                                          baseColor: Colors.grey,
                                          highlightColor:
                                              Colors.grey.withOpacity(0.3),
                                          child: Center(
                                            child: Container(
                                              width: double.infinity,
                                              height: double.infinity,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        movieData.title,
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                        textAlign: TextAlign.center,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
            },
          )),
    );
  }
}
