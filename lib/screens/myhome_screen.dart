import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie/Models/user.dart';
import 'package:movie/data/PlayingMoviesApi.dart';
import 'package:movie/data/airing_series_api.dart';
import 'package:movie/data/comming_movie_api.dart';
import 'package:movie/data/top_rated_api.dart';
import 'package:movie/data/user_controller.dart';
import 'package:movie/helper/assets.dart';
import 'package:movie/helper/routes.dart';
import 'package:movie/widgets/playing_movies_widget.dart';
import 'package:movie/widgets/series_widget.dart';
import 'package:movie/widgets/top_reted.dart';
import 'package:movie/widgets/upcoming_movies.dart';
import 'package:skeletonizer/skeletonizer.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final UserController _userController = Get.find<UserController>();
  UserModel? _userModel;
  bool enabled = true;
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 4), () {
      setState(() {
        enabled = false;
      });
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _userController.getUserData().then((value) {
        _userModel = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Skeletonizer(
            enabled: enabled,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: CircleAvatar(
                            radius: 20,
                            backgroundImage: AssetImage(Assets.logo),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Film Fusion',
                                style: Theme.of(context).textTheme.titleLarge),
                            Text('Welcome , ${_userModel?.fullName ?? ''}',
                                style: Theme.of(context).textTheme.bodyLarge!),
                          ],
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.pushNamed(
                                context, StaticRoutes.searchScreen);
                          },
                          icon: const Icon(
                            Icons.search,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    'Trending Movies',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                SizedBox(
                  child: FutureBuilder(
                      future: PlayingMoviesApi.fetchPlayingMovies(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else if (!snapshot.hasData) {
                          return const SizedBox.shrink();
                        }
                        return PlayingMoviesWidget(movies: snapshot.data);
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    'Top Rated Movies',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                SizedBox(
                  child: FutureBuilder(
                    future: TopRatedApi.fetchTopRatedMovies(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else if (!snapshot.hasData) {
                        return const SizedBox.shrink();
                      }
                      return TopRatedMovie(movies: snapshot.data);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    'Up Comming Movies',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                SizedBox(
                  child: FutureBuilder(
                    future: UpCommingMoviesApi.fetchCommingMovies(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else if (!snapshot.hasData) {
                        return const SizedBox.shrink();
                      }
                      return UpComingMovies(movies: snapshot.data);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    'Airing Today Series',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                SizedBox(
                  child: FutureBuilder(
                    future: AiringSeriesApi.fetchAiringSeries(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else if (!snapshot.hasData) {
                        return const SizedBox.shrink();
                      }
                      return AiringSeriesWidget(series: snapshot.data);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
