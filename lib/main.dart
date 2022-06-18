import 'dart:math';
import 'package:flutter/material.dart';
import 'detail.dart';
import 'package:google_fonts/google_fonts.dart';
import 'my_dropdown.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange
      ),
      home: const MyHomePage(title: 'Комнатные растения', ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
// класс для карточки растения Монстера, включает фото, имя, описание
class MySuperHero {
  final String img;
  final String title;
  final String description;

  MySuperHero(this.img, this.title, this.description);
}


 class _MyHomePageState extends State<MyHomePage>  with TickerProviderStateMixin  {

 

  //контроллер и анимация для плавного появления картинок
  late AnimationController _controllerOpacity;
  late Animation<double> _animationOpacity;

  // //контроллер для вращения картинки (вращается постоянно)
  late AnimationController _controllerRotation = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 10),
  )
    ..repeat();
    
      
  @override
  void initState() {
     //картинки начинают появляться при старте приложения
    _controllerOpacity = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );
    _animationOpacity = Tween(begin: 0.0, end: 1.0).animate(_controllerOpacity);
    _controllerOpacity.forward();

    super.initState();
  }

  @override
  void dispose() {
    _controllerRotation.dispose();
    _controllerOpacity.dispose();
    super.dispose();

  }
     List<MySuperHero> items = <MySuperHero>[];
//добавление фото, имени, описания
  _MyHomePageState() {
    items.add( MySuperHero("assets/images/monstera.jpg", 
    "Monstera",
    "Отбросив суеверия, вызванные легендой о растении, можно сказать уверенно: бояться монстеру не нужно - нужно приобретать, наслаждаться экзотическим видом и чистым воздухом! Монстера, как и большинство ароидных, умеет фильтровать нежелательные химические вещества в воздухе: углекислый газ, формальдегид и прочих спутников человека в мегаполисе."),
    );
  }
   


  Widget mHero (BuildContext context, int index) {
    //по нажатию выполняется переход на страницу с большой фотографией
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MyDetailPage(items[index])));
      },
      

    //карточка растения Монстера
      child: Card(
          margin: EdgeInsets.all(15),
          elevation: 4.0,
          child: Container(
            padding: EdgeInsets.all(1),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                     FadeTransition(
                      opacity: _animationOpacity,
                      child:
                    Hero(
                      tag: items[index],
                      child: Image.asset(items[index].img, 
                       height: 100,
                       width: 100,),
                     )),
                    const SizedBox(width: 27),
                    Text(
                      items[index].title,
                      style: GoogleFonts.getFont('El Messiri', fontSize: 23), 
                    ),
                  ],
                ),
                const Icon(Icons.navigate_next, color: Colors.deepOrange),
                
              ],
            ),
            
          ), 
          ),
          
    );
    
  
  
 
 
  }
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
       body: Column(
        children: <Widget>[
          const MyDropdown(),
     Expanded(
            flex: 2,
            child:
            ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) => mHero(context, index),
            ),
           
          
    ),
    Expanded(
      flex:4,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          //плавное появление и анимация-вращение картинки (венок из листьев)
          AnimatedBuilder(
                    animation: _controllerRotation,
                    child: FadeTransition(
                      opacity: _animationOpacity,
                      child: Image.asset('assets/images/leaf_frame.png', scale: 4, width: 100, height: 100,),
                    ),
                    builder: (BuildContext context, Widget? child) {
                      return Transform.rotate(
                        angle: _controllerRotation.value * 1.0 * pi,
                        child: child,
                      );
                    },
                  ),
                  Text('Одно из самых востребованных \n растений в интерьерном  дизайне.\n Уже в самом названии заключена\n интрига, некий потаенный смысл!\n Однако Монстера -  это\n не только тренд, но и большая польза',style:GoogleFonts.getFont('El Messiri', fontSize: 15))
        ],
      ),
    ),
    ]
    ),
    );
    
  }
 }
 
 