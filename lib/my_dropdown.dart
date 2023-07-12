import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';



class MyDropdown extends StatefulWidget{
  const MyDropdown({Key? key}) : super(key: key);

  @override
  State<MyDropdown> createState() => _MyDropdownState();
}

bool _dropDownShow = false;

class _MyDropdownState extends State<MyDropdown> with TickerProviderStateMixin {
  //Arrow control and DropDown list control
  
  late AnimationController _controllerArrow;
  late final AnimationController _controllerDropDown = AnimationController(
  
    duration: const Duration(seconds: 1),
    vsync: this,
  );
  late final Animation<double> _animationDropDown = CurvedAnimation(
    parent: _controllerDropDown,
    curve: Curves.easeIn,
  );


  @override
  void initState() {
 
    _controllerArrow = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 1)
    );
    super.initState();
  }
 //close
  
  @override
  void dispose() {
    _controllerDropDown.dispose();
    _controllerArrow.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
      Card(
        margin: const EdgeInsets.symmetric(horizontal: 14),
        elevation: 0,
        child: ListTile(
        title: Text('Подробнее о растении', style:GoogleFonts.getFont('El Messiri', fontSize: 15)),
        trailing: GestureDetector(
          //arrow rotation
          
          child: RotationTransition(
              turns: Tween(begin: -0.5, end: 0.0).animate(_controllerArrow),
              child: const Icon(Icons.arrow_upward, color: Colors.deepOrange,)),
              //show or hide text on click
          
          onTap: () {
            if (_dropDownShow == false) {
              _controllerDropDown.forward();
              _controllerArrow.forward();
              _dropDownShow = true;
            } else {
              _controllerArrow.reverse();
              _controllerDropDown.reverse();
              _dropDownShow = false;
            }
          },
        ),
      ),
      ),
      SizeTransition(
          sizeFactor: _animationDropDown,
          axis: Axis.vertical,
          axisAlignment: 1,
          child:  Card(
            margin: const EdgeInsets.symmetric(horizontal: 14),
            elevation: 0,
            child: ListTile(
            title: Text('Режим полива \nОсобенности почвы \nО регионе естественного произрастания', style:GoogleFonts.getFont('El Messiri', fontSize: 15)),
          )))]
    );
  }
}
