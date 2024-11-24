import 'dart:async';

import 'package:flutter/material.dart';
import 'package:movie/Models/airing_series.dart';
import 'package:movie/helper/assets.dart';
import 'package:movie/helper/constants.dart';
import 'package:skeletonizer/skeletonizer.dart';

class AiringSeriesWidget extends StatefulWidget {
  const AiringSeriesWidget({
    super.key,
    this.series,
  });
  final List<AiringSeries>? series;

  @override
  State<AiringSeriesWidget> createState() => _AiringSeriesWidgetState();
}

class _AiringSeriesWidgetState extends State<AiringSeriesWidget> {
  bool skeletonizer = true;
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 4), () {
      setState(() {
        skeletonizer = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: double.infinity,
      child: Skeletonizer(
        enabled: skeletonizer,
        child: ListView.builder(
            itemCount: widget.series!.length,
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/seriesDetails',
                      arguments: widget.series![index]);
                },
                child: Stack(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      height: 200,
                      width: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          "${Constants.imagePath}${widget.series![index].posterPath}",
                          fit: BoxFit.cover,
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
                            padding: const EdgeInsets.all(3),
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
                ),
              );
            }),
      ),
    );
  }
}
