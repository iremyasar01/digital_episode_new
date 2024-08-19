import 'package:equatable/equatable.dart';

class MovieDetailEntity extends Equatable{
  final int id;
  final String title;
  final String overview;
  final String releaseDate;
  final num voteAverage;
  final String backdropPath;
  const MovieDetailEntity(
    this.id,
    this.title,
    this.overview,
    this.releaseDate,
    this.voteAverage,
    this.backdropPath,
  );
  @override
  // TODO: implement props
  List<Object?> get props => [id];

}