
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movie_griller/SearchResults.dart';
Future<Map> getGenreMovies(var id) async{
  var url = 'https://api.themoviedb.org/3/discover/movie?api_key=1a43f1f22e3cf15ce2cfd8ca5af13e6f&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_genres=$id';
  http.Response response = await http.get(url);
  return json.decode(response.body);
}
Future<Map> getGenreTV(var id) async{
  var url = 'https://api.themoviedb.org/3/discover/tv?api_key=1a43f1f22e3cf15ce2cfd8ca5af13e6f&language=en-US&sort_by=popularity.desc&page=1&with_genres=$id&include_null_first_air_dates=false';
  http.Response response = await http.get(url);
  return json.decode(response.body);
}
class GenreMovies extends StatelessWidget {
  final genreId;
  var  _genreResults;
  final genretype;
  GenreMovies({this.genreId,this.genretype});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            FutureBuilder(
              future: genretype=='movie'?getGenreMovies(genreId):getGenreTV(genreId),
              builder: (context,snapshot){
                if(!snapshot.hasData){
                  return Center(child: CircularProgressIndicator(backgroundColor: Colors.black,),);
                }
                _genreResults = snapshot.data['results'];
                return Container(
                  height:MediaQuery.of(context).size.height,
                  width: double.infinity,
                  
                  child: OrientationBuilder(
                    builder: (context,orientation){
                      return GridView.builder(
                        padding: EdgeInsets.only(top: 5.0,right: 5.0,bottom: 15.0),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: orientation==Orientation.landscape?5:3,
                          childAspectRatio: 0.50
                        ),
                        itemCount: _genreResults==null?0:_genreResults.length,
                        itemBuilder: (context,index){
                         var mediaType = genretype;
                         var profile_path;
                        var title;
                        var id = _genreResults[index]['id'];
                        if(mediaType=='tv'){
                          profile_path = _genreResults[index]['poster_path'];
              title = _genreResults[index]['name'];
            }
            else if(mediaType=='movie'){
              profile_path = _genreResults[index]['poster_path'];
              title = _genreResults[index]['title'];
            }
                          return SearchResults(id: id,poster_image: profile_path,title: title,type: mediaType,);
                        },
                      );
                    },
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}