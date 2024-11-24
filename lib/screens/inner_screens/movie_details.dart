import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie/Models/Movie.dart';
import 'package:movie/data/add_to_watchList.dart';
import 'package:movie/data/similar_movies.dart';
import 'package:movie/helper/assets.dart';
import 'package:movie/helper/constants.dart';
import 'package:movie/helper/routes.dart';
import 'package:movie/widgets/custom_button.dart';
import 'package:share_plus/share_plus.dart';

class MovieDetails extends StatefulWidget {
  const MovieDetails({super.key});

  @override
  State<MovieDetails> createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  @override
  Widget build(BuildContext context) {
    Movies movies = ModalRoute.of(context)!.settings.arguments as Movies;
    final controller = Get.find<AddToWatchList>();
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Stack(
            children: [
              Flexible(
                child: Image.network(
                  "${Constants.imagePath}${movies.posterPath!}",
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 50,
                right: 30,
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.3),
                    shape: BoxShape.circle,
                  ),
                  child: InkWell(
                    onTap: () async {
                      await Share.share('check out this movie ${movies.title} ',
                          subject: 'Look what I found!');
                    },
                    child: const Icon(Icons.share),
                  ),
                ),
              ),
              Positioned(
                top: 50,
                left: 30,
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.3),
                    shape: BoxShape.circle,
                  ),
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(Icons.arrow_back_ios),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  height: 100,
                  width: MediaQuery.sizeOf(context).width,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Color.fromRGBO(14, 15, 22, 1)
                        ],
                        stops: [
                          0,
                          0.8,
                        ]),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 10.0, right: 10),
                            child: Text(movies.title.toString(),
                                style: Theme.of(context).textTheme.titleSmall!),
                          ),
                          Container(
                            height: 50,
                            margin: const EdgeInsets.all(10),
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.transparent,
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10.0, right: 10),
                                  child: Text(
                                    movies.voteAverage!.toStringAsFixed(1),
                                    style:
                                        Theme.of(context).textTheme.titleSmall!,
                                  ),
                                ),
                                Text(
                                  movies.adult == true ? '18+' : '+12',
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0, right: 10),
                        child: Text(
                          'Release Date: ${getDateFormated(movies.releaseDate)}',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              'Overview: ${movies.overview}',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(fontSize: 13, color: Colors.grey),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Similar Movies',
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
          SizedBox(
            height: 100,
            child: FutureBuilder(
                future: SimilarMovies.fetchSimilarMovies(movies.id!),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const SizedBox.shrink();
                  }
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data!.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, '/movieDetails',
                                arguments: snapshot.data![index]);
                          },
                          child: CircleAvatar(
                            radius: 50,
                            backgroundImage: NetworkImage(
                                "${Constants.imagePath}${snapshot.data![index].posterPath!}"),
                          ),
                        ),
                      );
                    },
                  );
                }),
          ),
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0, left: 8, right: 8),
            child: CustomButton(
              onPressed: () {},
              text: 'Watch Triller',
              color: Colors.grey,
              image: Assets.video,
              imageColor: Colors.white,
              isLoading: false,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0, left: 8, right: 8),
            child: CustomButton(
              text: 'Add to Watch List',
              color: Colors.purple,
              image: Assets.bookMark,
              imageColor: Colors.white,
              isLoading: false,
              onPressed: () {
                controller.addMovieToWatchList(movies);
                Navigator.pushNamed(context, StaticRoutes.watchList);
              },
            ),
          ),
        ]),
      ),
    );
  }
}

getDateFormated(DateTime? dateTime) {
  if (dateTime == null) {
    return 'No Date';
  }
  return '${dateTime.year} - ${dateTime.month} - ${dateTime.day}';
}
