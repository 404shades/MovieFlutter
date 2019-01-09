
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_griller/MovieDetail.dart';

class TopRatedMovieCell extends StatelessWidget {

  final image_url = 'https://image.tmdb.org/t/p/w500/';
  final movie;
  final i;
  TopRatedMovieCell(this.movie,this.i);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:(){
        if(movie[i]['poster_path']!=null){
        Navigator.of(context).push(new MaterialPageRoute(builder: (context){
          return new MovieDetail(movie[i]['id']);
        }));
      }
      else{
        return null;
      }
      },
      child: Container(
      height: 110.0,
      width: 250.0,
      
      decoration: new BoxDecoration(
        borderRadius: BorderRadius.circular(14.0),
        
        image: new DecorationImage(
          image: new CachedNetworkImageProvider(
              movie[i]['backdrop_path']!=null?'https://image.tmdb.org/t/p/w500' + movie[i]['backdrop_path'].toString()
              :'https://www.solodev.com/core/fileparse.php/131/urlt/pixar-404.JPG',
              
          ),
          fit: BoxFit.cover,
          
        ),
        boxShadow: [
          new BoxShadow(
            color: Colors.black,
            blurRadius: 5.0,
            offset: new Offset(2.0, 3.0)
          )
        ]
      ),
    ),
    );
  }
}