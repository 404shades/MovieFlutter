import 'package:flutter/material.dart';
import 'dart:math';
class Loader extends StatefulWidget {
  @override
  _LoaderState createState() => _LoaderState();
}

class _LoaderState extends State<Loader> with SingleTickerProviderStateMixin{
  AnimationController controller;
  Animation<double> animation_rotation;
  Animation<double> animation_radius_in;
  Animation<double> animation_radius_out;

  final double initial_radius = 30.0;
  double radius = 0.0;

  @override
    void initState() {
      // TODO: implement initState
      super.initState();
      controller = AnimationController(vsync: this,duration: Duration(seconds: 3));
      animation_rotation = Tween<double>(begin: 0.0,end: 1.0).animate(
        CurvedAnimation(parent: controller,curve: Interval(0.0, 1.0,curve: Curves.linear))
      );
      animation_radius_in = Tween<double>(begin: 1.0,end: 0.0).animate(CurvedAnimation(parent: controller,
        curve: Interval(0.75, 1.0,curve: Curves.elasticIn)
      ));
      animation_radius_out = Tween<double>(begin: 0.0,end: 1.0).animate(CurvedAnimation(parent: controller,
        curve: Interval(0.0, 0.25,curve: Curves.elasticOut)
      ));

      controller.addListener((){
        setState(() {
                  if(controller.value>=0.75 && controller.value<=1.0){
          radius = animation_radius_in.value*initial_radius;
        }
        else if(controller.value>=0.0 && controller.value<=0.25){
          radius = animation_radius_out.value*initial_radius;
        }
                });
        
      });
      controller.repeat();
    }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.0,
      height: 100.0,
      child: Center(
        child: RotationTransition(
          turns: animation_rotation,
          child: Stack(
          children: <Widget>[
            Dot(color: Colors.black,radius: 30.0,),
            Transform.translate(
              offset: Offset(radius*cos(pi/4), radius*sin(pi/4)),
              child: Dot(color: Colors.redAccent,radius: 5.0,),
            ),
            Transform.translate(
              offset: Offset(radius*cos(2*pi/4), radius*sin(2*pi/4)),
              child: Dot(color: Colors.amberAccent,radius: 5.0,),
            ),
            Transform.translate(
              offset: Offset(radius*cos(3*pi/4), radius*sin(3*pi/4)),
              child: Dot(color: Colors.blueAccent,radius: 5.0,),
            ),
            Transform.translate(
              offset: Offset(radius*cos(4*pi/4), radius*sin(4*pi/4)),
              child: Dot(color: Colors.cyanAccent,radius: 5.0,),
            ),
            Transform.translate(
              offset: Offset(radius*cos(5*pi/4), radius*sin(5*pi/4)),
              child: Dot(color: Colors.deepOrange,radius: 5.0,),
            ),
            Transform.translate(
              offset: Offset(radius*cos(6*pi/4), radius*sin(6*pi/4)),
              child: Dot(color: Colors.deepPurpleAccent,radius: 5.0,),
            ),
            Transform.translate(
              offset: Offset(radius*cos(7*pi/4), radius*sin(7*pi/4)),
              child: Dot(color: Colors.limeAccent,radius: 5.0,),
            ),
            Transform.translate(
              offset: Offset(radius*cos(8*pi/4), radius*sin(8*pi/4)),
              child: Dot(color: Colors.orangeAccent,radius: 5.0,),
            )
          ],
        ),
        )
      ),
    );
  }
}

class Dot extends StatelessWidget {
  final double radius;
  final Color color;
  Dot({this.color,this.radius});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
      width: this.radius,
      height: this.radius,
      decoration: BoxDecoration(
        color: this.color,
        shape: BoxShape.circle
      ),
    ),
    );
  }
}