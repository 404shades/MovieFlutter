import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movie_griller/Gradients.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movie_griller/Movies_Section_Page.dart';
import 'package:movie_griller/SearchResults.dart';
import 'package:movie_griller/TV_Section_Page.dart';

import 'package:movie_griller/TopRatedMoviesCell.dart';
import 'package:movie_griller/TopRatedTVShowCell.dart';
import 'package:movie_griller/Trailers.dart';
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
Future<Map> getTopRatedTVShows() async{
  var url = "https://api.themoviedb.org/3/tv/popular?api_key=1a43f1f22e3cf15ce2cfd8ca5af13e6f";
  http.Response response = await http.get(url);
  return json.decode(response.body);
}
Future<Map> getNowPlayingMovies() async{
  var url = 'https://api.themoviedb.org/3/movie/now_playing?api_key=1a43f1f22e3cf15ce2cfd8ca5af13e6f';
  http.Response response = await http.get(url);
  return json.decode(response.body);
}

Future<Map> fetchMovies(int pageNumber,String query) async{
    // TODO: implement fetchMovies
    http.Response response = await http.get(
      'https://api.themoviedb.org/3/search/multi?api_key=1a43f1f22e3cf15ce2cfd8ca5af13e6f&language=en-US&query=$query&page=$pageNumber'
    );
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
  }):size = 50.0;
  RoundedIconButton.small({
    this.iconData,
    this.color,
    this.onPressed
  }):size = 30.0;
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
      theme: new ThemeData(
        primaryColor: Colors.black,
        accentColor: Colors.black,
        bottomAppBarColor: Color(0xFFF6F7FB)
      ),
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
  var top_rated_tv_shows;
  var now_playing;
  PageController _controller = PageController();
  TextEditingController textEditingController = TextEditingController();
    // Widget _buildBottomNavigation(){
    //   return Container(
    //     alignment: Alignment.center,
    //     margin: const EdgeInsets.all(14.0),
    //     padding: const EdgeInsets.all(16.0),
    //     height: 55.0,
        
    //     decoration: BoxDecoration(
    //       color: Colors.white,
    //       boxShadow: [
    //         new BoxShadow(
    //           blurRadius: 10.0,
    //           color: Colors.black38,
    //           offset: Offset(0.0, 10.0)
    //         ),
            
    //       ],
    //       shape: BoxShape.rectangle,
    //       borderRadius: BorderRadius.circular(10.0)
    //     ),
    //     child: new Row(
    //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //         children: <Widget>[
    //           new RoundedIconButton.large(
    //             iconData: Icons.movie,
    //             color: Colors.green,
    //           ),
    //           new RoundedIconButton.large(
    //             iconData: Icons.home,
    //             color: Colors.pink,
    //           ),
    //           new RoundedIconButton(
    //             iconData: Icons.tv,
    //             color: Colors.cyan,
    //           )
    //         ],
    //     ),
    //   );
    // }
  @override
  Widget build(BuildContext context) {
    
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.home),
        label: Text("Home")
        ,
        onPressed: (){},
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
              Navigator.of(context).push(MaterialPageRoute(
                fullscreenDialog: true,
                builder: (context)=>new MoviesSectionPage()
              ));
            },),
            IconButton(icon: Icon(Icons.tv,color: Colors.red,),onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(
                fullscreenDialog: true,
                builder: (context)=>new TVSectionPage()
              ));
            },)
            
          ],
        ),
      ),
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
                              alignment: Alignment.center,
                              height:60.0,
                              width: MediaQuery.of(context).size.width-95,
                              child: GestureDetector(
                                onTap:()=>showSearch(context: context,delegate: MovieSearch()),
                                child: new Card(

                              elevation: 18.0,
                              shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(10.0)),
                              color: Colors.white,
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    new Padding(padding: const EdgeInsets.only(left: 14.0)),
                                    Expanded(
                                                                          child: new Text("Search for any Movie or TV Show..",style: TextStyle(
                                      fontFamily: 'google',
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.grey
                                  ),
                                      ),
                                    ),
                                    new Icon(Icons.search),
                                    new Padding(padding: const EdgeInsets.only(right: 10.0),)
                                  ],
                                ),
                              )
                            ),
                              )
                            ),
                            new SizedBox(
                              height: 13.0,
                            ),
                            new FutureBuilder(
                              future: getJson(),
                              builder: (context,snapshot){
                                if(!snapshot.hasData){
                                  return Center(child: CircularProgressIndicator(),);
                                }
                                movies = snapshot.data;
                                return new Expanded(

                              child: new ListView.builder(
                                physics: BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemCount: movies['results'].length,
                                // shrinkWrap: true,
                                itemBuilder: (context,i){
                                  return new Container(
                                    padding: const EdgeInsets.only(right: 12.0,bottom: 13.0),
                                    child: new TopRatedMovieCell(movies['results'],i)
                                  );
                                },
                              ),
                            );
                              },
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
                height: 310.0,
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
                            physics: BouncingScrollPhysics(),
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
              ),

          new SizedBox(height: 12.0,),
          new Container(
              margin: const EdgeInsets.only(left: 20.0,right: 20.0),
              height: 320.0,
              width: MediaQuery.of(context).size.width-40,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: new Text("Now Playing Movies",style: 
                    TextStyle(
                      color: Colors.black,
                      fontFamily: 'google',
                      fontSize: 26.0,
                      fontWeight: FontWeight.w700
                    )),
                      ),
                      new IconButton(icon:Icon(FontAwesomeIcons.chevronCircleLeft,),onPressed: ()=>_controller.previousPage(curve: Curves.bounceOut,duration: Duration(milliseconds: 1200)),)
                      ,new IconButton(icon:Icon(FontAwesomeIcons.chevronCircleRight,),onPressed: ()=>_controller.nextPage(curve: Curves.bounceOut,duration: Duration(milliseconds: 1200)),)
                    ],
                  ),
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
                      future: getNowPlayingMovies(),
                      builder: (context,snapshot){
                        if(!snapshot.hasData){
                          return new Center(child: CircularProgressIndicator(),);
                        }
                        now_playing = snapshot.data['results'];
                        return new PageView.builder(
                          controller: _controller,
                          physics: BouncingScrollPhysics(),
                      itemCount: now_playing.length,
                      itemBuilder: (context,index){
                        return NowPlayingCell(now_playing[index]);
                      },
                    );
                      },
                    )
                  )
                ],
              ),
          ),
          new SizedBox(height: 24.0,),
            new Container(
                
                margin: const EdgeInsets.only(left: 20.0),
                height: 310.0,
                width: MediaQuery.of(context).size.width-40,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Text("Popular TV Shows",style: 
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
                        future: getTopRatedTVShows(),
                        builder: (context,snapshot){
                          if(!snapshot.hasData){
                            return Center(
                              child: new CircularProgressIndicator(
                                backgroundColor: Colors.black,
                              ),
                            );
                          }
                          top_rated_tv_shows = snapshot.data;
                          
                          return new ListView.builder(
                            physics: BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount: top_rated_tv_shows['results'].length,
                            itemBuilder: (context,i){
                              return Container(
                                padding: const EdgeInsets.only(right: 17.0),
                                child: new TopRatedTvShowCell(top_rated_tv_shows['results'][i])
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


class MovieSearch extends SearchDelegate<String>{

  
  
  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [IconButton(icon: Icon(Icons.clear),onPressed: (){
      query="";
    })];
    

  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation
      ),
      onPressed: (){
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    var searchResults;
    return new FutureBuilder(
      future: fetchMovies(1, query),
      builder: (context,snapshot){
        if(!snapshot.hasData){
          return Center(
            child: CircularProgressIndicator(),
          );

        }
        searchResults = snapshot.data['results'];
        return Container(
          child: OrientationBuilder(
            builder: (context,orientation){
              return GridView.builder(
          padding: EdgeInsets.only(top: 5.0,right: 5.0,bottom: 15.0),
          
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount:orientation==Orientation.landscape?5:3,
            childAspectRatio: 0.50
          ),
          itemCount: query.isEmpty?0:searchResults.length,
          itemBuilder: (context,index){
            print('length YEE ${searchResults.length}');
            var mediaType = searchResults[index]['media_type'];
            var profile_path;
            var title;
            if(mediaType=='tv'){
              profile_path = searchResults[index]['poster_path'];
              title = searchResults[index]['name'];
            }
            else if(mediaType=='movie'){
              profile_path = searchResults[index]['poster_path'];
              title = searchResults[index]['title'];
            }
            else{
              profile_path = searchResults[index]['profile_path'];
              title = searchResults[index]['name'];
            }
            var backdrop_path = searchResults[index]['backdrop_path'];
            var id = searchResults[index]['id'];
            print(searchResults.length);
            return SearchResults(poster_image: profile_path,title: title,type: mediaType,id: id,);
          },
        );
            },
          )
        );
      },
    );
  }
  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions

    return Center(child: Icon(Icons.sentiment_neutral,size: 24.0,),);

}
}