// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:movie/Models/Movie.dart';
import 'package:movie/data/add_to_watchList.dart';
import 'package:movie/helper/assets.dart';
import 'package:movie/helper/constants.dart';

class TopRatedMovie extends StatefulWidget {
  const TopRatedMovie({
    Key? key,
    this.movies,
  }) : super(key: key);
  final List<Movies>? movies;

  @override
  State<TopRatedMovie> createState() => _TopRatedMovieState();
}

class _TopRatedMovieState extends State<TopRatedMovie> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AddToWatchList>();
    return SizedBox(
      height: 280,
      width: double.infinity,
      child: GetBuilder(
          init: controller,
          builder: (AddToWatchList moviesController) {
            return ListView.builder(
                itemCount: widget.movies!.length,
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/movieDetails',
                          arguments: widget.movies![index]);
                    },
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              height: 240,
                              width: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.network(
                                  "${Constants.imagePath}${widget.movies![index].posterPath!}",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              top: 15,
                              right: 15,
                              child: InkWell(
                                onTap: () {
                                  moviesController.addMovieToWatchList(
                                      widget.movies![index]);
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(3),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.black.withOpacity(0.5),
                                  ),
                                  child: Image.asset(
                                    Assets.bookMark,
                                    width: 18,
                                    height: 18,
                                    color:
                                        moviesController.isMovieAddedWatchList(
                                                widget.movies![index])
                                            ? Colors.yellow
                                            : Colors.white,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.9),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: SizedBox(
                                  width: 120,
                                  child: Text(
                                    widget.movies![index].title!,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Row(
                                  children: [
                                    Icon(Icons.star,
                                        color: Colors.yellow, size: 15),
                                    SizedBox(width: 5),
                                    Text(
                                        widget.movies![index].voteAverage!
                                            .toStringAsFixed(1),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall)
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                });
          }),
    );
  }
}
