import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_db_app/constants/navigation.dart';

import 'package:movie_db_app/utils/debouncer.dart';
import 'package:movie_db_app/widgets/list_tile_search.dart';
import 'package:movie_db_app/widgets/search_form_field.dart';
import 'package:movie_db_app/blocs/searchmovie/search_movie_cubit.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _textFieldController = TextEditingController();
  Debouncer _debouncer = Debouncer(milliseconds: 1000);

  @override
  void initState() {
    context.read<SearchMovieCubit>().reset();
    super.initState();
  }

  @override
  void dispose() {
    _textFieldController.dispose();
    super.dispose();
  }

  void _getSearchMovies(String query) {
    // _debouncer.run(() => context.read<SearchMovieCubit>().getSearchMovies(query));
    context.read<SearchMovieCubit>().getSearchMovies(query);
  }

  void _onPressClear() {
    _textFieldController.clear();
    context.read<SearchMovieCubit>().reset();
  }

  void _onPressMovie(int movieId) {
    if (movieId != null) {
      Navigator.pushNamed(context, Navigation.MovieDetail, arguments: movieId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1.0,
        title: _buildSearchField(),
        actions: [
          IconButton(
            icon: Icon(Icons.close),
            onPressed: _onPressClear,
          ),
        ],
      ),
      body: BlocBuilder<SearchMovieCubit, SearchMovieState>(
        builder: (context, state) {
          if (state is SearchMovieLoadInProgress) {
            return Center(
              child: Transform.scale(
                scale: 1,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Colors.white,
                  ),
                ),
              ),
            );
          } else if (state is SearchMovieLoadSuccess) {
            return ListView.builder(
              itemCount: state.searchMovieResult.length,
              itemBuilder: (context, index) {
                var data = state.searchMovieResult[index];
                return ListTileSearch(
                  poster: data.posterPath,
                  title: data.title,
                  date: data.releaseDate,
                  onTap: () => _onPressMovie(data.id),
                );
              },
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }

  _buildSearchField() {
    return SearchFormField(
      controller: _textFieldController,
      onChanged: (query) => print("onchange $query")/*_getSearchMovies(query)*/,
      onSubmitted: (query) => _getSearchMovies(query),
      placeHolder: 'Search',

    );
  }
}
