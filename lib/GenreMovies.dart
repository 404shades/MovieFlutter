
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:movie_griller/Gradients.dart';
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
  final title;
  final image;
  GenreMovies({this.genreId,this.genretype,this.title,this.image});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(0.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new SizedBox(height: 10.0,),
            SafeArea(
                          child: Row(
                
                children: <Widget>[

                  Padding(padding: EdgeInsets.only(left: 10.0)),
                  IconButton(icon: Icon(FontAwesomeIcons.arrowLeft),onPressed: ()=>Navigator.pop(context),),
                  Expanded(
                                    child: Hero(
                                      tag: genreId.toString(),
                                                                        child: Text(title,style: TextStyle(
                        fontFamily: 'google',
                        fontSize: 37.0,
                        color: Colors.blueGrey.shade800,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.4

                      ),),
                                    ),
                  ),
                    genretype=='movie'? Container(height: 50.0,width:50.0,child: Hero(tag:title,child: Image.asset("assets/images/$image.png",))):Container(),
                    Padding(padding: const EdgeInsets.only(right: 10.0),)
                ],
              ),
            ),
            FutureBuilder(
              future: genretype=='movie'?getGenreMovies(genreId):getGenreTV(genreId),
              builder: (context,snapshot){
                if(!snapshot.hasData){
                  return Container(height: MediaQuery.of(context).size.height,child: Center(child: SpinKitCircle(
                    size: 60.0,
                    itemBuilder: (context,index){
                      return DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: blackBlueGradient,
                          shape: BoxShape.circle
                        ),
                      );
                    },
                  )));
                }
                _genreResults = snapshot.data['results'];
                return Container(
                  height: MediaQuery.of(context).size.height,
                  
                  
                  child: OrientationBuilder(
                    builder: (context,orientation){
                      return GridView.builder(
                        physics: BouncingScrollPhysics(),
                        padding: EdgeInsets.only(top: 2.0,right: 5.0,bottom: 80.0),
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