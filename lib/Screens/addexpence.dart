import 'package:flutter/material.dart';

class AddExpense extends StatefulWidget {
  @override
  _AddExpenseState createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
 
 List categories = ['Select Catgory', 'Food','Grocery','Fuel','Vegetable','Other'];
 String _currentCategory;
 
  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      appBar:AppBar(
        title: Text('Add Expense'),
    
      ),
      body: SafeArea(child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children :[
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                 border: Border.all(
      color: Colors.pink,
      width: 0.5,
    ),
              ),
              margin: EdgeInsets.all(10),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10,0,10,0),
                child: DropdownButton<String>(items: categories.map((e) => new DropdownMenuItem<String>(
                                value: e,
                                child: Text(e),
                              )).toList(), 
                              onChanged: (value) {
                                setState(() {
                         
                              _currentCategory = value;

                                });
                },
                value: _currentCategory,
                icon: Icon(Icons.expand_more),
                elevation: 5,
                isExpanded: true,
          
                ),
              )
          

            ),
            SizedBox(
              height: 10
            ),
            Container(
            
             margin: EdgeInsets.all(10),
             child: TextField(
                      readOnly: true,
                      showCursor: false,
                      decoration: InputDecoration(
                          hintText: 'Current  Date & Time',
                          hintStyle: TextStyle(
                            fontSize: 12.0,
                            color: Colors.black38,
                          ),
                          suffixIcon: Icon(
                            Icons.calendar_today,
                            color: Colors.pink,
                          )),
                    ),
            ),
           SizedBox(
              height: 10
            ),
            Container(
            
             child:Row(
          
           mainAxisAlignment : MainAxisAlignment.spaceAround,
           crossAxisAlignment: CrossAxisAlignment.start,

           children: [
                 Text('Sr No.',
                 style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 15,
                  fontFamily: 'Roboto'

                 ),),
                                  
                 Text('Name of good'),
                
                 Text('Price (Rs.)'),


              ],)

            )

          ]
        ) ,),),
      
    );
  }
}