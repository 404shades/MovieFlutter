import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
class ImagesOfCast extends StatelessWidget {
  final image_cast;
  final image_url = 'https://image.tmdb.org/t/p/w500';
  ImagesOfCast(this.image_cast);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: new Container(
          alignment: Alignment.center,
          
          child: new Container(
            height: 320.0,
            width: 130.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              
              boxShadow: [
                new BoxShadow(
                  color: Colors.black,
                  blurRadius: 2.0,
                  offset: Offset(1.0, 3.0)
                )
              ]

            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: FadeInImage.memoryNetwork(image:image_url + image_cast['file_path'],fit: BoxFit.cover,alignment: Alignment.center,placeholder: kTransparentImage,),
            ),
          ),
        ),
      
    );
  }
}