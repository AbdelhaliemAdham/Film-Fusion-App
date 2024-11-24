import 'package:flutter/material.dart';
import 'package:movie/Models/Movie.dart';
import 'package:movie/helper/assets.dart';
import 'package:movie/helper/constants.dart';

class UpComingMovies extends StatelessWidget {
  const UpComingMovies({
    super.key,
    this.movies,
  });
  final List<Movies>? movies;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: double.infinity,
      child: ListView.builder(
          itemCount: movies!.length,
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Stack(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/movieDetails',
                        arguments: movies![index]);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    height: 200,
                    width: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        "${Constants.imagePath}${movies![index].posterPath!}",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Positioned(
                    top: 15,
                    right: 15,
                    child: InkWell(
                      onTap: () {
                        print('liked');
                      },
                      child: Container(
                        padding: EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black.withOpacity(0.5),
                        ),
                        child: Image.asset(
                          Assets.bookMark,
                          width: 18,
                          height: 18,
                          color: Colors.white,
                        ),
                      ),
                    )),
              ],
            );
          }),
    );
  }
}
