
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart'; 
import 'dart:ui' as ui;

import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movie_griller/Gradients.dart';

import 'dart:convert';


import 'package:movie_griller/images_cast.dart';
import 'package:movie_griller/similar_movie_cell.dart';
import 'package:transparent_image/transparent_image.dart';

Future<Map> getCastDetails(var id) async{
  var url = 'https://api.themoviedb.org/3/person/$id?api_key=1a43f1f22e3cf15ce2cfd8ca5af13e6f&append_to_response=images,combined_credits';
  http.Response response = await http.get(url);
  return json.decode(response.body);
}

class CastDetail extends StatelessWidget {
  
  final cast_id;
  var casting;
  final image_url = 'https://image.tmdb.org/t/p/w500';
  CastDetail(this.cast_id);
  @override
  Widget build(BuildContext context) {
    print(cast_id);
    return Scaffold(
      body: new FutureBuilder(
        future: getCastDetails(cast_id),
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
                )
            );
          }
          else if(snapshot.hasError){
            return Center(child: Text("Some error occured"),);
          }
            casting = snapshot.data;
            return new Stack(
              fit: StackFit.expand,
                children: <Widget>[
                  new FadeInImage.memoryNetwork(image:image_url + casting['profile_path'],fit: BoxFit.cover,
                  alignment: Alignment.center,
                  placeholder: kTransparentImage,
                  ),
                  new BackdropFilter(
                    filter: new ui.ImageFilter.blur(sigmaX: 7.0,sigmaY: 7.0),
                    child: Container(
                      color: Colors.black.withOpacity(0.5),
                    ),
                  ),
                  new SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Container(
                      margin: EdgeInsets.all(20.0),
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          
                          SafeArea(
                                                      child: new Container(
                              width: MediaQuery.of(context).size.width-40.0,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    height: 150.0,
                                    width: 150.0,
                                    decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      shape: BoxShape.circle,
                                      border: Border.all(color: Colors.white),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.white.withOpacity(0.8),
                                          blurRadius: 20.0,
                                          spreadRadius: 4.0,
                                          offset: Offset(0.0, 2.0)
                                        )
                                      ]
                                    ),
                                    child: Container(
                                      
                                      margin: const EdgeInsets.all(4.0),
                                      
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        
                                      ),
                                      child: ClipOval(
                                        child: FadeInImage.memoryNetwork(image: image_url+casting['profile_path'],placeholder: kTransparentImage,fit: BoxFit.cover,alignment: Alignment.center,),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 14.0,),
                                  Container(
                                    padding: const EdgeInsets.all(4.0),
                                    height: 60.0,
                                    width: 60.0,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white.withOpacity(0.97)
                                    ),
                                    child: FittedBox(
                                                                        child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          Icon(FontAwesomeIcons.solidHeart,color: Colors.red,size: 20.0,),
                                          Text(casting['popularity'].toString(),style: TextStyle(
                                            fontFamily: 'google',
                                            fontWeight: FontWeight.bold
                                          ),)
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ),
                          ),
                          new SizedBox(height: 18.0,),
                          new Text(casting['name'].toString().split(" ")[0],style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'google',
                            fontWeight: FontWeight.w800,
                            fontSize: 30.0
                          ),),
                          new SizedBox(height: 6.0,),
                          casting['name'].toString().split(" ").length>=2?
                          new Text(casting['name'].toString().split(" ").sublist(1).join(" "),style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'google',
                            fontWeight: FontWeight.w500,
                            fontSize: 27.0
                          ),):SizedBox(height: 0.0,),
                          
                          
                          new SizedBox(height: 10.0,),
                          new Text(casting['place_of_birth'].toString(),style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'google',
                            fontSize: 18.0,
                            fontWeight: FontWeight.w700
                          ),),
                          
                           
                  new SizedBox(height: 20.0,),
                  new Container(
                    margin: const EdgeInsets.only(top:3.0,bottom: 14.0),
                    width: (MediaQuery.of(context).size.width-40)/1.5,
                    height: 2.5,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14.0)
                    ),
                  ),
                  
                  // new SizedBox(height: 18.0,),
                  new Text(casting['biography'],style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'google',
                    fontSize: 16.0,
                    
                  ),
                  maxLines: 7,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.justify,
                  
                  
                  ),
                         
                  

                  
                  new SizedBox(height: 18.0,),
                          new Text("Credits",style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'google',
                    fontWeight: FontWeight.w800,
                    fontSize: 26.0
                  ),),
                  // new Container(
                  //   margin: const EdgeInsets.only(top:3.0,bottom: 14.0),
                  //   width: (MediaQuery.of(context).size.width-40)/2,
                  //   height: 3.0,
                  //   decoration: BoxDecoration(
                  //     gradient: yellowOrangeGradient,
                  //     borderRadius: BorderRadius.circular(14.0)
                  //   ),
                  // ),
                  new SizedBox(height:18.0),
                  new Container(
                    height: 220.0,
                    
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new Expanded(
                    child: new ListView.builder(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: casting['combined_credits']['cast']?.length??0,
                      itemBuilder: (context,index){
                        return Container(
                          padding: EdgeInsets.only(right: 12.0),
                          child: new SimilarCell(casting['combined_credits']['cast'][index],casting['combined_credits']['cast'][index]['media_type']),
                        );
                      },
                    ),
                  )
                      ],
                    ),
                  ),
                  new SizedBox(height: 18.0,),
                   new Text("Images",style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'google',
                    fontWeight: FontWeight.w800,
                    fontSize: 26.0
                  ),),
                  new SizedBox(height:18.0),
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
                      itemCount: casting['images']['profiles']?.length??0,
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