// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'package:movie/Models/Movie.dart';
import 'package:movie/helper/constants.dart';

class PlayingMoviesWidget extends StatefulWidget {
  const PlayingMoviesWidget({
    Key? key,
    required this.movies,
  }) : super(key: key);
  final List<Movies>? movies;

  @override
  State<PlayingMoviesWidget> createState() => _PlayingMoviesWidgetState();
}

class _PlayingMoviesWidgetState extends State<PlayingMoviesWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 300,
      child: CarouselSlider.builder(
        itemCount: widget.movies!.length,
        itemBuilder: (context, index, n) {
          return InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/movieDetails',
                  arguments: widget.movies![index]);
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                color: Colors.red,
                height: 300,
                width: 200,
                child: Image.network(
                  "${Constants.imagePath}${widget.movies![index].posterPath}",
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
        options: CarouselOptions(
          enlargeCenterPage: true,
          viewportFraction: 0.55,
          height: 300,
          autoPlay: true,
          autoPlayCurve: Curves.easeInOut,
          pageSnapping: true,
        ),
      ),
    );
  }
}
