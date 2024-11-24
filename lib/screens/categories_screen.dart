import 'package:flutter/material.dart';
import 'package:movie/data/popular.dart';
import 'package:movie/helper/constants.dart';
import 'package:movie/helper/routes.dart';
import 'package:movie/screens/inner_screens/actor_movies.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Popular Actors',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: SizedBox(
                width: MediaQuery.sizeOf(context).width,
                height: MediaQuery.of(context).size.height,
                child: FutureBuilder(
                  future: PopularPeople.fetchPopularActors(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (!snapshot.hasData) {
                      return const Center(child: SizedBox.shrink());
                    }
                    if (snapshot.hasData) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: SizedBox(
                          height: MediaQuery.sizeOf(context).height,
                          width: MediaQuery.of(context).size.width,
                          child: GridView.builder(
                              itemCount: snapshot.data!.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      childAspectRatio: 3 / 4,
                                      crossAxisSpacing: 3,
                                      crossAxisCount: 2),
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, StaticRoutes.actorListMovies,
                                        arguments:
                                            snapshot.data![index].knownFor);
                                  },
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(10),
                                        height: 200,
                                        width: 170,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          child: Image.network(
                                            "${Constants.imagePath}${snapshot.data![index].profilePath}",
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
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: Text(snapshot.data![index].name!,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            )),
                                      )
                                    ],
                                  ),
                                );
                              }),
                        ),
                      );
                    }
                    return const Center(
                      child: Text('No Data'),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
