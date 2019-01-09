import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

_launchFacebook() async{
      var url = "https://www.facebook.com/rohan4uu";
      if(await canLaunch(url)){
        await launch(url);
      }
      else{
        throw 'Could Not launch url';
      }
    }
   _launchTwitter() async{
      var url = "https://www.twitter.com/rohanforyou";
      if(await canLaunch(url)){
        await launch(url);
      }
      else{
        throw 'Could Not launch url';
      }
    } 
  _launchInstagram() async{
      var url = "https://www.instagram.com/rohan_4_u";
      if(await canLaunch(url)){
        await launch(url);
      }
      else{
        throw 'Could Not launch url';
      }
    }
    _launchlinkedIn() async{
      var url = "https://www.linkedin.com/in/404shades";
      if(await canLaunch(url)){
        await launch(url);
      }
      else{
        throw 'Could Not launch url';
      }
    }  
    _launchGit() async{
      var url = "https://www.github.com/404shades";
      if(await canLaunch(url)){
        await launch(url);
      }
      else{
        throw 'Could Not launch url';
      }
    } 
    _launchWeb() async{
      var url = "https://www.about.me/fourofour";
      if(await canLaunch(url)){
        await launch(url);
      }
      else{
        throw 'Could Not launch url';
      }
    } 
class UserDeveloper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit:StackFit.expand,
        children: <Widget>[
          new FadeInImage(image:AssetImage('assets/images/user.jpg'),fit: BoxFit.cover,alignment: Alignment.center,placeholder: NetworkImage("url"),),
          new BackdropFilter(
            filter: ui.ImageFilter.blur(sigmaX: 5.0,sigmaY: 5.0),
            child: Container(
              color: Colors.black.withOpacity(0.5),
            ),

          ),
          new SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              margin: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SafeArea(
                                      child: Container(width: MediaQuery.of(context).size.width-40.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          height: 150.0,
                          width: 150.0,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white),
                            boxShadow: [
                              BoxShadow(color: Colors.white.withOpacity(0.8),
                              blurRadius: 20.0,
                              spreadRadius: 4.0,
                              offset: Offset(0.0, 2.0)
                              )
                            ]
                          ),
                          child: Container(
                            margin: const EdgeInsets.all(4.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: AssetImage("assets/images/user.jpg"),
                                fit: BoxFit.cover,
                                alignment: Alignment.center,

                              )
                            ),
                          ),
                        ),
                        SizedBox(width: 14.0,),
                        

                      ],
                    ),
                    ),
                  ),
                  SizedBox(
                    height: 18.0,
                  ),
                  new Text("Rohan",style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'google',
                            fontWeight: FontWeight.w800,
                            fontSize: 30.0
                          ),),
                          new SizedBox(height: 6.0,),
                         
                          new Text("Malik",style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'google',
                            fontWeight: FontWeight.w500,
                            fontSize: 27.0
                          ),),
                          
                          
                          new SizedBox(height: 10.0,),
                          new Text("4O4Shades",style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'google',
                            fontSize: 18.0,
                            fontWeight: FontWeight.w700
                          ),),
                          
                           
                  new SizedBox(height: 20.0,),
                  new Container(
                    margin: const EdgeInsets.only(top:3.0,bottom: 14.0),
                    width: (MediaQuery.of(context).size.width-40)/1.5,
                    height: 2.5,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14.0)
                    ),
                  ),
                  
                  // new SizedBox(height: 18.0,),
                  new Text("A code lover, with an undying passion for Development. Contributed to various live projects. Knowledgeable about Git Version Control, Mobile Applications, Web Development and Machine Learning. Proficient in programming with a clear grasp of OOPS fundamentals. Excellent collaboration and communication skills. Team Player with a can-do attitude, phenomenal management skills, and a strong user focus. Adept at conveying complex technical information to lay audiences in a simple and clear manner.",style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'google',
                    fontSize: 16.0,
                    
                  ),
                  
                 
                  textAlign: TextAlign.center,
                  
                  
                  ),
                         
                  

                  
                  new SizedBox(height: 18.0,),
                  new Text("Profiles",style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'google',
                    fontWeight: FontWeight.w800,
                    fontSize: 26.0
                  ),),
                  SizedBox(height: 18.0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      IconButton(icon: Icon(FontAwesomeIcons.facebookSquare,color: Colors.white,),onPressed: _launchFacebook,),
                      IconButton(icon: Icon(FontAwesomeIcons.instagram,color: Colors.white,),onPressed: _launchInstagram,),
                      IconButton(icon: Icon(FontAwesomeIcons.twitter,color: Colors.white,),onPressed: _launchTwitter,),
                      IconButton(icon: Icon(FontAwesomeIcons.github,color: Colors.white,),onPressed: _launchGit,),
                      IconButton(icon: Icon(FontAwesomeIcons.linkedin,color: Colors.white,),onPressed: _launchlinkedIn,),
                      IconButton(icon: Icon(FontAwesomeIcons.globeAsia,color: Colors.white,),onPressed: _launchWeb,)

                    ],
                  )
                ],
              ),
            )
          )
        ],
      ),
    );
  }
}