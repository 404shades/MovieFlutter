import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart'; 
import 'dart:ui' as ui;
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'package:movie_griller/Gradients.dart';
import 'package:movie_griller/Loader.dart';
import 'package:movie_griller/images_cast.dart';
import 'package:movie_griller/similar_movie_cell.dart';

Future<Map> getCastDetails(var id) async{
  var url = 'https://api.themoviedb.org/3/person/$id?api_key=1a43f1f22e3cf15ce2cfd8ca5af13e6f&append_to_response=images,credits';
  http.Response response = await http.get(url);
  return json.decode(response.body);
}

class CastDetail extends StatelessWidget {
  Random rand = Random();
  String getBackground(var profiles){
    int a = rand.nextInt(profiles.length);
    return profiles[a]['file_path'];
  }
  final cast_id;
  var casting;
  final image_url = 'https://image.tmdb.org/t/p/w500';
  CastDetail(this.cast_id);
  @override
  Widget build(BuildContext context) {
    print("Shahah $cast_id");
    return Scaffold(
      body: new FutureBuilder(
        future: getCastDetails(cast_id),
        builder: (context,snapshot){
          if(!snapshot.hasData){
            return Center(
              child:SpinKitPumpingHeart(
                color: Colors.black,
                size: 86.0,
                
              ),
            );
          }
            casting = snapshot.data;
            return new Stack(
              fit: StackFit.expand,
                children: <Widget>[
                  new Image.network(image_url + getBackground(casting['images']['profiles']),fit: BoxFit.cover,
                  alignment: Alignment.center,
                  
                  ),
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
                            child: new Container(
                              width: 400.0,
                              height: 400.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: NetworkImage(image_url + casting['profile_path']),
                                  fit: BoxFit.cover
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
                          ),
                          new SizedBox(height: 18.0,),
                          new Text(casting['name'],style: TextStyle(
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
                  new Text(casting['biography'],style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'google',
                    fontSize: 16.0,
                    
                  ),
                  textAlign: TextAlign.justify,
                  maxLines: 5,
                  
                  ),
                  new SizedBox(height: 18.0,),
                          new Text("Images",style: TextStyle(
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
                    height: 220.0,
                    width: MediaQuery.of(context).size.width-40,
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new Expanded(
                    child: new ListView.builder(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: casting['images']['profiles'].length,
                      itemBuilder: (context,index){
                        return Container(
                          padding: EdgeInsets.only(right: 12.0),
                          child: new ImagesOfCast(casting['images']['profiles'][index]),
                        );
                      },
                    ),
                  )
                      ],
                    ),
                  ),
                  new SizedBox(height: 18.0,),
                          new Text("Movies",style: TextStyle(
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
                    height: 220.0,
                    width: MediaQuery.of(context).size.width-40,
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new Expanded(
                    child: new ListView.builder(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: casting['images']['profiles'].length,
                      itemBuilder: (context,index){
                        return Container(
                          padding: EdgeInsets.only(right: 12.0),
                          child: new SimilarCell(casting['credits']['cast'][index],'movie'),
                        );
                      },
                    ),
                  )
                      ],
                    ),
                  ),
                        ],
                      ),
                    ),
                  )
                ],
            );
        },
      ),
    );
  }
}