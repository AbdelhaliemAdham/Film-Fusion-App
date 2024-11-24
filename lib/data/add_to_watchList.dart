import 'package:get/get.dart';
import 'package:movie/Models/Movie.dart';
import 'package:movie/helper/snackbar.dart';

class AddToWatchList extends GetxController {
  List<Movies> movies = [];
  Rx<bool> isMovieAdded = false.obs;

  addMovieToWatchList(Movies movie) {
    if (!movies.contains(movie)) {
      movies.add(movie);
      update();
    } else {
      HelperFun.showSnackBarWidegt(
          'You already added this product to watch list', 'Movie');
      return;
    }
  }

  removeMovieFromWatchList(Movies movie) {
    movies.remove(movie);
    update();
  }

  isMovieAddedWatchList(Movies movie) {
    return movies.contains(movie);
  }
}
