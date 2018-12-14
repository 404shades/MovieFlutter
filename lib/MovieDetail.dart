
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:http/http.dart' as http;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/services.dart';
import 'package:movie_griller/Gradients.dart';
import 'package:movie_griller/Loader.dart';
import 'package:movie_griller/cast_cell.dart';
import 'package:movie_griller/similar_movie_cell.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

Future<Map> getMovieDetail(var id) async{
  var url = "https://api.themoviedb.org/3/movie/$id?api_key=1a43f1f22e3cf15ce2cfd8ca5af13e6f&append_to_response=credits,similar";
  http.Response response = await http.get(url);
  
      return json.decode(response.body);
  
  
  
}

class MovieDetail extends StatelessWidget {
  final movie_id;
  var movie;
  var rand= Random();
  final image_url = 'https://image.tmdb.org/t/p/w500';
  MovieDetail(this.movie_id);
  String getGenres(var genre){
    String answer = "";
    print(genre.length.toString() + "kikkakak");
    int le = min(genre.length,2);
    for(int i=0;i<le;i++){
        answer = answer + genre[i]['name']+ "/";
    }
    answer = answer.substring(0,answer.length-1);
    return answer;
  }
  
  @override
  Widget build(BuildContext context) {
    // SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      body: new FutureBuilder(
        future: getMovieDetail(movie_id),
        builder: (context,snapshot){
          if(!snapshot.hasData){
            return Center(
              child: SpinKitPumpingHeart(
                color: Colors.black,
                size: 86.0,
              ),
            );
          }
          movie = snapshot.data;
          return new Stack(
        fit: StackFit.expand,
        children: <Widget>[
          new Image.network(image_url + movie['poster_path'],fit: BoxFit.cover,),
          new BackdropFilter(
            filter: new ui.ImageFilter.blur(sigmaX: 5.0,sigmaY: 5.0),
            child: Container(
              color: Colors.black.withOpacity(0.3),

            ),
          ),
          new SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.all(20.0),
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Container(
                    alignment: Alignment.center,
                    child: new Stack(
                      fit:StackFit.loose,
                      children: <Widget>[
                        new Container(
                      width: 400.0,
                      height: 400.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14.0),
                        image: DecorationImage(
                          image: NetworkImage(
                            image_url + movie['poster_path'],
                            
                          ),
                          fit: BoxFit.cover,
                        ),
                        boxShadow: [
                          new BoxShadow(
                            color: Colors.black,
                            blurRadius: 20.0,
                            offset: new Offset(0.0, 14.0)
                          )
                        ]
                      ),
                    ),
                    new Positioned(
                      left: 0.0,
                      right: 0.0,
                      bottom: 0.0,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.8)
                            ]
                          ),
                          borderRadius: BorderRadius.circular(14.0)
                        ),
                        padding: const EdgeInsets.only(left:20.0,bottom: 8.0,right: 20.0),
                        child: new Row(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            new Expanded(
                              child: new Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  new Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                  new Icon(Icons.star,color: Colors.white,),
                                  new Icon(Icons.star,color: Colors.white,),
                                  new Icon(Icons.star,color: Colors.white,),
                                  new Icon(Icons.star_half,color: Colors.white,),
                                  new Icon(Icons.star_border,color: Colors.white,),
                                    ],
                                  ),
                                  
                                  new Row(children: <Widget>[
                                  
                                  new Icon(FontAwesomeIcons.imdb,color: Colors.yellow,),
                                  new Padding(padding: const EdgeInsets.only(right: 4.0),),
                                  new Text("${movie['vote_average'].toString()}/10",style: TextStyle(color:Colors.white,
                                  fontFamily: 'google',
                                  fontWeight: FontWeight.bold
                                  ),)
                                  ],)
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                new Text(movie['release_date'],
                            style: TextStyle(color: Colors.white,
                            fontFamily: 'google',
                            fontWeight: FontWeight.bold
                            ),
                            ),
                            new Text(getGenres(movie['genres']),style: TextStyle(color: Colors.white,
                            fontFamily: 'google',
                            fontWeight: FontWeight.bold
                            ),)
                              ],
                            )
                          ],
                        ),
                      ),
                  
                    ),
                    
                      ],
                    )
                  ),
                  new SizedBox(
                    height: 18.0,
                  ),
                  new Text(movie['title'],style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'google',
                    fontWeight: FontWeight.w800,
                    fontSize: 26.0
                  ),),
                  new Container(
                    margin: const EdgeInsets.only(top:3.0,bottom: 14.0),
                    width: (MediaQuery.of(context).size.width-40)/2,
                    height: 3.0,
                    decoration: BoxDecoration(
                      gradient: pinkRedGradient,
                      borderRadius: BorderRadius.circular(14.0)
                    ),
                  ),
                  new Text(movie['overview'],style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'google',
                    fontSize: 16.0
                  ),
                  textAlign: TextAlign.justify,),
                  new SizedBox(height: 18.0,),
                  new Text("Cast",style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'google',
                    fontWeight: FontWeight.w800,
                    fontSize: 26.0
                  ),),
                  new Container(
                    margin: const EdgeInsets.only(top:3.0,bottom: 14.0),
                    width: (MediaQuery.of(context).size.width-40)/2,
                    height: 3.0,
                    decoration: BoxDecoration(
                      gradient: yellowOrangeGradient,
                      borderRadius: BorderRadius.circular(14.0)
                    ),
                  ),
                  new Container(
                    height: 170.0,
                    width: MediaQuery.of(context).size.width-40,
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new Expanded(
                          child: new ListView.builder(
                            itemCount: movie['credits']['cast'].length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context,i){
                              return Container(
                                padding: const EdgeInsets.only(right: 12.0),
                                child: new CastCell(movie['credits']['cast'][i]),
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  new SizedBox(height: 18.0,),
                  new Text("Similar Movies",style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'google',
                    fontWeight: FontWeight.w800,
                    fontSize: 26.0
                  ),),
                  new Container(
                    margin: const EdgeInsets.only(top:3.0,bottom: 14.0),
                    width: (MediaQuery.of(context).size.width-40)/2,
                    height: 3.0,
                    decoration: BoxDecoration(
                      gradient: blueGreenGradient,
                      borderRadius: BorderRadius.circular(14.0)
                    ),
                  ),
                  new Container(
                    height: 220.0,
                    width: MediaQuery.of(context).size.width-40,
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new Expanded(
                          child: new ListView.builder(
                            itemCount: movie['similar']['results'].length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context,i){
                              return Container(
                                padding: const EdgeInsets.only(right: 12.0),
                                child: new SimilarCell(movie['similar']['results'][i]),
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      );
        },
      )
    );
  }
}