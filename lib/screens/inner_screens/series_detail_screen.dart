import 'package:flutter/material.dart';
import 'package:movie/Models/airing_series.dart';
import 'package:movie/helper/assets.dart';
import 'package:movie/helper/constants.dart';

import '../../widgets/custom_button.dart';

class SeriesDetailsScreen extends StatefulWidget {
  const SeriesDetailsScreen({super.key});

  @override
  State<SeriesDetailsScreen> createState() => _SeriesDetailsScreenState();
}

class _SeriesDetailsScreenState extends State<SeriesDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final series = ModalRoute.of(context)!.settings.arguments as AiringSeries;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Stack(
            children: [
              Flexible(
                child: Image.network(
                  "${Constants.imagePath}${series.posterPath!}",
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
                    onTap: () {
                      Navigator.pop(context);
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
                  height: 150,
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0, right: 10),
                        child: Text(series.originalName.toString(),
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
                              padding:
                                  const EdgeInsets.only(left: 10.0, right: 10),
                              child: Text(
                                series.voteAverage!.toStringAsFixed(1),
                                style: Theme.of(context).textTheme.titleSmall!,
                              ),
                            ),
                            Text(
                              series.adult == true ? '18+' : '+12',
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10),
            child:
                Text('Release Date: ${getDateFormated(series.firstAirDate)}'),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              'Overview: ${series.overview}',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(fontSize: 13, color: Colors.grey),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.only(bottom: 8.0, left: 8, right: 8),
            child: CustomButton(
              text: 'Watch Triller',
              color: Colors.grey,
              image: Assets.video,
              imageColor: Colors.white,
              isLoading: false,
              onPressed: () {},
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 8.0, left: 8, right: 8),
            child: CustomButton(
              text: 'Add to Watch List',
              color: Colors.purple,
              image: Assets.bookMark,
              imageColor: Colors.white,
              isLoading: false,
              onPressed: () {
                // Add to watch list
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
