import 'package:flutter/material.dart';
import 'package:movie_griller/Gradients.dart';
class MoviesSectionPage extends StatefulWidget{
  @override
  MoviesSectionPageState createState() {
    return new MoviesSectionPageState();
  }
}

class MoviesSectionPageState extends State<MoviesSectionPage> with SingleTickerProviderStateMixin{
Animation<double> animation;
AnimationController _animationController;

@override
  void initState() {
    
    super.initState();
    _animationController = AnimationController(vsync: this,duration: Duration(milliseconds: 1000));
    animation = Tween<double>(begin: 180.0,end: -7.0).animate(CurvedAnimation(curve: Curves.bounceInOut,parent: _animationController));
    _animationController.forward();
    animation.addStatusListener((status){
      if(status==AnimationStatus.completed){
        _animationController.dispose();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                                  child: Text("MOVIES",style: TextStyle(
                    fontSize: 37.0,
                    fontFamily: 'google',
                    fontWeight: FontWeight.w800,
                    letterSpacing: 5.0,
                    color: const Color(0xFFF6356F)
                  ),),
                ),
                Text('4O4 Shades',style: TextStyle(
                  fontFamily: 'google',
                  fontSize: 17.0
                ),)
              ],
            ),
            new SizedBox(
              height: 18.0,
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                GenreSection(gradient: redSexyGradient,image: 'action',title: 'ACTION',color: const Color(0xFFF6356F).withOpacity(0.8),animation: animation,),
                GenreSection(gradient: violetSexyGradient,image: 'comedy',title: 'COMEDY',color: const Color(0xFF52A7EA).withOpacity(0.8),animation: animation,)
              ],
            ),
            SizedBox(
              height: 18.0,
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                GenreSection(gradient: greenSexyGradient,image: 'horror',title: 'HORROR',color: const Color(0xFF92D000).withOpacity(0.8),animation: animation,),
                GenreSection(gradient: orangeSexyGradient,image: 'romance',title: 'ROMANCE',color: const Color(0xFFFF9B30).withOpacity(0.8),animation: animation,)
              ],
            ),

          ],
        ),
      )
    );
  }
}
class GenreSection extends AnimatedWidget {
  final image;
  final title;
  final gradient;
  final color;
  
  GenreSection({Key key,Animation<double> animation,this.image,this.title,this.gradient,this.color})
  :super(key:key,listenable:animation);
  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return Container(
      height: 120.0,
      width: 187.0,
      child: Stack(
        children: <Widget>[
          new Container(
                height: 108.0,
                width: 167.0,
                decoration: BoxDecoration(
                  
                  borderRadius: BorderRadius.circular(12.0),
                  gradient: gradient,
                  shape: BoxShape.rectangle,
                  boxShadow: [
                    BoxShadow(
                      color: color,
                      blurRadius: 5.0,
                      spreadRadius: 0.4,
                      offset: Offset(0.7,3.0)
                    ),
                    
                  ]
                ),
              ),
              new Positioned(
                top: 45.0,
                left: 25.0,
                child: Text(title,style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'google',
                  fontSize: 17.0,
                  fontWeight: FontWeight.w700
                ),),
              ),
              new Positioned(
                bottom: 0.0,
                right: animation.value,
                top: 0.0,
                child: Image.asset("assets/images/$image.png",),
              )
        ],
      ),
    );
  }
}