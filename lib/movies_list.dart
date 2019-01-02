
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
        Navigator.of(context).push(new MaterialPageRoute(builder: (context){
          return new MovieDetail(movie[i]['id']);
        }));
      },
      child: Container(
      height: 110.0,
      width: 250.0,
      
      decoration: new BoxDecoration(
        borderRadius: BorderRadius.circular(14.0),
        
        image: new DecorationImage(
          image: new NetworkImage(
              movie[i]['backdrop_path']!=null?'https://image.tmdb.org/t/p/w500' + movie[i]['backdrop_path'].toString()
              :'https://steamuserimages-a.akamaihd.net/ugc/923674725906155229/34FAED61D4A23B8BF8771089530E209B6C0A0E75/'
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