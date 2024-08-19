import 'package:equatable/equatable.dart';

class MovieEntity extends Equatable{
  final String? posterPath;
  final int id;
  final String title;
  final String? backdropPath;
  final num? voteAverage;
  final String? releaseDate;
  final String? overview;

  const MovieEntity({
    required this.posterPath,
    required this.id,
     required this.title,
    required this.backdropPath,
    required this.voteAverage,
   required this.releaseDate,
    this.overview,

  }); //: assert(id!=null, "id cant be null");
  @override
  List<Object> get props => [id, title];
  //id ve titleları karşılaştırır.
  @override 
  bool get stringify => true;
  //otomatik olarak toString yapar.

}