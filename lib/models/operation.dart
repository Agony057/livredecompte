class Operation {
  final String id;
  String name;
  late double _amount;
  DateTime? date;
  String type;
  int? nbreDeMois;
  bool isIllimited;
  bool isPointed;

  Operation({
    required this.id,
    required this.name,
    required double amount,
    required this.type,
    this.nbreDeMois,
    this.date,
    this.isIllimited = false,
    this.isPointed = false,
  }) {
    date = date ?? DateTime.now();
    nbreDeMois = nbreDeMois ?? -1; // -1 pour les operations illimitées
    this.amount = amount;
  }

  double get amount {
    return _amount;
  }

  set amount(double value) {
    _amount = value.abs();
  }

  String get amountString {
    return _amount.toStringAsFixed(2);
  }

  String get dateString {
    String dateStr = "";
    if (date != null) {
      dateStr = "${date!.day}/${date!.month}/${date!.year}";
    }
    return dateStr;
  }

  String get nbreDeMoisString {
    String nbreDeMoisStr = "";
    if (nbreDeMois != null) {
      nbreDeMoisStr = nbreDeMois!.toString();
    }
    return nbreDeMoisStr;
  }

  @override
  String toString() {
    return "[$date] $name : $_amount €. ${!isIllimited ? "Encore $nbreDeMois mois" : ""}";
  }
}
