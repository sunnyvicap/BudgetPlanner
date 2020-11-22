import 'dart:developer';

import 'package:budgetplanner/Screens/budgetdialog.dart';
import 'package:budgetplanner/Screens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


class Index extends StatefulWidget {
  @override
  _IndexState createState() => _IndexState();
}

class _IndexState extends State<Index>
 
    with SingleTickerProviderStateMixin {
     AnimationController _controller;
     int _selectedIndex = 0;

   List months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];

  String _currentMonth;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);

     _currentMonth = _getCurrentMonth();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
       bottomNavigationBar: BottomNavigationBar(
         icons: [
           Icons.home,
           Icons.insert_chart,
           Icons.dashboard
         ],
         defaultSelectedIndex: 0,
         onChange: (value) {
           setState(() {
             
          _selectedIndex = value;
           });
         },
       ),
       body: SafeArea(
         
         child: SingleChildScrollView(

          child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                   Padding(
                     padding: const EdgeInsets.all(10.0),
                     child: DropdownButton<String>(
                  value: _currentMonth,
                  icon: Icon(Icons.expand_more),
                  iconSize: 25.0,
                  elevation: 16,
                  underline: Container(
                      height: 2,
                      color: Colors.white,
                  ),
                  style: TextStyle(
                        color: Colors.black,
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold),
                  items: months
                        .map((e) => new DropdownMenuItem<String>(
                              value: e,
                              child: Text(e),
                            ))
                        .toList(),
                  onChanged: (String newValue) {
                      setState(() {
                        _currentMonth = newValue;
                      });
                  }
                  ),
                   ),
                   _changeWidgetBottomClick(_selectedIndex),

               ],
          ),
                
           ),
        
          
       ),
      floatingActionButton: _buildFab(context),
    
    );
       
       
  }


Widget _buildFab(BuildContext context) {
  final names =['Add Income','Add Expense'];
  final icons = [ Icons.add, Icons.add ];
  return FabOverlay(
    icons: icons,
    names: names,
    onIconTapped: (index) {
      onClickFloatingButtons(index,context);
    },
  );
}

String _getCurrentMonth() {
    var now = new DateTime.now();
    var currentMonth = now.month;
    return months[currentMonth - 1];
  }


 _changeWidgetBottomClick(int selectedIndex) {

switch(selectedIndex){
  case 0:
   return Home();
  case 1:
    return Text("Hello Bottom $selectedIndex",
    style: TextStyle(
      fontSize: 25,
    ),);

     case 2:
    return Text("Hello Bottom $selectedIndex",
    style: TextStyle(
      fontSize: 25,
    ),);
}
  
      
}

}

void onClickFloatingButtons(int index,BuildContext context) {
  switch(index){

     case 0:
    
    showDialog(context: context,
     builder: (context) => BudgetDialog(), );

    break;

    case 1:
    
         Navigator.pushNamed(context, '/addexpense');


    break;


  }
}



          
class FabOverlay extends StatefulWidget {

 final List<IconData> icons;
  final ValueChanged<int> onIconTapped;
  final  List names ;

  FabOverlay({this.icons, this.onIconTapped,@required this.names});
 
  @override
  _FabOverlayState createState() => _FabOverlayState();
}

class _FabOverlayState extends State<FabOverlay> with TickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
   
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: List.generate(widget.icons.length, (int index) {
        return _buildChild(index);
      }).toList()..add(
        _buildFab(),
      ),
    );
  }

 Widget _buildChild(int index) {
    Color backgroundColor = Theme.of(context).cardColor;
    Color foregroundColor = Theme.of(context).accentColor;
    return Container(
      height: 70.0,
      width: 120.0,
      alignment: FractionalOffset.topCenter,
      child: ScaleTransition(
        scale: CurvedAnimation(
          parent: _controller,
          curve: Interval(
              0.0,
              1.0 - index / widget.icons.length / 2.0,
              curve: Curves.easeOut
          ),
        ),
        child: FloatingActionButton.extended(
          backgroundColor: backgroundColor,
          label: Text(widget.names[index],
          style: TextStyle(color: Colors.black,
          fontSize: 10)),
          icon: Icon(widget.icons[index], color: foregroundColor),
          onPressed: () => _onTapped(index),
                  heroTag: null,

        ),
      ),
    );
  }


  Widget _buildFab() {
    return FloatingActionButton(
          child: Container(
            width: 60,
            height: 60,
            child: Icon(
              Icons.add,
              size: 40,
            ),
            
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(colors: [Colors.pink[200], Colors.pink])),
          ),
                  heroTag: null,

          onPressed: () {
                  
       if (_controller.isDismissed) {
          _controller.forward();
        } else {
          _controller.reverse();
        }
  
          }
    );
  }

  void _onTapped(int index) {
    _controller.reverse();
    widget.onIconTapped(index);
  }


}



class BottomNavigationBar extends StatefulWidget {

  final int defaultSelectedIndex;
  final Function (int) onChange;
  final List<IconData> icons ;
   BottomNavigationBar({this.defaultSelectedIndex = 0,@required this.icons,@required this.onChange});

  @override
  _BottomNavigationBarState createState() => _BottomNavigationBarState();
}

class _BottomNavigationBarState extends State<BottomNavigationBar>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

    int _currentBottomIndex = 0;
    List<IconData> _bottomicons = [];


  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    _currentBottomIndex = widget.defaultSelectedIndex;
    _bottomicons = widget.icons; 
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

   @override
  Widget build(BuildContext context) {
  

    List<Widget> rowWidgets =[];

    for(int i=0 ; i<_bottomicons.length ; i++){
        rowWidgets.add(buildNavBar(_bottomicons[i], i));
    }
  
  
    return Row(
          children: rowWidgets
        );
  }

  

     Widget buildNavBar(IconData iconData, int activeIndex) {
   
   
    return GestureDetector(
      onTap: () {
    
        widget.onChange(activeIndex);
        setState(() {

          _currentBottomIndex = activeIndex;
        });
      },
          child: Container(
                height: 60,
                width: MediaQuery.of(context).size.width/_bottomicons.length,
                child: Icon(iconData,
                size: 30,
                color: _currentBottomIndex == activeIndex ? Colors.pink : Colors.grey),
                decoration: _currentBottomIndex == activeIndex ? 
                BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 4, color: Colors.pink[700]),
                  ),
                  gradient: LinearGradient(colors: [
                    Colors.pink.withOpacity(0.3),
                    Colors.green.withOpacity(0.015),
                  ]) ,
                 // color: _currentBottomIndex == activeIndex ? Colors.green : Colors.white),
               ) : BoxDecoration(),
          )
    );
            
    
  }

}