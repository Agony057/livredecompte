import 'package:livredecompte/models/operation.dart';

class Compte {
  final String number;
  String name;
  double amount;
  late double _autorisationDecouvert;
  final List<Operation> historique;
  final List<Operation> operationMensuelle;

  Compte(
      {required this.name,
      required this.number,
      required this.amount,
      this.historique = const [],
      this.operationMensuelle = const [],
      double autorisationDecouvert = 0}) {
    this.autorisationDecouvert = autorisationDecouvert;
  }

  // getter of amount to return a string with 2 decimal
  String get amountString {
    return amount.toStringAsFixed(2);
  }

  double get autorisationDecouvert {
    return _autorisationDecouvert;
  }

  String get autorisationDecouvertString {
    return _autorisationDecouvert.toStringAsFixed(2);
  }

  set autorisationDecouvert(double value) {
    _autorisationDecouvert = value.abs();
  }

  void addOperation(Operation operation) {
    historique.add(operation);
    operation.type == "revenu"
        ? amount += operation.amount
        : amount -= operation.amount;
  }

  void removeOperation(Operation operation) {
    historique.remove(operation);
    operation.type == "revenu"
        ? amount -= operation.amount
        : amount += operation.amount;
  }

  void addOperationMensuelle(Operation operation) {
    operationMensuelle.add(operation);
  }

  void removeOperationMensuelle(Operation operation) {
    operationMensuelle.remove(operation);
  }

  @override
  String toString() {
    return "$name : $amount €";
  }
}
