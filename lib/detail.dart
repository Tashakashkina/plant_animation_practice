import 'package:flutter/material.dart';
import 'main.dart';


class MyDetailPage extends StatefulWidget {
 late MySuperHero _superHero;

  MyDetailPage(MySuperHero superHero, {Key? key}) : super(key: key) {
    _superHero = superHero;
  }

  @override
  _MyDetailPageState createState() => _MyDetailPageState(_superHero);
}

class _MyDetailPageState extends State<MyDetailPage> {
 late MySuperHero superHero;

  _MyDetailPageState(this.superHero);

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text(superHero.title),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Hero(
            transitionOnUserGestures: true,
            tag: superHero,
            child: Transform.scale(
              scale: 2.0,
              child: Image.asset(superHero.img, height: 200,
    width: 200,),
            ),
          ),
          Card(
            elevation: 8,
            margin: EdgeInsets.all(6),
            child: Container(
              padding: EdgeInsets.all(6),
              child: Text(superHero.description),
            )
          ),
        ],
      )),
    );
  }
}