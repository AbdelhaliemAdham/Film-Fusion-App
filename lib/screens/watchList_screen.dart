import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie/data/add_to_watchList.dart';
import 'package:movie/helper/constants.dart';
import 'package:movie/helper/routes.dart';

class WatchListScreen extends StatefulWidget {
  const WatchListScreen({super.key});

  @override
  State<WatchListScreen> createState() => _WatchListScreenState();
}

class _WatchListScreenState extends State<WatchListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Watch List',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: GetBuilder(
        init: AddToWatchList(),
        builder: (getController) {
          return SingleChildScrollView(
            child: SizedBox(
                width: MediaQuery.sizeOf(context).width,
                height: MediaQuery.of(context).size.height,
                child: Container(
                    margin: const EdgeInsets.only(left: 8.0, bottom: 8),
                    child: GridView.builder(
                        shrinkWrap: true,
                        itemCount: getController.movies.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                childAspectRatio: 3 / 4,
                                crossAxisSpacing: 3,
                                crossAxisCount: 2),
                        itemBuilder: (context, index) {
                          return InkWell(
                            onLongPress: () async {
                              await showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title:
                                          const Text('Delete from Watch List'),
                                      content: const Text(
                                        'Are you sure you want to delete this movie from your watch list?',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Get.back();
                                          },
                                          child: const Text('Cancel'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            getController
                                                .removeMovieFromWatchList(
                                                    getController
                                                        .movies[index]);
                                            Get.back();
                                          },
                                          child: const Text('Yes'),
                                        ),
                                      ],
                                    );
                                  });
                            },
                            onTap: () {
                              Navigator.pushNamed(
                                  context, StaticRoutes.movieDetails,
                                  arguments: getController.movies[index]);
                            },
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 8.0),
                              child: Stack(
                                children: [
                                  SizedBox(
                                    width: 180,
                                    height: 300,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Image.network(
                                        "${Constants.imagePath}${getController.movies[index].posterPath}",
                                        errorBuilder: (context, ob, trace) {
                                          return Image.asset(
                                            'assets/images/profile.png',
                                            fit: BoxFit.cover,
                                          );
                                        },
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 8,
                                    right: 6,
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.star,
                                          color: Colors.yellow,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Text(
                                            getController
                                                .movies[index].voteAverage!
                                                .toStringAsFixed(1),
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        }))),
          );
        },
      ),
    );
  }
}
