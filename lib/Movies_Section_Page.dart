import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:movie_griller/GenreMovies.dart';
import 'package:movie_griller/Gradients.dart';
import 'package:http/http.dart' as http;
import 'package:movie_griller/TV_Section_Page.dart';
import 'package:movie_griller/TopRatedMoviesCell.dart';
import 'package:movie_griller/Trailers.dart';

const SCALE_FRACTION = 0.7;
const FULL_SCALE = 1.0;
const PAGER_HEIGHT = 250.0;
Future<Map> getNowPlayingMovies() async{
  var url = 'https://api.themoviedb.org/3/movie/popular?api_key=1a43f1f22e3cf15ce2cfd8ca5af13e6f';
  http.Response response = await http.get(url);
  return json.decode(response.body);
}
Future<Map> getUpcomingMovies() async{
  var url = 'https://api.themoviedb.org/3/movie/upcoming?api_key=1a43f1f22e3cf15ce2cfd8ca5af13e6f';
  http.Response response = await http.get(url);
  return json.decode(response.body);
}
Future<Map> getNowPlaying() async{
  var url = 'https://api.themoviedb.org/3/movie/now_playing?api_key=1a43f1f22e3cf15ce2cfd8ca5af13e6f';
  http.Response response = await http.get(url);
  return json.decode(response.body);
}
class MoviesSectionPage extends StatefulWidget{
  @override
  MoviesSectionPageState createState() {
    return new MoviesSectionPageState();
  }
}

class MoviesSectionPageState extends State<MoviesSectionPage> with SingleTickerProviderStateMixin{
Animation<double> animation;
AnimationController _animationController;
var movies;
var upcoming;
var now;
@override
  void initState() {
    
    super.initState();
    _animationController = AnimationController(vsync: this,duration: Duration(milliseconds: 1000));
    animation = Tween<double>(begin: 180.0,end: -7.0).animate(CurvedAnimation(curve: Curves.bounceInOut,parent: _animationController));
    _animationController.forward();
    animation.addStatusListener((status){
      if(status==AnimationStatus.completed){
        _animationController.dispose();
      }
    });
  }
  @override
    void dispose() {
      if(_animationController.status!=AnimationStatus.completed){
        _animationController.dispose();
      }
      super.dispose();
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.home),
        label: Text("Home")
        ,
        onPressed: (){
          Navigator.popUntil(context, ModalRoute.withName(Navigator.defaultRouteName));
        },
       
        backgroundColor: Colors.black87,
      ),
      backgroundColor: Color(0xFFF6F7FB),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        elevation: 12.0,
        
        
        child: new Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(icon: Icon(Icons.movie,color: Colors.blue,),onPressed: (){
              return null;
            },),
            IconButton(icon: Icon(Icons.live_tv,color: Colors.red,),onPressed: (){
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                fullscreenDialog: true,
                builder: (context)=>new TVSectionPage()
              ));
            },)
            
          ],
        ),
      ),
      body: SingleChildScrollView(
        
        physics: BouncingScrollPhysics(),
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(

              children: <Widget>[
                Expanded(
                                  child: SafeArea(
                                                                      child: Text("MOVIES",style: TextStyle(
                    fontSize: 37.0,
                    fontFamily: 'google',
                    fontWeight: FontWeight.w800,
                    letterSpacing: 5.0,
                    color: const Color(0xFFF6356F)
                  ),),
                                  ),
                ),
                // Text('4O4 Shades',style: TextStyle(
                //   fontFamily: 'google',
                //   fontSize: 17.0
                // ),)
              ],
            ),
            new SizedBox(
              height: 18.0,
            ),
            FittedBox(
              
                          child: new Row(
                
                children: <Widget>[
                  GenreSection(gradient: redSexyGradient,image: 'action',title: 'ACTION',color: const Color(0xFFF6356F).withOpacity(0.8),animation: animation,genreID: 28,),
                  SizedBox(width: 28.0,),GenreSection(gradient: violetSexyGradient,image: 'comedy',title: 'COMEDY',color: const Color(0xFF52A7EA).withOpacity(0.8),animation: animation,genreID: 35,)
                ],
              ),
            ),
            SizedBox(
              height: 18.0,
            ),
            FittedBox(
              
                          child: new Row(
                
                children: <Widget>[
                  GenreSection(gradient: greenSexyGradient,image: 'horror',title: 'HORROR',color: const Color(0xFF92D000).withOpacity(0.8),animation: animation,genreID: 27,),
                  SizedBox(width: 28.0,),GenreSection(gradient: orangeSexyGradient,image: 'romance',title: 'ROMANCE',color: const Color(0xFFFF9B30).withOpacity(0.8),animation: animation,genreID: 10749,)
                ],
              ),
            ),
            SizedBox(height: 18.0,),
            Container(
              height: 300.0,
              child: Column(
                children: <Widget>[
                  new Text("TRENDING",style: TextStyle(
                    color: const Color(0xFF5F79F4),
                    fontSize: 32.0,
                    letterSpacing: 4.0,
                    fontFamily: 'google',
                    fontWeight: FontWeight.w600
                  ),),
                   SizedBox(height: 18.0,),
                   new Expanded(
                     child: FutureBuilder(
                       future: getNowPlayingMovies(),
                        builder: (context,snapshot){
                          if(!snapshot.hasData){
                            return Center(child: SpinKitThreeBounce(
                              size: 24.0,
                                    itemBuilder: (_,index){
                                      
                                      return DecoratedBox(
                                        decoration: BoxDecoration(
                                          gradient: blackBlueGradient,
                                          shape:BoxShape.circle,
                                        ),
                                      );
                                    },
                                  ));
                          }
                           else if(snapshot.hasError){
                        return Center(child: Text("Some error occured"),);
                        }
                          movies=snapshot.data['results'];
                          return ListView.builder(
                            physics: BouncingScrollPhysics(),
                            itemCount: movies.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context,index){
                              return Container(
                                padding: const EdgeInsets.only(right: 17.0),
                                child: new TopRatedMovieCellHome(movies[index])
                              );
                            },
                          );
                        },
                     ),
                   )
                ],
              ),
            ),
            Container(
              height: 300.0,
              child: Column(
                children: <Widget>[
                  new Text("UPCOMING",style: TextStyle(
                    color: const Color(0xFFFF9B30),
                    fontSize: 32.0,
                    letterSpacing: 4.0,
                    fontFamily: 'google',
                    fontWeight: FontWeight.w600
                  ),),
                   SizedBox(height: 18.0,),
                   new Expanded(
                     child: FutureBuilder(
                       future: getUpcomingMovies(),
                        builder: (context,snapshot){
                          if(!snapshot.hasData){
                            return Center(child: SpinKitThreeBounce(
                              size: 24.0,
                                    itemBuilder: (_,index){
                                      
                                      return DecoratedBox(
                                        decoration: BoxDecoration(
                                          gradient: blackBlueGradient,
                                          shape:BoxShape.circle,
                                        ),
                                      );
                                    },
                                  ));
                          }
                           else if(snapshot.hasError){
                      return Center(child: Text("Some error occured"),);
                      }
                          upcoming=snapshot.data['results'];
                          return ListView.builder(
                            physics: BouncingScrollPhysics(),
                            itemCount: upcoming?.length??0,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context,index){
                              return Container(
                                padding: const EdgeInsets.only(right: 17.0),
                                child: new TopRatedMovieCellHome(upcoming[index])
                              );
                            },
                          );
                        },
                     ),
                   )
                ],
              ),
            ),
           Container(
              height: 300.0,
              child: Column(
                children: <Widget>[
                  new Text("In Theatres",style: TextStyle(
                    color: const Color(0xFF0099CC),
                    fontSize: 32.0,
                    letterSpacing: 4.0,
                    fontFamily: 'google',
                    fontWeight: FontWeight.w600
                  ),),
                   SizedBox(height: 18.0,),
                   new Expanded(
                     child: FutureBuilder(
                       future: getNowPlaying(),
                        builder: (context,snapshot){
                          if(!snapshot.hasData){
                            return Center(child: SpinKitThreeBounce(
                              size: 24.0,
                                    itemBuilder: (_,index){
                                      
                                      return DecoratedBox(
                                        decoration: BoxDecoration(
                                          gradient: blackBlueGradient,
                                          shape:BoxShape.circle,
                                        ),
                                      );
                                    },
                                  ));
                          }
                           else if(snapshot.hasError){
            return Center(child: Text("Some error occured"),);
          }
                          now=snapshot.data['results'];
                          return ListView.builder(
                            physics: BouncingScrollPhysics(),
                            itemCount: now?.length??0,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context,index){
                              return Container(
                                padding: const EdgeInsets.only(right: 17.0),
                                child: new TopRatedMovieCellHome(now[index])
                              );
                            },
                          );
                        },
                     ),
                   )
                ],
              ),
            ),
            
          ],
        ),
      )
    );
  }
}
class GenreSection extends AnimatedWidget {
  final image;
  final title;
  final gradient;
  final color;
  final genreID;
  
  GenreSection({Key key,this.genreID,Animation<double> animation,this.image,this.title,this.gradient,this.color})
  :super(key:key,listenable:animation);
  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return InkWell(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(
          fullscreenDialog: true,
          builder: (_)=>GenreMovies(genreId: genreID,genretype: 'movie',title: title,image: image,),
        ));
      },
          child: Container(
        height: 120.0,
        width: 187.0,
        child: Stack(
          children: <Widget>[
            new Container(
                  height: 108.0,
                  width: 167.0,
                  decoration: BoxDecoration(
                    
                    borderRadius: BorderRadius.circular(12.0),
                    gradient: gradient,
                    shape: BoxShape.rectangle,
                    boxShadow: [
                      BoxShadow(
                        color: color,
                        blurRadius: 5.0,
                        spreadRadius: 0.4,
                        offset: Offset(0.7,3.0)
                      ),
                      
                    ]
                  ),
                ),
                new Positioned(
                  top: 45.0,
                  left: 25.0,
                  child: Hero(
                    tag:genreID.toString(),
                                      child: Text(title,style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'google',
                        fontSize: 17.0,
                        fontWeight: FontWeight.w700
                      ),),
                  ),
                ),
                new Positioned(
                  bottom: 0.0,
                  right: animation.value,
                  top: 0.0,
                  child: Hero(tag:title,child: Image.asset("assets/images/$image.png",)),
                )
          ],
        ),
      ),
    );
  }
}

