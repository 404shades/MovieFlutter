import 'package:flutter/material.dart';
import 'package:movie_griller/CastDetail.dart';


import 'package:movie_griller/MovieDetail.dart';
import 'package:movie_griller/tv_detail.dart';
import 'package:transparent_image/transparent_image.dart';
class SearchResults extends StatelessWidget {
  final _imageURL =   'https://image.tmdb.org/t/p/w500';
  final posterImage;
  final id;
  final title;
  final type;
  SearchResults({this.posterImage,this.title,this.type,this.id});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        if(posterImage!=null){
       Navigator.push(context, MaterialPageRoute(
         builder: (context){
           if(type=='movie'){
             return new MovieDetail(id);
           }
           else if(type=='person'){
             return new CastDetail(id);
           }
           else{
             return new TVDetail(tvID: id,);
           }
         }
       ));
        }
        else{
          return null;
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.all(12.0),
        child: Container(
        height: 200.0,
        
        
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
           
          boxShadow: [
            BoxShadow(
              color: Colors.black45,
              blurRadius: 6.0,
              offset: Offset(2.0, 6.0)
            ),
            

          ],
          color: posterImage==null?Colors.black:null
  
        ),
        child: posterImage==null?new Center(
          child: new Text(title.toString()[0],style: TextStyle(
            fontSize: 58.0,
            fontFamily: 'google',
            color: Colors.white
          ),),
        ):ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: FadeInImage.memoryNetwork(image:_imageURL+posterImage,fit: BoxFit.cover,
          alignment: Alignment.center,placeholder: kTransparentImage,),
        ),
      ),
      ),
      Flexible(
              child: new Container(
          margin: const EdgeInsets.only(left:8.0),
          alignment: Alignment.center,
          
          
          child: new Text(title,style: TextStyle(fontFamily: 'google',fontWeight: FontWeight.w400),maxLines: 2,overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,),
        ),
      )
        ],
      ),
    );
  }
}