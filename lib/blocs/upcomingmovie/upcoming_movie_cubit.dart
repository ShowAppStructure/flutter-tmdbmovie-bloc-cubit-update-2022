import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_db_app/models/movie_list.dart';

import 'package:movie_db_app/repositories/upcoming_movie_repository.dart';

part 'upcoming_movie_state.dart';

class UpcomingMovieCubit extends Cubit<UpcomingMovieState> {
  UpcomingMovieCubit() : super(UpcomingMovieInitial());

  UpcomingMovieRepository repository = UpcomingMovieRepository();

  Future<void> getUpcomingMovies() async {
    try {
      emit(UpcomingMovieLoadInProgress());
      final upcomingMovies = await repository.getUpcomingMovies();
      emit(UpcomingMovieLoadSuccess(upcomingMovies));
    } catch (e) {
      emit(UpcomingMovieLoadFailure());
    }
  }
}
