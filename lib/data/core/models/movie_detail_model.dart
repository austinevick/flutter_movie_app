class MovieDetailModel {
  final List<Genres> genres;
  final List<Companies> companies;
  final String homepage;
  final int id;
  final String originalTitle;
  final String overview;
  final double popularity;
  final String posterPath;
  final String title;
  final String releaseDate;
  final bool video;
  final double voteAverage;
  final int voteCount;
  final String backdropPath;
  const MovieDetailModel({
    required this.releaseDate,
    required this.genres,
    required this.homepage,
    required this.id,
    required this.originalTitle,
    required this.companies,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
    required this.backdropPath,
  });

  factory MovieDetailModel.fromJson(Map<String, dynamic> map) {
    return MovieDetailModel(
      genres: List<Genres>.from(map['genres']?.map((x) => Genres.fromMap(x))),
      companies: List<Companies>.from(
          map['production_companies']?.map((x) => Companies.fromMap(x))),
      homepage: map['homepage'] ?? '',
      id: map['id']?.toInt(),
      originalTitle: map['original_title'] ?? '',
      overview: map['overview'] ?? '',
      releaseDate: map['release_date'],
      popularity: map['popularity']?.toDouble() ?? 0.0,
      posterPath: map['poster_path'],
      title: map['title'] ?? '',
      video: map['video'] ?? false,
      voteAverage: map['vote_average']?.toDouble() ?? 0.0,
      voteCount: map['vote_count']?.toInt() ?? 0,
      backdropPath: map['backdrop_path'] ?? '',
    );
  }
}

class Companies {
  final String? logoPath;
  final String? name;
  final String? country;
  Companies({
    this.logoPath,
    this.name,
    this.country,
  });

  factory Companies.fromMap(Map<String, dynamic> map) {
    return Companies(
      logoPath: map['logo_path'],
      name: map['name'],
      country: map['origin_country'],
    );
  }
}

class Genres {
  final int id;
  final String name;
  Genres({
    required this.id,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  factory Genres.fromMap(Map<String, dynamic> map) {
    return Genres(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
    );
  }
}
