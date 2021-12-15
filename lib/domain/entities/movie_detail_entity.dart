import 'package:equatable/equatable.dart';

class MovieDetailEntity extends Equatable {
  final int? id;
  final String? overview;
  final double? popularity;
  final String? posterPath;
  final String? title;
  final double? voteAverage;
  final int? voteCount;
  final String? backdropPath;
  const MovieDetailEntity({
    this.id,
    this.overview,
    this.popularity,
    this.posterPath,
    this.title,
    this.voteAverage,
    this.voteCount,
    this.backdropPath,
  });
  @override
  List<Object?> get props => [id];
}
