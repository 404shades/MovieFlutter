import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_griller/tv_detail.dart';
class TopRatedTvShowCell extends StatelessWidget {
  final topRatedCell;
  final _imageURL =   'https://image.tmdb.org/t/p/w500';
  TopRatedTvShowCell(this.topRatedCell);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      
      onTap: ()=>topRatedCell['poster_path']!=null?Navigator.push(context, new MaterialPageRoute(
        fullscreenDialog: true,builder: (context)=>TVDetail(tvID: topRatedCell['id'],)
      )):null,
      child: Column(
        children: <Widget>[
          new Container(
        alignment: Alignment.center,
        child: new Container(
          height: 180.0,
          width: 130.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(11.0),
           
            boxShadow: [
              BoxShadow(
                color: Colors.black87,
                blurRadius: 5.0,
                offset: Offset(2.0, 3.0)
              )
            ]
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(11.0),
            child: CachedNetworkImage(imageUrl: topRatedCell['poster_path']!=null?_imageURL+topRatedCell['poster_path']:'https://image.freepik.com/free-vector/404-error-concept-with-camel-and-cactus_23-2147736339.jpg',fit: BoxFit.cover,alignment: Alignment.center,),
          ),
        ),
      ),
      Flexible(
              child: new Container(
          alignment: Alignment.center,
          width: 120.0,
          margin: const EdgeInsets.only(top: 10.0),
          
          child: new Text(topRatedCell['name'],style: TextStyle(
            fontFamily: 'google',
            fontWeight: FontWeight.w400
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,),
        ),
      )
        ],
      )
    );
  }
}