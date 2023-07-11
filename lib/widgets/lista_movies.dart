import 'package:flutter/material.dart';
import 'package:tmdb_api/tmdb_api.dart';

class ListaMovies extends StatelessWidget {
  final List movies;
  const ListaMovies({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
     
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("treading movies"),
          ElevatedButton(
              onPressed: () {
                print(movies.length);
                print(movies[0]["title"].toString());
              },
              child: Text("info")),
          Image.network(
            'https://image.tmdb.org/t/p/w500' + movies[0]["poster_path"],
            width: 90,
            height: 90,
          ),
          Container(
              height: 270,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: movies.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {},
                    child:
                        // Image.network('https://image.tmdb.org/t/p/w500' + movies[index]["poster_path"], width: 90, height: 90,)
                  Container(
                        width: 140,
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(
                                      'https://image.tmdb.org/t/p/w500' +
                                          movies[index]['poster_path']),
                                ),
                              ),
                              height: 200,
                            ),
                            SizedBox(height: 5),
                             Text( movies[index]["title"]!=null?movies[index]["title"]:"Loading")])
                           


                   
                   ) );
                },
              )),
        ],
      ),
    );
  }
}
