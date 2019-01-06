import 'package:flutter/material.dart';
import 'package:movie_griller/tv_detail.dart';
class TopRatedTvShowCell extends StatelessWidget {
  final top_rated_cell;
  final image_url =   'https://image.tmdb.org/t/p/w500';
  TopRatedTvShowCell(this.top_rated_cell);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()=>Navigator.push(context, new MaterialPageRoute(
        fullscreenDialog: true,builder: (context)=>TVDetail(tv_id: top_rated_cell['id'],)
      )),
      child: Column(
        children: <Widget>[
          new Container(
        alignment: Alignment.center,
        child: new Container(
          height: 180.0,
          width: 130.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(11.0),
            image: DecorationImage(
              image: top_rated_cell['poster_path']!=null?NetworkImage(image_url + top_rated_cell['poster_path']):
              NetworkImage('https://steamuserimages-a.akamaihd.net/ugc/923674725906155229/34FAED61D4A23B8BF8771089530E209B6C0A0E75/')
              ,
              fit: BoxFit.cover
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black87,
                blurRadius: 5.0,
                offset: Offset(2.0, 3.0)
              )
            ]
          ),
        ),
      ),
      new Container(
        alignment: Alignment.center,
        width: 120.0,
        margin: const EdgeInsets.only(top: 10.0),
        
        child: new Text(top_rated_cell['name'],style: TextStyle(
          fontFamily: 'google',
          fontWeight: FontWeight.w400
        ),),
      )
        ],
      )
    );
  }
}