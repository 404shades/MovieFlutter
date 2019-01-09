
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
  if(response.statusCode==200){
    return json.decode(response.body);
  }
  else{
   return Future.error("Failed to establish connection");
  }
}
class GenreMovies extends StatefulWidget {
  final genreId;
  final genretype;
  final title;
  final image;
  GenreMovies({this.genreId,this.genretype,this.title,this.image});

  @override
  GenreMoviesState createState() {
    return new GenreMoviesState();
  }
}

class GenreMoviesState extends State<GenreMovies> {
  var  _genreResults;
  Future<Map> _getMovie;
  Future<Map> _getTV;

  @override
    void initState() {
      
      super.initState();
      if(widget.genretype=='movie'){
      _getMovie = getGenreMovies(widget.genreId);
      }
      else{
      _getTV = getGenreTV(widget.genreId);
      }
    }

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
                                    child: Text(widget.title,style: TextStyle(
                        fontFamily: 'google',
                        fontSize: 37.0,
                        color: Colors.blueGrey.shade800,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.4

                      ),),
                  ),
                    widget.genretype=='movie'? Container(height: 50.0,width:50.0,child: Hero(tag:widget.title,child: Image.asset("assets/images/${widget.image}.png",))):Container(),
                    Padding(padding: const EdgeInsets.only(right: 10.0),)
                ],
              ),
            ),
            FutureBuilder(
              future: widget.genretype=='movie'?_getMovie:_getTV,
              builder: (context,snapshot){
               switch (snapshot.connectionState) {
            case ConnectionState.none:
              return new Center(child: Text("Connection Not Found"),);
            case ConnectionState.waiting:
              return Container(
                height: MediaQuery.of(context).size.height,child: Center(
                  child: SpinKitCircle(
                    size: 60.0,
                    itemBuilder: (context,index){
                      return DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: blackBlueGradient,
                          shape: BoxShape.circle
                        ),
                      );
                    },
                  ),
                ),
              );

            default:
              if(snapshot.hasError){
                return new Center(child: Text("Error : ${snapshot.error}"),);

              }
                _genreResults = snapshot.data['results'];
                return Container(
                  height: MediaQuery.of(context).size.height,
                  
                  
                  child: OrientationBuilder(
                    builder: (context,orientation){
                      return GridView.builder(
                        physics: BouncingScrollPhysics(),
                        padding: EdgeInsets.only(top: 2.0,right: 5.0,bottom: 150.0),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: orientation==Orientation.landscape?5:3,
                          childAspectRatio: 0.50
                        ),
                        itemCount: _genreResults==null?0:_genreResults.length,
                        itemBuilder: (context,index){
                         var mediaType = widget.genretype;
                         var _profilePath;
                        var title;
                        var id = _genreResults[index]['id'];
                        if(mediaType=='tv'){
                          _profilePath = _genreResults[index]['poster_path'];
              title = _genreResults[index]['name'];
            }
            else if(mediaType=='movie'){
              _profilePath = _genreResults[index]['poster_path'];
              title = _genreResults[index]['title'];
            }
                          return SearchResults(id: id,posterImage: _profilePath,title: title,type: mediaType,);
                        },
                      );
                    },
                  ),
                );
              }
              }
            )
          ],
        ),
      ),
    );
  }
}