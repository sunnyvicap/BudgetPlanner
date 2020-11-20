import 'package:budgetplanner/main.dart';
import 'package:intl/intl.dart';

class Ledger {
  var _id;
  var _name;
  var _createdDate = DateFormat('dd/MM/yyyy kk:mm a').format(DateTime.now());
  var _nextPaymentDate;
  var _totalAmount;
  var _amountPaid;
  var _totalBalance;

  Ledger(this._name, this._nextPaymentDate, this._totalAmount, this._amountPaid,
      this._totalBalance);

  get totalBalance => _totalBalance;

  set totalBalance(value) {
    _totalBalance = value;
  }

  get amountPaid => _amountPaid;

  set amountPaid(value) {
    _amountPaid = value;
  }

  get totalAmount => _totalAmount;

  set totalAmount(value) {
    _totalAmount = value;
  }

  get nextPaymentDate => _nextPaymentDate;

  set nextPaymentDate(value) {
    _nextPaymentDate = value;
  }

  get createdDate => _createdDate;

  set createdDate(value) {
    _createdDate = value;
  }

  get name => _name;

  set name(value) {
    _name = value;
  }

  get id => _id;

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    if (id != null) {
      map['id'] = _id;
    }
    map['name'] = _name;
    map['created_at'] = _createdDate;
    map['next_payment'] = _nextPaymentDate;
    map['total_amount'] = _totalAmount;
    map['amount_paid'] = _amountPaid;
    map['balance'] = _totalBalance;

    return map;
  }

  Ledger.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._name = map['name'];
    this._createdDate = map['created_at'];
    this._nextPaymentDate= map['next_payment'];
    this._totalAmount = map['total_amount'] ;
    this._amountPaid = map['amount_paid'] ;
    this._totalBalance = map['balance'];
  }
}
