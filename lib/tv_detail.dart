import 'dart:convert';
import 'dart:math';
import 'dart:ui' as ui;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:async';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:http/http.dart' as http;
import 'package:movie_griller/Gradients.dart';
import 'package:movie_griller/cast_cell.dart';
import 'package:movie_griller/similar_movie_cell.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:math' as math;

Future<Map> getTvDetails(var id) async{
  var url = 'https://api.themoviedb.org/3/tv/$id?api_key=1a43f1f22e3cf15ce2cfd8ca5af13e6f&language=en-US&append_to_response=images,credits,similar,videos';
  http.Response response = await http.get(url);
  if(response.statusCode==200){
    return json.decode(response.body);
  }
  else{
    return new Future.error("error");
  }
  
}
List<Widget> _getStars(double number){
  double new_number = number/2;
  int flr = new_number.toInt();
  List<Widget> icons= new List();
  for(int i=0;i<flr;i++){
      icons.add(Icon(Icons.star,color: Colors.white,),);
  }
  double half = new_number-flr;
  if(half>0.4){
    icons.add(Icon(Icons.star_half,color: Colors.white,),);
  }
  return icons;

}
class TVDetail extends StatefulWidget {
  final tv_id;

  TVDetail({this.tv_id});

  @override
  TVDetailState createState() {
    return new TVDetailState();
  }
}

class TVDetailState extends State<TVDetail> {
  var tv_show;
  Future<Map> _getDetails;

  final image_url = 'https://image.tmdb.org/t/p/w500';
  


  String getGenres(var genre){
    String answer = "";
    
    int le = min(genre.length,2); 
    if(genre.length>0){
    for(int i=0;i<le;i++){
        answer = answer + genre[i]['name']+ "|";
    }
    answer = answer.substring(0,answer.length-1);
    return answer;
    }
    else{
      return "No Genre Found";
    }
  }

  _launchURLTrailer(var videos) async{
    
    if(videos.length!=0){
      String key;
      for(int i=videos.length-1;i>=0;i--){
        if(videos[i]['type']=='Trailer'){
          key = videos[i]['key'];
          break;
        } 
        continue;
      }
      String url = "https://www.youtube.com/watch?v=$key";
      if(await canLaunch(url)){
        await launch(url);
      }
      else{
        throw 'Could Not launch url';
      }
    }
    
  }

  @override
    void initState() {
      _getDetails = getTvDetails(widget.tv_id);
      super.initState();
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       floatingActionButton: FloatingActionButton.extended(
        icon: Icon(FontAwesomeIcons.youtube),
        onPressed: (){
          if(tv_show!=null){
            _launchURLTrailer(tv_show['videos']['results']);
          }
          else{
            return null;
          }
        },
        label: Text("Trailer",style: TextStyle(
          fontFamily: 'google',
          
        ),),

        backgroundColor: Colors.transparent.withOpacity(0.8),
        
      ),
      body: FutureBuilder(
        future: _getDetails,
        builder: (context,snapshot){
          
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return new Center(child: Text("Connection Not Found"),);
            case ConnectionState.waiting:
              return Center(
                child:SpinKitCubeGrid(
                  size: 55.0,
                  
                  itemBuilder: (context,index){
                    return DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: blackBlueGradient
                          ),
                    );
                  },
                )
              );

            default:
              if(snapshot.hasError){
                return new Center(child: Text("Error : ${snapshot.error}"),);

              }
              
          
          tv_show = snapshot.data;
          List<Widget> ic = _getStars(tv_show['vote_average']?.toDouble()??0);
          return new Stack(
            fit:StackFit.expand,
            children: <Widget>[
              new FadeInImage.memoryNetwork(image:image_url + tv_show['poster_path'],fit: BoxFit.cover,
                  alignment: Alignment.center,
                  placeholder: kTransparentImage,
                  ),
              new BackdropFilter(
                filter: new ui.ImageFilter.blur(sigmaX: 7.0,sigmaY: 7.0),
                child: Container(
                  color: Colors.black.withOpacity(0.2),
                ),
                
              ),
              new SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Container(
                  margin: EdgeInsets.all(20.0),
                  
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Container(
                        alignment: Alignment.center,
                        child: Stack(
                          fit: StackFit.loose,
                          children: <Widget>[
                            Container(width: 400.0,height: 400.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14.0),
                              
                              boxShadow: [
                                new BoxShadow(
                                  color: Colors.black,
                                  blurRadius: 20.0,
                                  offset: Offset(0.0, 14.0)
                                )
                              ],
                              
                            ),
                            child: ClipRRect(borderRadius: BorderRadius.circular(14.0), child: new FadeInImage.memoryNetwork(image:image_url + tv_show['poster_path'],fit: BoxFit.cover,
                  alignment: Alignment.center,
                  placeholder: kTransparentImage,
                  ),)
                            ),
                            Positioned(
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
                                padding: const EdgeInsets.only(left: 20.0,bottom: 8.0,right: 20.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    Expanded(child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: ic
                                           
                                         ,
                                          
                                        ),
                                        Row(
                                          children: <Widget>[
                                            new Icon(FontAwesomeIcons.imdb,color: Colors.yellow,),
                                            new Padding(
                                              padding: const EdgeInsets.only(right: 4.0),
                                              
                                            ),
                                            new Text("${tv_show['vote_average'].toString()}/10",style: TextStyle(color: Colors.white,
                                            fontFamily: 'google',
                                            fontWeight: FontWeight.bold),)
                                          ],
                                        )

                                      ],
                                    ),),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.max,
                                      children: <Widget>[
                                        Text(tv_show['first_air_date'].toString(),style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'google',
                                          fontWeight: FontWeight.bold
                                        ),),
                                        Text(getGenres(tv_show['genres']),style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'google',
                                          fontWeight: FontWeight.bold
                                        ),)
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      new SizedBox(height:18.0),
                      new Text(tv_show['name'],style: TextStyle(color: Colors.white,
                      fontFamily: 'google',
                      fontWeight: FontWeight.w800,
                      fontSize: 26.0

                      ),
                      
                      ),
                      new Container(
                    margin: const EdgeInsets.only(top:3.0,bottom: 14.0),
                    width: (MediaQuery.of(context).size.width-40)/2,
                    height: 3.0,
                    decoration: BoxDecoration(
                      gradient: pinkRedGradient,
                      borderRadius: BorderRadius.circular(14.0)
                    ),
                  ),
                  new Text(tv_show['overview'],style: TextStyle(
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
                  Container(height: 170.0,
                  width: MediaQuery.of(context).size.width-40.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: ListView.builder(
                          physics: BouncingScrollPhysics(),
                          itemCount: tv_show['credits']['cast']?.length ??0,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context,i){
                            return Container(
                              padding: const EdgeInsets.only(right: 12.0),
                              child: CastCell(tv_show['credits']['cast'][i]),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                  ),
                  new SizedBox(height: 18.0,),
                  new Text("Similar TVShows",style: TextStyle(
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
                            physics: BouncingScrollPhysics(),
                            itemCount: tv_show['similar']['results']?.length?? 0,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context,i){
                              return Container(
                                padding: const EdgeInsets.only(right: 12.0),
                                child: new SimilarCell(tv_show['similar']['results'][i],'television'),
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
          }
        },
      )
    );
  }
}