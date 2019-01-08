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
import 'package:flutter_spinkit/flutter_spinkit.dart';
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
  var url = 'https://api.themoviedb.org/3/trending/all/day?api_key=1a43f1f22e3cf15ce2cfd8ca5af13e6f';
  http.Response response = await http.get(url);
  return json.decode(response.body);
}

Future<Map> fetchMovies(int pageNumber,String query) async{
    
    http.Response response = await http.get(
      'https://api.themoviedb.org/3/search/multi?api_key=1a43f1f22e3cf15ce2cfd8ca5af13e6f&language=en-US&query=$query&page=$pageNumber'
    );
    return json.decode(response.body);

  }
  Future<Map> getTVAiringToday() async{
  var url = "https://api.themoviedb.org/3/tv/airing_today?api_key=1a43f1f22e3cf15ce2cfd8ca5af13e6f";
  http.Response response = await http.get(url);
  return json.decode(response.body);
}

class HomeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'The Movienator',
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
  @override
  Widget build(BuildContext context) {
    
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.black,
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarDividerColor: Colors.transparent.withOpacity(0.7)
    ));
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.home),
        label: Text("Home")
        ,
        onPressed: ()=>null,
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
            IconButton(icon: Icon(Icons.live_tv,color: Colors.red,),onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(
                fullscreenDialog: true,
                builder: (context)=>new TVSectionPage()
              ));
            },)
            
          ],
        ),
      ),
     
      body: new ListView(
        padding: const EdgeInsets.all(0.0),
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
                              child: InkWell(
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
                            new FutureBuilder<Map>(
                              future: getJson(),
                              builder: (context,snapshot){
                                if(!snapshot.hasData){
                                  return Center(child: SpinKitThreeBounce(
                                    size: 24.0,
                                    itemBuilder: (_,index){
                                      
                                      return DecoratedBox(
                                        decoration: BoxDecoration(
                                          gradient: blackBlueGradient,
                                          shape:BoxShape.circle
                                        ),
                                      );
                                    },
                                  ));
                                }
                                 else if(snapshot.hasError){
            return Center(child: Text("Some error occured"),);
          }
                                movies = snapshot.data;
                                return new Expanded(

                              child: new ListView.builder(
                                physics: BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemCount: movies['results']?.length??0,
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
                              child: SpinKitThreeBounce(
                              size: 24.0,
                                    itemBuilder: (_,index){
                                      
                                      return DecoratedBox(
                                        decoration: BoxDecoration(
                                          gradient: blackBlueGradient,
                                          shape:BoxShape.circle,
                                        ),
                                      );
                                    },
                                  )
                            );
                          }
                           else if(snapshot.hasError){
            return Center(child: Text("Some error occured"),);
          }
                          top_rated_movies = snapshot.data;
                          
                          return new ListView.builder(
                            scrollDirection: Axis.horizontal,
                            physics: BouncingScrollPhysics(),
                            itemCount: top_rated_movies['results']?.length,
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
                        child: new Text("Trending Today",style: 
                    TextStyle(
                      color: Colors.black,
                      fontFamily: 'google',
                      fontSize: 26.0,
                      fontWeight: FontWeight.w700
                    )),
                      ),
                      new IconButton(icon:Icon(FontAwesomeIcons.chevronCircleLeft,),onPressed: ()=>_controller.previousPage(curve: Curves.easeIn,duration: Duration(milliseconds: 1200)),)
                      ,new IconButton(icon:Icon(FontAwesomeIcons.chevronCircleRight,),onPressed: ()=>_controller.nextPage(curve: Curves.easeOut,duration: Duration(milliseconds: 1200)),)
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
                          return new Center(child: SpinKitThreeBounce(
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
                        now_playing = snapshot.data['results'];
                        return new PageView.builder(
                          controller: _controller,
                          physics: BouncingScrollPhysics(),
                      itemCount: now_playing?.length??0,
                      itemBuilder: (context,index){
                        var profilePath;
                        var backdropPath;
                        var title;
                        var ratings;
                        var releaseDate;
                        var id;
                        if(now_playing[index].containsKey("title")){
                            profilePath = now_playing[index]['poster_path'];
                            backdropPath = now_playing[index]['backdrop_path'];
                            title = now_playing[index]['title'];
                            ratings = now_playing[index]['vote_average'];
                            releaseDate = now_playing[index]['release_date'];
                            id = now_playing[index]['id'];
                            return NowPlayingCell(poster_path: profilePath,backdrop_path: backdropPath,name: title
                            ,id: id,ratings: ratings,release_date: releaseDate,media_type: 'movie',
                            );
                        }
                        else if(now_playing[index].containsKey("name")){
                          if(now_playing[index].containsKey("profile_path")){
                            profilePath = now_playing[index]['profile_path'];
                            backdropPath= "";
                            title = now_playing[index]['name'];
                            ratings = now_playing[index]['popularity'];
                            releaseDate = now_playing[index]['date_of_birth'];
                            id = now_playing[index]['id'];
                            return NowPlayingCell(poster_path: profilePath,backdrop_path: backdropPath,
                            name: title,ratings: ratings,release_date: releaseDate,id: id,media_type: 'person',
                            );
                          }
                          else{
                          profilePath = now_playing[index]['poster_path'];
                          backdropPath = now_playing[index]['backdrop_path'];
                          title = now_playing[index]['name'];
                          ratings = now_playing[index]['vote_average'];
                          releaseDate = now_playing[index]['first_air_date'];
                          id = now_playing[index]['id'];
                          return NowPlayingCell(poster_path: profilePath,backdrop_path: backdropPath,
                          name: title,id: id,ratings: ratings,release_date: releaseDate,media_type: 'tv',
                          );
                          }
                        }
                        return null;
                        
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
                height: 290.0,
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
                            child: SpinKitThreeBounce(
                              size: 24.0,
                                    itemBuilder: (_,index){
                                      
                                      return DecoratedBox(
                                        decoration: BoxDecoration(
                                          gradient: blackBlueGradient,
                                          shape:BoxShape.circle,
                                        ),
                                      );
                                    },
                                  )
                            );
                          }
                           else if(snapshot.hasError){
            return Center(child: Text("Some error occured"),);
          }
                          top_rated_tv_shows = snapshot.data;
                          
                          return new ListView.builder(
                            physics: BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount: top_rated_tv_shows['results']?.length??0,
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
,
              
              new Container(
                
                margin: const EdgeInsets.only(left: 20.0),
                height: 310.0,
                width: MediaQuery.of(context).size.width-40,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Text("TV Airing Today",style: 
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
                        future: getTVAiringToday(),
                        builder: (context,snapshot){
                          if(!snapshot.hasData){
                            return Center(
                            child: SpinKitThreeBounce(
                              size: 24.0,
                                    itemBuilder: (_,index){
                                      
                                      return DecoratedBox(
                                        decoration: BoxDecoration(
                                          gradient: blackBlueGradient,
                                          shape:BoxShape.circle,
                                        ),
                                      );
                                    },
                                  )
                            );
                          }
                           else if(snapshot.hasError){
            return Center(child: Text("Some error occured"),);
          }
                          top_rated_tv_shows = snapshot.data;
                          
                          return new ListView.builder(
                            physics: BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount: top_rated_tv_shows['results']?.length??0,
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
              ),
              SizedBox(height: 24.0,)
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
   
    return [IconButton(icon: Icon(Icons.clear),onPressed: (){
      query="";
    })];
    

  }

  @override
  Widget buildLeading(BuildContext context) {
    
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
    
    var searchResults;
    return new FutureBuilder(
      future: fetchMovies(1, query),
      builder: (context,snapshot){
        if(!snapshot.hasData){
          return Center(
                      child: SpinKitCubeGrid(
                    size: 55.0,
                    
                    itemBuilder: (context,index){
                      return DecoratedBox(
                            decoration: BoxDecoration(
                              gradient: blackBlueGradient
                            ),
                      );
                    },
                  ),
          );

        }
         else if(snapshot.hasError){
            return Center(child: Text("Some error occured"),);
          }
        searchResults = snapshot.data['results'];
        return Container(
          child: OrientationBuilder(
            builder: (context,orientation){
              return GridView.builder(
                physics: BouncingScrollPhysics(),
          padding: EdgeInsets.only(top: 5.0,right: 5.0,bottom: 15.0),
          
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount:orientation==Orientation.landscape?5:3,
            childAspectRatio: 0.50
          ),
          itemCount: query.isEmpty || searchResults==null?0:searchResults.length,
          itemBuilder: (context,index){
            
            var mediaType = searchResults[index]['media_type'];
            var _profilePath;
            var title;
            if(mediaType=='tv'){
              _profilePath = searchResults[index]['poster_path'];
              title = searchResults[index]['name'];
            }
            else if(mediaType=='movie'){
              _profilePath = searchResults[index]['poster_path'];
              title = searchResults[index]['title'];
            }
            else{
              _profilePath = searchResults[index]['profile_path'];
              title = searchResults[index]['name'];
            }
            
            var id = searchResults[index]['id'];
            
            return SearchResults(poster_image: _profilePath,title: title,type: mediaType,id: id,);
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
    

    return Center(child: Icon(FontAwesomeIcons.searchDollar,size: 54.0,),);

}
}