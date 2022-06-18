import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//класс dropdown

class MyDropdown extends StatefulWidget{
  const MyDropdown({Key? key}) : super(key: key);

  @override
  State<MyDropdown> createState() => _MyDropdownState();
}

bool _dropDownShow = false;

class _MyDropdownState extends State<MyDropdown> with TickerProviderStateMixin {
   //функции контроля за стрелкой Arrow и списком DropDown
  late AnimationController _controllerArrow;
  late final AnimationController _controllerDropDown = AnimationController(
    //за сколько секунд раскроется список
    duration: const Duration(seconds: 1),
    vsync: this,
  );
  late final Animation<double> _animationDropDown = CurvedAnimation(
    parent: _controllerDropDown,
    curve: Curves.easeIn,
  );


  @override
  void initState() {
    //функция контроля за стрелкой Arrow и за сколько секунд она повернется
    _controllerArrow = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 1)
    );
    super.initState();
  }
 //закрыть
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
          //вращение стрелки
          child: RotationTransition(
              turns: Tween(begin: -0.5, end: 0.0).animate(_controllerArrow),
              child: const Icon(Icons.arrow_upward, color: Colors.deepOrange,)),
              //по нажатию показать или скрыть текст
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