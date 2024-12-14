class MovieListModel {
  final int id;
  final String title;
  final String posterUrl;
  final String imdbId;

  MovieListModel({
    required this.id,
    required this.title,
    required this.posterUrl,
    required this.imdbId,
  });

  factory MovieListModel.fromJson(Map<String, dynamic> json) => MovieListModel(
        id: json["id"] ?? 0,
        title: json["title"] ?? '',
        posterUrl: json["posterURL"] ?? '',
        imdbId: json["imdbId"] ?? '',
      );

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "posterURL": posterUrl,
      "imdbId": imdbId,
    };
  }
}
