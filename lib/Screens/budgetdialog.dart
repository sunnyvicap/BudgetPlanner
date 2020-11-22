import 'package:budgetplanner/dataModel/ledger.dart';
import 'package:budgetplanner/sessions/ledeger_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:toast/toast.dart';

class BudgetDialog extends StatefulWidget {
  BudgetDialog();

  @override
  _BudgetDialogState createState() => _BudgetDialogState();
}

class _BudgetDialogState extends State<BudgetDialog> {

  LedgerHelper ledgerHelper = LedgerHelper();

  var formatCDate;
  var balance = 0;

  var errorMessages;
  var selectedDate = DateTime.now();
  var payerNameController = TextEditingController();
  var currentDateController = TextEditingController();
  var scheduleDateController = TextEditingController();
  var amountPaidController = TextEditingController();
  var totalAmountController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        String format =  DateFormat('dd/MM/yyyy').format(selectedDate);
        scheduleDateController.text = format;
      });




  }

  @override
  void initState() {

  super.initState();

    DateTime now = DateTime.now();
    formatCDate = DateFormat('dd/MM/yyyy kk:mm a').format(now);
    currentDateController.text = formatCDate;

    amountPaidController.addListener(() {
      var totalamount = int.parse(totalAmountController.text);
      var paid =int.parse( amountPaidController.text);

      if(totalamount > paid){

         balance = totalamount - paid;
        setState(() {

        });

      }else{

        errorMessages = "Paid amount cannot be greater then total Amount";
        setState(() {

        });
      }


    });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    payerNameController.dispose();
    currentDateController.dispose();
    scheduleDateController.dispose();
    totalAmountController.dispose();
    amountPaidController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  dialogContent(BuildContext context) {
    return Stack(
      children: <Widget>[
        SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(20.0),
            margin: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10.0,
                  offset: const Offset(0.0, 10.0),
                ),
              ],
            ),
            child: Column(
                mainAxisSize: MainAxisSize.min, // To make the card compact
                children: <Widget>[
                  Text(
                    "Add Ledger",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  TextField(
                    controller: payerNameController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        hintText: 'Enter name of payer',
                        hintStyle: TextStyle(
                          fontSize: 12.0,
                          color: Colors.black38,
                        )),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  TextField(
                    controller: currentDateController,
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
                          color: Colors.lightBlue,
                        )),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  TextField(
                    controller: scheduleDateController,
                    onTap: () {
                      _selectDate(context);
                    },
                    readOnly: true,
                    showCursor: false,
                    decoration: InputDecoration(
                        hintText: 'Schedule Next Payment Date & Time',
                        hintStyle: TextStyle(
                          fontSize: 12.0,
                          color: Colors.black38,
                        ),
                        suffixIcon: Icon(
                          Icons.calendar_today,
                          color: Colors.lightBlue,
                        )),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  TextField(
                    controller: totalAmountController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        hintText: 'Enter Total Amount',
                        hintStyle: TextStyle(
                          fontSize: 12.0,
                          color: Colors.black38,
                        ),
                        suffixIcon: Icon(
                          Icons.euro_symbol,
                        )),
                  ),
                  SizedBox(height: 10.0),
                  TextField(
                    controller: amountPaidController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        hintText: 'Enter Amount Paid',
                        errorText: errorMessages,
                        hintStyle: TextStyle(
                          fontSize: 12.0,
                          color: Colors.black38,
                        ),
                        suffixIcon: Icon(
                          Icons.euro_symbol,
                        )),
                  ),
                  SizedBox(height: 15.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        'Balance : ',
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.black54,
                        ),
                      ),
                      Text(
                        ' $balance',
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.black54,
                        ),
                      ),
                      Icon(Icons.euro_symbol),
                    ],
                  ),
                  SizedBox(height: 24.0),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: FlatButton(
                      onPressed: () {
                        _inserLedgerData();
                        Navigator.of(context).pop(true); // To close the dialog
                      },
                      child: Text('Add'),
                    ),
                  ),
                ]),
          ),
        )
      ],
    );


  }


  void _inserLedgerData() async{

   var ledger = Ledger(payerNameController.text ,
       scheduleDateController.text, totalAmountController.text,amountPaidController.text,balance);

   int result;
   result = await ledgerHelper.insertLedger(ledger);

   if(result !=0){
     Toast.show('Data Inserted Successfull', context);
   }else{

     Toast.show('Data Inserted Failed', context);

   }
  }


}
