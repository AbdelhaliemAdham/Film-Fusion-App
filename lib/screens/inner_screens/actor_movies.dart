// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:movie/Models/actor.dart';

import 'package:movie/helper/constants.dart';

// ignore: must_be_immutable
class ActorListMovies extends StatefulWidget {
  @override
  State<ActorListMovies> createState() => _ActorListMoviesState();
}

class _ActorListMoviesState extends State<ActorListMovies> {
  @override
  Widget build(BuildContext context) {
    List<KnownFor> knownForList =
        ModalRoute.of(context)!.settings.arguments as List<KnownFor>;
    return Scaffold(
        body: SingleChildScrollView(
            child: SizedBox(
      height: MediaQuery.sizeOf(context).height,
      width: MediaQuery.of(context).size.width,
      child: GridView.builder(
          itemCount: knownForList.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/movieDetails',
                    arguments: knownForList[index]);
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        "${Constants.imagePath}${knownForList[index].posterPath}",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Text(
                    knownForList[index].title!,
                    style: Theme.of(context).textTheme.titleSmall,
                  )
                ],
              ),
            );
          }),
    )));
  }
}
