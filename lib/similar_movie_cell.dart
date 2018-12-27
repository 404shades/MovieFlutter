import 'package:flutter/material.dart';
import 'package:movie_griller/MovieDetail.dart';
import 'package:movie_griller/tv_detail.dart';
class SimilarCell extends StatelessWidget {
  final similar_movies;
  final type;
  final image_url = 'https://image.tmdb.org/t/p/w500';
  SimilarCell(this.similar_movies,this.type);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
          
          builder: (context){
            if(type=='movie'){
            return new MovieDetail(similar_movies['id']);
            }
            return new TVDetail(tv_id:similar_movies['id']);
          }
        ));
      },
      child: new Container(
        alignment: Alignment.center,
        child: new Stack(
          fit: StackFit.loose,
          children: <Widget>[
            new Container(
              height: 320.0,
              width: 130.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6.0),
                image: DecorationImage(
                  image: NetworkImage(image_url+similar_movies['poster_path']),
                  fit: BoxFit.cover
                ),

              ),
            ),
            // new Positioned(
            //   left: 0.0,
            //   right: 0.0,
            //   bottom: 0.0,
            //   child: Container(
            //     decoration: BoxDecoration(
            //       gradient: LinearGradient(
            //         colors: [
            //           Colors.transparent,
            //           Colors.black.withOpacity(0.8),

            //         ],
            //         begin: Alignment.topCenter,
            //         end: Alignment.bottomCenter
            //       ),
            //       borderRadius: BorderRadius.circular(14.0),
                  
            //     ),
            //     padding: const EdgeInsets.all(16.0),
            //     child: new Row(
            //       children: <Widget>[
            //         new Expanded(
            //           child: new Text(similar_movies['title'],
            //           style:TextStyle(
            //             color:Colors.white,
            //             fontFamily:'google',
            //             fontWeight:FontWeight.bold
            //           )),
            //         ),
            //         new Text(similar_movies['vote_average'].toString(),
            //         style:TextStyle(
            //           color:Colors.white,
            //           fontFamily: 'google',
            //           fontWeight: FontWeight.bold
            //         ))
            //       ],
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}