import 'package:flutter/material.dart';
import 'package:livredecompte/bdd_dur/list_compte.dart';
import 'package:livredecompte/components/addaccount.dart';
import 'package:livredecompte/components/show_history_component.dart';
import 'package:livredecompte/components/show_monthly_operation.dart';
import 'package:livredecompte/models/compte.dart';
import 'package:livredecompte/models/operation.dart';

class ChoiceAccountComponent extends StatefulWidget {
  final Compte compte;

  const ChoiceAccountComponent({
    super.key,
    required this.compte,
  });

  @override
  State<ChoiceAccountComponent> createState() => _ChoiceAccountComponentState();
}

class _ChoiceAccountComponentState extends State<ChoiceAccountComponent> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _amountController = TextEditingController();
  final _nbreDeMoisController = TextEditingController();

  late DateTime _dateController;
  late String _dateString;

  String radioValue = "revenu";

  @override
  void initState() {
    reInitControllers();
    // _nameController.text = "";
    // _amountController.text = "";
    // _nbreDeMoisController.text = "";

    // _dateController = DateTime.now();

    // _dateString = getDateString(_dateController);

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  // fonction qui retourne une string de la date au format "dd/mm/yyyy"
  String getDateString(DateTime date) {
    return "${date.day < 10 ? "0${date.day}" : date.day}/${date.month < 10 ? "0${date.month}" : date.month}/${date.year}";
  }

  void reInitControllers() {
    _nameController.text = "";
    _amountController.text = "";
    _nbreDeMoisController.text = "";
    _dateController = DateTime.now();
    _dateString = getDateString(_dateController);
  }

  void validationOperationUnique() {
    if (_formKey.currentState!.validate()) {
      final Operation operation = Operation(
        id: (widget.compte.historique.length + 1).toString(),
        name: _nameController.text,
        amount: double.parse(_amountController.text),
        date: _dateController,
        type: radioValue,
        nbreDeMois: 0,
        // nbreDeMois: int.parse(_nbreDeMoisController.text),
        // isIllimited: false,
      );
      // radioValue == "revenu"
      //     ? widget.compte.amount +=
      //         double.parse(_amountController.text)
      //     : widget.compte.amount -=
      //         double.parse(_amountController.text);
      setState(() {
        widget.compte.addOperation(operation);
        reInitControllers();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Column(
            children: [
              // nom du compte en titre
              Text(
                widget.compte.name,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),

              // autorisation de découvert
              Text(
                "Autorisation : ${widget.compte.autorisationDecouvertString} €",
                style: const TextStyle(
                  fontSize: 15,
                ),
              ),

              // solde du compte
              Text(
                "Solde : ${widget.compte.amountString} €",
                style: const TextStyle(
                  fontSize: 15,
                ),
              ),

              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 3.0,
                        horizontal: 10.0,
                      ),
                      child: TextFormField(
                        textInputAction: TextInputAction.next,
                        controller: _nameController,
                        validator: ((value) {
                          value = value == null ? "" : value.trim();

                          if (value.isEmpty) {
                            return "Veuillez saisir un nom";
                          } else if (value.contains(",") ||
                              value.contains(".") ||
                              value.contains("-")) {
                            return "Les caractères , . - ne sont pas autorisés";
                          }
                          _nameController.text = value.trim();
                          return null;
                        }),
                        decoration: const InputDecoration(
                          hintText: "Ex: Salaire, loyer, ...",
                          border: OutlineInputBorder(),
                          labelText: "Nom de l'opération",
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 3.0,
                        horizontal: 10.0,
                      ),
                      child: TextFormField(
                        textInputAction: TextInputAction.next,
                        controller: _amountController,
                        validator: ((value) {
                          if (value == null || value.isEmpty) {
                            return "Veuillez saisir un montant";
                          } else if (value.contains("-")) {
                            return "Le montant ne doit pas être négatif";
                          } else if (value.contains(",")) {
                            return "Les virgules doivent être remplacées par des points";
                          } else if (double.tryParse(value) == null) {
                            return "Veuillez saisir un montant valide";
                          }
                          return null;
                        }),
                        decoration: const InputDecoration(
                          hintText: "Ex: 1000.00",
                          border: OutlineInputBorder(),
                          labelText: "Montant de l'operation",
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 3.0,
                        horizontal: 10.0,
                      ),
                      child: TextFormField(
                        textInputAction: TextInputAction.done,
                        onFieldSubmitted: (value) {
                          validationOperationUnique();
                        },
                        controller: _nbreDeMoisController,
                        validator: (value) {
                          value = value == null ? "" : value.trim();

                          if (value.isEmpty) {
                            return null;
                          } else if (value.isNotEmpty &&
                              int.tryParse(value) == null) {
                            return "Veuillez saisir un nombre entier";
                          } else if (value.isNotEmpty &&
                              int.tryParse(value) != null &&
                              int.parse(value) < 0) {
                            return "Veuillez saisir un nombre positif";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          hintText: "Ex: 4",
                          border: OutlineInputBorder(),
                          labelText:
                              "Nombre de mois (vide : unique, 0 : illimité, > 0 : mensuel)",
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        OutlinedButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                              LinearBorder.none,
                            ),
                          ),
                          onPressed: () {
                            showDatePicker(
                              context: context,
                              initialDate: _dateController,
                              firstDate:
                                  DateTime(DateTime.now().year - 1, 1, 1),
                              // first date 1er janvier de l'année précédente
                              lastDate:
                                  DateTime(DateTime.now().year + 1, 12, 31),
                              // last date 31 décembre de l'année suivante
                            ).then((value) {
                              if (value != null) {
                                _dateController = value;
                                print(getDateString(_dateController));
                              }
                              setState(() {
                                _dateString = getDateString(_dateController);
                              });
                            });
                          },
                          child: const Image(
                            width: 25.0,
                            image: AssetImage("assets/images/calendrier.png"),
                          ),
                        ),
                        Text(
                          _dateString,
                          // ternaire pour afficher le jour et le mois sur 2 digits
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),

                    // radio bouton pour choisir si l'opération est un revenu ou une charge
                    RadioListTile<String>(
                      title: const Text('Revenu'),
                      value: 'revenu',
                      groupValue: radioValue,
                      onChanged: (value) {
                        setState(() {
                          radioValue = value!;
                        });
                        print("radiovalue : $radioValue");
                      },
                    ),

                    RadioListTile<String>(
                      title: const Text('Charge'),
                      value: 'charge',
                      groupValue: radioValue,
                      onChanged: (value) {
                        setState(() {
                          radioValue = value!;
                        });
                        print("radiovalue : $radioValue");
                      },
                    ),

                    // bouton valider
                    OutlinedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.green),
                      ),
                      onPressed: () {
                        validationOperationUnique();
                      },
                      child: Text(
                        "valider".toUpperCase(),
                        style: const TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),

              //
              OutlinedButton(
                onPressed: () async {
                  await showModalBottomSheet(
                    // scrollControlDisabledMaxHeightRatio: 1,
                    scrollControlDisabledMaxHeightRatio: 0.9,
                    useSafeArea: true,
                    context: context,
                    builder: (context) => ShowHistoryComponent(
                      compte: widget.compte,
                    ),
                  );
                  setState(() {});
                },
                child: const Text(
                  "Historique",
                  style: TextStyle(color: Colors.black),
                ),
              ),

              OutlinedButton(
                onPressed: () async {
                  await showModalBottomSheet(
                    // scrollControlDisabledMaxHeightRatio: 1,
                    scrollControlDisabledMaxHeightRatio: 0.9,
                    useSafeArea: true,
                    context: context,
                    builder: (context) => ShowMonthlyOperation(
                      compte: widget.compte,
                    ),
                  );
                  setState(() {});
                },
                child: const Text(
                  "Operation Mensuelle",
                  style: TextStyle(color: Colors.black),
                ),
              ),

              OutlinedButton(
                onPressed: () async {
                  await showModalBottomSheet(
                    // scrollControlDisabledMaxHeightRatio: 1,
                    scrollControlDisabledMaxHeightRatio: 0.9,
                    useSafeArea: true,
                    context: context,
                    builder: (context) => AddAccountComponentV2(
                      compte: widget.compte,
                    ),
                  );
                  setState(() {});
                },
                child: const Text(
                  "Modifier Compte",
                  style: TextStyle(color: Colors.black),
                ),
              ),

              OutlinedButton(
                /// TODO : Suppression de l'historique liés au compte
                /// TODO : Suppression des opérations mensuelles liées au compte
                /// TODO : Suppression du compte
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.red),
                ),
                onPressed: () async {
                  await showModalBottomSheet(
                    scrollControlDisabledMaxHeightRatio: 0.5,
                    useSafeArea: true,
                    context: context,
                    builder: (context) => AlertDialog(
                      // actionsAlignment: MainAxisAlignment.center,
                      alignment: Alignment.topCenter,
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 10.0,
                      ),
                      // actionsOverflowAlignment: OverflowBarAlignment.end,
                      actionsOverflowButtonSpacing: 2.0,

                      scrollable: true,
                      elevation: 0.0,
                      title: const Text("Suppression du compte"),
                      content: const Text(
                          "Etes-vous sûr de vouloir supprimer ce compte ?"),
                      actions: [
                        OutlinedButton(
                          onPressed: () {
                            setState(() {
                              Navigator.pop(context);
                            });
                          },
                          child: const Text(
                            "Annuler",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        OutlinedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.red),
                          ),
                          onPressed: () {
                            setState(() {
                              listCompte.remove(widget.compte);
                            });

                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                          child: const Text(
                            "Supprimer Compte",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                child: const Text(
                  "Supprimer Compte",
                  style: TextStyle(color: Colors.black),
                ),
              ),

              OutlinedButton(
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
                child: Text(
                  "retour".toUpperCase(),
                  style: const TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
