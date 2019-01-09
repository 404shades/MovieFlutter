import 'package:flutter/material.dart';
import 'package:movie_griller/CastDetail.dart';
import 'package:transparent_image/transparent_image.dart';
class CastCell extends StatelessWidget {
  final image_url = 'https://image.tmdb.org/t/p/w500';
  final cast;
  CastCell(this.cast);
  @override
  Widget build(BuildContext context) {
   
    String profilePath = cast['profile_path'];
    return InkWell(
      splashColor: Colors.black,
      
      onTap: (){
        if(profilePath!=null){
        Navigator.push(context, MaterialPageRoute(builder: (context){
          return new CastDetail(cast['id']);
          
        }));
      }
      else{
      return null;
      }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
        alignment: Alignment.topCenter,
        child: Container(
          height: 90.0,
          width: 90.0,

          decoration: profilePath!=null?BoxDecoration(
            shape: BoxShape.circle,

            
            
            border: Border.all(color: Colors.white),

          ):BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.black.withOpacity(0.6)
          ),
          child: profilePath==null?Center(child: Text(cast['name'][0],
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'google',
            fontSize: 68.0,
            fontWeight: FontWeight.bold,

          ),
          ),
          
          ):ClipOval(
            

            child: FadeInImage.memoryNetwork(image:image_url+profilePath,placeholder: kTransparentImage,fit: BoxFit.cover,)
          ),
        ),
      ),
      new Container(
        alignment: Alignment.center,
        
        width: 100.0,
        child: new Text(cast['name'].toString(),style:TextStyle(
        color:Colors.white,
        fontFamily: 'google',
        fontWeight:FontWeight.w600,
        fontSize: 20.0
      ),
      textAlign: TextAlign.center,
      maxLines: 2,),
      )
        ],
      )
    );
  }
}