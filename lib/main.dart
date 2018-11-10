import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie_griller/Gradients.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movie_griller/TopRatedMoviesCell.dart';
import 'package:movie_griller/movies_list.dart';

void main(){
  runApp(new HomeApp());
}
Future<Map> getJson() async{
  var url = "https://api.themoviedb.org/3/movie/upcoming?api_key=1a43f1f22e3cf15ce2cfd8ca5af13e6f";
  http.Response response = await http.get(url);
  return json.decode(response.body);
}
Future<Map> getTopRatedMovies() async{
  var url = "https://api.themoviedb.org/3/movie/top_rated?api_key=1a43f1f22e3cf15ce2cfd8ca5af13e6f";
  http.Response response = await http.get(url);
  return json.decode(response.body);
}

class RoundedIconButton extends StatelessWidget {
  final IconData iconData;
  final Color color;
  final double size;
  final VoidCallback onPressed;
  RoundedIconButton.large({
    this.iconData,
    this.color,
    this.onPressed
  }):size = 90.0;
  RoundedIconButton.small({
    this.iconData,
    this.color,
    this.onPressed
  }):size = 70.0;
  RoundedIconButton({
    this.iconData,
    this.color,
    this.onPressed,
    this.size
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
        
      decoration: new BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        boxShadow: [
          new BoxShadow(
            color: const Color(0x11000000),
            blurRadius: 10.0
          )
        ]
      ),
      child: new RawMaterialButton(
        shape: new CircleBorder(),
        elevation: 10.0,
        child: new Icon(
          iconData,
          color: color,

        ),
        onPressed: onPressed,
      ),
    );
  }
}
class HomeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new FrontScreen(),
    );
  }
}

class FrontScreen extends StatefulWidget {
  @override
  _FrontScreenState createState() => _FrontScreenState();
}

class _FrontScreenState extends State<FrontScreen> {
  var movies;
  var top_rated_movies;
    void getData() async{
      var data = await getJson();
      setState(() {
              movies = data['results'];
            });
    }
    Widget _buildBottomNavigation(){
      return Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.all(14.0),
        padding: const EdgeInsets.all(16.0),
        height: 55.0,
        
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            new BoxShadow(
              blurRadius: 10.0,
              color: Colors.black38,
              offset: Offset(0.0, 10.0)
            ),
            
          ],
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(10.0)
        ),
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              new RoundedIconButton.large(
                iconData: Icons.movie,
                color: Colors.green,
              ),
              new RoundedIconButton.large(
                iconData: Icons.home,
                color: Colors.pink,
              ),
              new RoundedIconButton(
                iconData: Icons.tv,
                color: Colors.cyan,
              )
            ],
        ),
      );
    }
  @override
  Widget build(BuildContext context) {
    getData();
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Color(0xFFF6F7FB),
      bottomNavigationBar: _buildBottomNavigation(),
      // body: new Stack(
      //   fit: StackFit.expand,
      //   children: <Widget>[
      //     new Positioned(
      //       left: -110.0,
      //       top: -25.0,
      //       child: new Container(
      //         height: 280.0,
      //         width: 380.0,
      //         decoration: BoxDecoration(
      //           gradient: bluePinkGradient,
               
      //           shape: BoxShape.circle,
                
      //         ),
      //       ),
      //     ),
      //     new Positioned(
      //       top: 58.0,
      //       left: 35.0,
      //       child: new Flex(
      //         direction: Axis.vertical,
      //         children: <Widget>[
      //           new Expanded(
              
      //         child: new ListView.builder(
      //         itemCount: 10,
      //         itemBuilder: (context, i){
      //           return new Text("data");
      //         },
      //       ),
      //       )
      //         ],
      //       )
      //     )
      //   ],
      // ),
      body: new ListView(
        children: <Widget>[
          new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              new Container(
                height: 320.0,
                child: new Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    new Positioned(
                      top: -65.0,
                      left: -85.0,
                      child: new Container(
                        height: 320.0,
                        width: 340.0,
                        decoration: BoxDecoration(
                          gradient: bluePinkGradient,
                          shape: BoxShape.circle
                        ),
                      ),
                    ),
                     new Positioned(
                      right: 12.0,
                      top: 6.0,
                      child: new Container(
                        height: 50.0,
                        width: 50.0,
                        decoration: BoxDecoration(
                          gradient: yellowOrangeGradient,
                          shape: BoxShape.circle
                        ),
                      ),
                    ),
                    new Positioned(
                      top: 38.0,
                      left: 85.0,
                      child: new Container(
                        height: 190.0,
                        
                        width: MediaQuery.of(context).size.width-35,
                        child: new Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            new Container(
                              height: 50.0,
                              width: MediaQuery.of(context).size.width-125,
                              child: new Card(

                              elevation: 18.0,
                              shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(10.0)),
                              color: Colors.white,
                              child: new TextFormField(

                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Search for any Movie, TV Show..",
                                  contentPadding: const EdgeInsets.all(13.0) ,
                                  hintStyle: TextStyle(
                                    fontFamily: 'google',
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w800,

                                  ),
                                  suffixIcon: Icon(Icons.search)
                                  
                                ),


                              ),
                            ),
                            ),
                            new SizedBox(
                              height: 13.0,
                            ),
                            new Expanded(

                              child: new ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: movies==null?0:movies.length,
                                // shrinkWrap: true,
                                itemBuilder: (context,i){
                                  return new Container(
                                    padding: const EdgeInsets.only(right: 12.0,bottom: 13.0),
                                    child: new TopRatedMovieCell(movies,i)
                                  );
                                },
                              ),
                            )
                          ],
                        )
                      )
                    ),
                   
                  ],
                ),
              ),
              new Container(
                
                margin: const EdgeInsets.only(left: 20.0),
                height: 280.0,
                width: MediaQuery.of(context).size.width-40,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Text("Top Rated Movies",style: 
                    TextStyle(
                      color: Colors.black,
                      fontFamily: 'google',
                      fontSize: 26.0,
                      fontWeight: FontWeight.w700
                    )),
                    new Container(
                    margin: const EdgeInsets.only(top:3.0,bottom: 14.0),
                    width: (MediaQuery.of(context).size.width-40)/1.5,
                    height: 3.0,
                    decoration: BoxDecoration(
                      gradient: pinkRedGradient,
                      borderRadius: BorderRadius.circular(14.0)
                    ),
                  ),
                    new Expanded(
                      child: new FutureBuilder(
                        future: getTopRatedMovies(),
                        builder: (context,snapshot){
                          if(!snapshot.hasData){
                            return Center(
                              child: new CircularProgressIndicator(
                                backgroundColor: Colors.black,
                              ),
                            );
                          }
                          top_rated_movies = snapshot.data;
                          
                          return new ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: top_rated_movies['results'].length,
                            itemBuilder: (context,i){
                              return Container(
                                padding: const EdgeInsets.only(right: 17.0),
                                child: new TopRatedMovieCellHome(top_rated_movies['results'][i])
                              );
                            },
                          );
                        },
                      ),
                    )
                  ],
                ),
              )
            ],
          )
        ],
      )
    );
  }
}