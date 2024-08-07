
import 'package:budgetplanner/dataModel/ledger.dart';
import 'package:budgetplanner/sessions/ledeger_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
    
      children: [
    
        Container(
          margin: EdgeInsets.fromLTRB(10, 0, 0, 10),
          child: Stack(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  elevation: 10,
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Material(
                        child: Container(
                            color: Colors.pinkAccent,
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      20, 30, 0, 0),
                                  child: Text(
                                    "Balance",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25.0),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      20, 5, 0, 30),
                                  child: Text(
                                    "30,000 Rs.",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 20.0),
                                  ),
                                ),
                              ],
                            )),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                  child: Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 20, 0),
                child: Align(
                  alignment: Alignment.topRight,
                  child: Image(
                    width: 100.0,
                    height: 100.0,
                    image: AssetImage('images/piggybank.png'),
                  ),
                ),
              )),
            ],
          ),
        ),
        SizedBox(
          width: 10.0,
        ),
        Container(
          margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  color: Colors.purple,
                  clipBehavior: Clip.antiAlias,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment:
                          MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Material(
                          color: Colors.purple,
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Income',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              Text(
                                '45,000 Rs.',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.white),
                              )
                            ],
                          ),
                        ),
                        Image(
                            width: 50,
                            height: 50,
                            image: AssetImage('images/income.png'))
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  color: Colors.deepOrangeAccent,
                  clipBehavior: Clip.antiAlias,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment:
                          MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Material(
                          color: Colors.deepOrangeAccent,
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Expense',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              Text(
                                '-15,000 Rs.',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                ),
                              )
                            ],
                          ),
                        ),
                        Image(
                            width: 50,
                            height: 50,
                            image: AssetImage('images/expense.png'))
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
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

