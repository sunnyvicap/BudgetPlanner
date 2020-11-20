import 'package:budgetplanner/Screens/add_budget.dart';
import 'package:budgetplanner/dataModel/ledger.dart';
import 'package:budgetplanner/sessions/ledeger_database.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  LedgerHelper ledgerHelper = LedgerHelper();

  List<Ledger> ledgerList;
  int count = 0;

  @override
  void initState() {
    super.initState();

    if (ledgerList == null) {
      ledgerList = List<Ledger>();
      _getListofLedger();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {},
          child: Icon(Icons.menu),
        ),
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  showDialog(context: context,
                    builder: (BuildContext context) => BudgetDialog(),
                  ).then((value) => setState((){
                    _getListofLedger();
                  }));
                },
                child: Icon(
                  Icons.add,
                  size: 26.0,
                ),
              ))
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(items: const <BottomNavigationBarItem> [
              BottomNavigationBarItem(icon:Icon(Icons.home),
        title: Text('Home'),),
        
        
         BottomNavigationBarItem(icon:Icon(Icons.add),
        title: Text('Add Budget'),), 
       
        BottomNavigationBarItem(icon:Icon(Icons.supervised_user_circle),
        title: Text('User'),)
   
   
   
      ]),
      body: ListView.builder(
        itemCount: ledgerList.length,
        itemBuilder: (context, index) {
          return Card(
            color: Colors.white,
            elevation: 2.0,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.lightBlue,
                child: Icon(Icons.account_balance_wallet,color: Colors.black,),
              ),
              title: Text(this.ledgerList[index].name),
              subtitle: Text(this.ledgerList[index].createdDate),
              trailing:
              GestureDetector(
                child: Icon(Icons.delete, color: Colors.black54,),
                onTap: () {
                  _deleteDatabase(context, ledgerList[index]);
                },
              ),


              onTap: () {

              },
            ),

          );
        },
      ),
    );
  }

  void _deleteDatabase(BuildContext context, Ledger ledger) async {
    int result = await ledgerHelper.deleteLedger(ledger.id);
    if (result != 0) {
      _showSnackBar(context, "Ledger is deleted");

      _getListofLedger();
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackbar = SnackBar(content: Text(message));
    Scaffold.of(context).showSnackBar(snackbar);
  }

  void _getListofLedger() {
    final Future<Database> dbFuture = ledgerHelper.initializeDatabase();

    dbFuture.then((value) {
      Future<List<Ledger>> ledgerFutureList = ledgerHelper.listOfLedger();
      ledgerFutureList.then((value) {
        setState(() {
          this.ledgerList = value;
          this.count = value.length;
        });
      });
    });
  }
}
