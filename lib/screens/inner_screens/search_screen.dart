import 'package:flutter/material.dart';
import 'package:movie/data/SearchMovies.dart';
import 'package:movie/helper/constants.dart';
import 'package:movie/helper/routes.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late TextEditingController _searchController;
  String movieName = "";
  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Search',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade200.withOpacity(0.4),
                ),
                width: MediaQuery.sizeOf(context).width - 20,
                child: TextField(
                  controller: _searchController,
                  onSubmitted: (value) {
                    setState(() {
                      movieName = value;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: "Search your movie here",
                    hintStyle:
                        TextStyle(fontSize: 16, color: Colors.grey.shade100),
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        setState(() {
                          movieName = "";
                          _searchController.clear();
                        });
                      },
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: MediaQuery.sizeOf(context).width,
              height: MediaQuery.of(context).size.height,
              child: FutureBuilder(
                future: SearchMovies.fetchSpecificMovies(movieName),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
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
                                    childAspectRatio: 3 / 4, crossAxisCount: 2),
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, StaticRoutes.movieDetails,
                                      arguments: snapshot.data![index]);
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(10),
                                      height: 200,
                                      width: 170,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: Image.network(
                                          "${Constants.imagePath}${snapshot.data![index].posterPath}",
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
                                    Text(
                                      snapshot.data![index].title!,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                    )
                                  ],
                                ),
                              );
                            }),
                      ),
                    );
                  }
                  return Center(
                    child: Text('No Data'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
