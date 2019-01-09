import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_griller/CastDetail.dart';
import 'package:movie_griller/Gradients.dart';
import 'package:movie_griller/MovieDetail.dart';
import 'dart:ui' as ui;

import 'package:movie_griller/tv_detail.dart';
class NowPlayingCell extends StatelessWidget {
  final poster_path;
  final backdrop_path;
  final release_date;
  final ratings;
  final id;
  final name;
  final media_type;
  final image_url = 'https://image.tmdb.org/t/p/w500';

  NowPlayingCell({this.poster_path,this.backdrop_path,this.release_date,this.ratings,this.id,this.name,this.media_type});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      
      onTap: (){
        if(poster_path!=null){
        Navigator.push(context, MaterialPageRoute(
          
          builder: (context){

            if(media_type=='movie'){
              return MovieDetail(id);
            }
            else if(media_type=='tv'){
              return TVDetail(tv_id: id,);
            }
            else{
              return CastDetail(id);
            }
          }
        ));
        }
        else{
          return null;
        }
      },
      child: Card(
        
        
        
        elevation: 3.0,
        
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(0.0),
          margin: const EdgeInsets.all(0.0),
          
          
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
             backdrop_path.toString().isNotEmpty?
              new Container(
                
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(0.0),
                  image: DecorationImage(image: CachedNetworkImageProvider(image_url+backdrop_path),fit:BoxFit.cover)
                ),
              ):new Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(0.0),
                  color: Colors.white
                ),
              ),
              new BackdropFilter(
                  filter: new ui.ImageFilter.blur(sigmaX: 4.0,sigmaY: 4.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.04),
                      
                    ),
                  ),
                  
                  // child: Container(
                  //   height: 8.0,
                  //   width: 8.0,
                    
                  //   decoration: BoxDecoration(
                  //       color: Colors.black.withOpacity(0.02),
                  //       borderRadius: BorderRadius.circular(14.0)
                        
                  //   ),
                    
                  // ),
              ),
              
              new Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  new Container(
                    margin: const EdgeInsets.only(left:14.0,top: 14.0,bottom: 14.0,right: 12.0),
                    alignment: Alignment.center,
                    child: new Container(
                      width: 165.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14.0),
                        image: DecorationImage(
                          image: poster_path!=null?CachedNetworkImageProvider(image_url + poster_path):CachedNetworkImageProvider('https://image.freepik.com/free-vector/404-error-concept-with-camel-and-cactus_23-2147736339.jpg'),
                          fit: BoxFit.cover
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black87,
                            blurRadius: 6.0,
                            offset: Offset(2.0, 3.0)
                          )
                        ]
                      ),
                    ),
                  ),
                  new Flexible(
                    child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    textDirection: TextDirection.ltr,
                    children: <Widget>[
                      new Container(
                        alignment: Alignment.center,
                        
                        margin: const EdgeInsets.only(top: 16.0,right: 17.0,bottom: 12.0),
                        child: new Text(name,style:TextStyle(
                          fontFamily:'google',
                          color: Colors.white,
                          fontSize:16.0,
                          fontWeight:FontWeight.bold,
                          
                        ),maxLines: 2,overflow: TextOverflow.ellipsis,),
                      ),
                      new Expanded(
                        child: new Container(
                        alignment: Alignment.center,
                        child: FittedBox(
                          alignment: Alignment.center,
                          fit: BoxFit.cover,
                                                  child: new Center(
                            
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                  new Container(
                                    alignment: Alignment.center,
                                    height: 22.0,
                                    padding: const EdgeInsets.only(left:14.0,right: 14.0),
                                    decoration: BoxDecoration(
                                      gradient: pinkRedGradient,
                                      borderRadius: BorderRadius.circular(12.0),
                                      boxShadow: [
                                        new BoxShadow(
                                          color: Colors.black26,
                                          blurRadius: 3.0,
                                          offset: Offset(1.0, 1.8)
                                        )
                                      ]
                                    ),
                                    child: new Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        Text(ratings.toString(),style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'google',
                                      fontWeight: FontWeight.bold
                                    ),),
                                    new Icon(Icons.star_border,color: Colors.white,size: 15.0,)
                                      ],
                                    )
                                  ),
                                  SizedBox(width: 8.0,),
                                  new Container(
                                    alignment: Alignment.center,
                                    height: 22.0,
                                    
                                    padding: const EdgeInsets.only(left:14.0,right: 14.0),
                                    decoration: BoxDecoration(
                                      gradient: bluePinkGradient,
                                      borderRadius: BorderRadius.circular(12.0),
                                      boxShadow: [
                                        new BoxShadow(
                                          color: Colors.black26,
                                          blurRadius: 3.0,
                                          offset: Offset(1.0, 1.8)
                                        )
                                      ]
                                    ),
                                    child:Text(release_date.toString(),style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'google',
                                      fontWeight: FontWeight.bold
                                    ),),
                                  ),
                              ],
                            ),
                          ),
                        )
                      ),
                      )
                    ],
                  ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}