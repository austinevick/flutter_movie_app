class RecommendationResult {
  int? page;
  List<RecommendationModel>? results;

  RecommendationResult({this.page, this.results});

  factory RecommendationResult.fromJson(Map<String, dynamic> json) {
    return RecommendationResult(
      page: json['page'],
      results: List<RecommendationModel>.from(
          json['results']?.map((x) => RecommendationModel.fromMap(x))),
    );
  }
}

class RecommendationModel {
  final String? backdropPath;
  final List<int>? genreIds;
  final int? id;
  final String? mediaType;
  final String? title;
  final String? overview;
  final double popularity;
  final String posterPath;
  final String releaseDate;
  final double voteAverage;
  final int voteCount;
  RecommendationModel({
    this.backdropPath,
    this.genreIds,
    this.id,
    this.mediaType,
    this.title,
    this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.voteAverage,
    required this.voteCount,
  });

  factory RecommendationModel.fromMap(Map<String, dynamic> map) {
    return RecommendationModel(
      backdropPath: map['backdrop_path'],
      genreIds: List<int>.from(map['genre_ids']),
      id: map['id']?.toInt(),
      mediaType: map['media_type'],
      title: map['title'],
      overview: map['overview'],
      popularity: map['popularity']?.toDouble() ?? 0.0,
      posterPath: map['poster_path'] ?? '',
      releaseDate: map['release_date'] ?? '',
      voteAverage: map['vote_average']?.toDouble() ?? 0.0,
      voteCount: map['vote_count']?.toInt() ?? 0,
    );
  }
}
