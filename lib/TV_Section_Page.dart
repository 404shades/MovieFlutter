import 'package:flutter/material.dart';
import 'package:movie_griller/GenreMovies.dart';
import 'package:movie_griller/Gradients.dart';
import 'dart:ui' as ui;

import 'package:movie_griller/Movies_Section_Page.dart';
import 'package:movie_griller/main.dart';
class TVSectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      resizeToAvoidBottomPadding: false,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.home),
        label: Text("Home")
        ,
        onPressed: (){Navigator.popUntil(context, ModalRoute.withName(Navigator.defaultRouteName));},
        backgroundColor: Colors.black87,
      ),
      backgroundColor: Color(0xFFF6F7FB),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        elevation: 12.0,
        
        
        child: new Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(icon: Icon(Icons.movie,color: Colors.blue,),onPressed: (){
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                fullscreenDialog: true,
                builder: (context)=>new MoviesSectionPage()
              ));
            },),
            IconButton(icon: Icon(Icons.live_tv,color: Colors.red,),onPressed: (){
              return null;
            },)
            
          ],
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                new Padding(padding: EdgeInsets.only(left: 10.0),),
                SafeArea(
                                  child: Text("TV Series",style: TextStyle(
                    fontFamily: 'google',
                    fontSize:37.0,
                    letterSpacing: 4.0,
                    color: Colors.blueGrey.shade800,
                    fontWeight: FontWeight.w800
                  ),),
                )
              ],
            ),
            
            SizedBox(height: 10.0,),
            TVGenre(title: 'ANIMATION',image: 'assets/images/animationTV.png',gradient: orangeSexyGradient,color: const Color(0xFFFF9B30).withOpacity(0.8),genreID: 16,),
            SizedBox(height: 10.0,),
            TVGenre(title: 'CRIME',image: 'assets/images/crimeTV.png',gradient: blackBlueGradient,color: Colors.blueGrey.shade800.withOpacity(0.8),genreID: 80,),
            SizedBox(height: 10.0),
            TVGenre(title: 'COMEDY',image: 'assets/images/comedyTV.png',gradient: blueSexyGradient,color: const Color(0xFF46A3B7).withOpacity(0.8),genreID: 35,),
            SizedBox(height: 10.0),TVGenre(title: 'SCIFY ',image: 'assets/images/sciTV.png',gradient: redSexyGradient,color: const Color(0xFFF6356F).withOpacity(0.8),genreID: 10765,),
            SizedBox(height: 10.0),TVGenre(title: 'DRAMA ',image: 'assets/images/drama.png',gradient: greenSexyGradient,color: const Color(0xFF92D000).withOpacity(0.8),genreID: 18,),

          ],
        ),
      )
    );
  }
}
class TVGenre extends StatelessWidget {
  final image;
  final title;
  final gradient;
  final color;
  final genreID;
  TVGenre({@required this.image,@required this.genreID,@required this.title,@required this.gradient,@required this.color});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:  (){
        Navigator.of(context).push(MaterialPageRoute(
          fullscreenDialog: true,
          builder: (context)=>GenreMovies(genreId: genreID,genretype: 'tv',title: title,),
        ));
      },
          child: Container(
        height: 180.0,
        decoration: BoxDecoration(
          boxShadow: [
                      BoxShadow(
                        color: color,
                        blurRadius: 5.0,
                        spreadRadius: 0.4,
                        offset: Offset(0.7,3.0)
                      ),
                      
                    ]
        ),
        child: Stack(
          children: <Widget>[
            Container(decoration: BoxDecoration(
              gradient: gradient,
              borderRadius: BorderRadius.circular(16.0),
            ),),
            Positioned(
              right: 0.0,
              bottom: 0.0,
              top:0.0,
              child: Image.asset(image),

            ),
            //  new BackdropFilter(
            //   filter: ui.ImageFilter.blur(sigmaX: 1.5,sigmaY: 1.5),
            //   child: Opacity(
            //     opacity: 0.1,
            //                 child: Container(
            //       decoration: BoxDecoration(
            //         gradient: gradient
            //       ),
            //     ),
            //   ),
            // )
            // ,
            new Positioned(bottom: 10.0,left: 20.0,child: Text(
                title,style: TextStyle(
                  color: Colors.white,
                  fontSize: 45.0,
                  fontFamily: 'google',
                  fontWeight: FontWeight.bold
                ),
              ),),
           
          ],
        ),
  ),
    );
  }
}