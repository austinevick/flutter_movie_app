class MovieTrailerResult {
  int? id;
  List<MovieTrailerModel>? results;

  MovieTrailerResult({
    this.id,
    this.results,
  });

  factory MovieTrailerResult.fromMap(Map<String, dynamic> map) {
    return MovieTrailerResult(
      id: map['id']?.toInt(),
      results: map['results'] != null
          ? List<MovieTrailerModel>.from(
              map['results']?.map((x) => MovieTrailerModel.fromMap(x)))
          : null,
    );
  }
}

class MovieTrailerModel {
  final String? name;
  final String? key;
  final String? publishedAt;
  final String? type;
  final String? id;
  MovieTrailerModel({
    this.name,
    this.key,
    this.publishedAt,
    this.type,
    this.id,
  });

  factory MovieTrailerModel.fromMap(Map<String, dynamic> map) {
    return MovieTrailerModel(
      name: map['name'] ?? '',
      key: map['key'] ?? '',
      publishedAt: map['published_at'] ?? '',
      type: map['type'] ?? '',
      id: map['id'] ?? '',
    );
  }
}
