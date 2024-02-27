import 'package:flutter/material.dart';
import 'package:livredecompte/bdd_dur/list_compte.dart';
import 'package:livredecompte/models/compte.dart';

class AddAccountComponentV2 extends StatefulWidget {
  final Compte? compte;

  const AddAccountComponentV2({
    super.key,
    this.compte,
  });

  @override
  State<AddAccountComponentV2> createState() => _AddAccountComponentV2State();
}

class _AddAccountComponentV2State extends State<AddAccountComponentV2> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _numberController = TextEditingController();
  final _amountController = TextEditingController();

  late final bool modify;

  // final RegExp _doubleRegex = RegExp(r'^-?[0-9]+(.[0-9]+)?$');
  // final RegExp _intRegex = RegExp(r'^-?[0-9]+$');

  @override
  void initState() {
    reInitControllers();
    modify = widget.compte != null ? true : false;

    if (widget.compte != null) {
      _nameController.text = widget.compte!.name;
      _numberController.text = widget.compte!.number;
      _amountController.text = widget.compte!.amount.toString();
    }

    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _numberController.dispose();
    _amountController.dispose();

    super.dispose();
  }

  void reInitControllers() {
    _nameController.text = "";
    _numberController.text = "";
    _amountController.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 10.0,
      ),
      child: Scaffold(
        // backgroundColor: Theme.of(context).colorScheme.background,
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            onPopInvoked: (didPop) {
              reInitControllers();
            },
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 4.0),
                  child: Text(
                    modify
                        ? "modifier compte".toUpperCase()
                        : "créer compte".toUpperCase(),
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),

                // numero de compte
                modify
                    ? Text(
                        "Compte : ${widget.compte!.number}",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 3.0,
                          horizontal: 10.0,
                        ),
                        child: TextFormField(
                          readOnly: modify,
                          textInputAction: TextInputAction.next,
                          controller: _numberController,
                          validator: ((value) {
                            // on efface les espaces avant et après la valeur
                            if (value != null) {
                              value = value.trim();
                            }

                            if (value == null || value.isEmpty) {
                              _numberController.text = "";
                              return null;
                            } else if (int.tryParse(value) == null) {
                              return "Le numéro de compte doit être un nombre entier";
                            }

                            _numberController.text = value;
                            return null;
                          }),
                          decoration: const InputDecoration(
                            hintText: "Ex: 1234567890",
                            border: OutlineInputBorder(),
                            labelText: "Numéro du compte (facultatif)",
                          ),
                        ),
                      ),

                // nom du compte
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 3.0,
                    horizontal: 10.0,
                  ),
                  child: TextFormField(
                    textInputAction: TextInputAction.next,
                    controller: _nameController,
                    validator: ((value) {
                      // on efface les espaces avant et après la valeur
                      if (value != null) {
                        value = value.trim();
                      }

                      if (value == null || value.isEmpty) {
                        return "Veuillez entrer un nom de compte";
                      } else if (value.contains(".") ||
                          value.contains(",") ||
                          value.contains(":") ||
                          value.contains(";") ||
                          value.contains("!") ||
                          value.contains("?")) {
                        return "Les caractères . , : ; ! ? ne sont pas autorisés";
                      }

                      _nameController.text = value;
                      return null;
                    }),
                    decoration: const InputDecoration(
                      hintText: "Ex: Compte Courant {Nom de la banque}",
                      border: OutlineInputBorder(),
                      labelText: "Nom du compte",
                    ),
                  ),
                ),

                // solde initial
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 3.0,
                    horizontal: 10.0,
                  ),
                  child: TextFormField(
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: (value) {
                      formValidation(context);
                    },
                    controller: _amountController,
                    validator: ((value) {
                      // on efface les espaces avant et après la valeur
                      if (value != null) {
                        value = value.trim();
                      }
                      // si la valeur est vide on attribue la valeur par defaut au controller
                      if (value != null && value.isEmpty) {
                        _amountController.text = "0.0";
                        return null;
                        // si la valeur contient une virgule
                      } else if (value != null && value.contains(",")) {
                        return "La virgule doit être un point";
                        // si la valeur n'est pas un double
                      } else if (value != null &&
                          double.tryParse(value) == null) {
                        return "Le solde doit être un nombre";
                      }
                      // on attribue la valeur au controller
                      if (value != null) {
                        _amountController.text = value;
                      }
                      return null;
                    }),
                    decoration: InputDecoration(
                      hintText: "Ex: 1000.00",
                      border: const OutlineInputBorder(),
                      labelText: modify
                          ? "Solde actuel (changement)"
                          : "Solde initial (facultatif)",
                    ),
                  ),
                ),

                // boutons sur une meme ligne
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    OutlinedButton(
                      onPressed: () {
                        reInitControllers();

                        Navigator.pop(context);
                      },
                      child: Text("annuler".toUpperCase()),
                    ),
                    OutlinedButton(
                      onPressed: () {
                        formValidation(context);
                      },
                      child: Text("valider".toUpperCase()),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> formValidation(context) async {
    // si le formulaire est valide
    if (_formKey.currentState!.validate()) {
      // on va forcer la fermeture du clavier
      FocusScope.of(context).unfocus();

      // on affiche un snackbar pour indiquer que le traitement est en cours
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Traitement en cours..."),
          duration: Duration(seconds: 1),
        ),
      );

      // Si on est en mode modification
      if (modify) {
        final Compte compteAModifier = listCompte
            .firstWhere((unCompte) => unCompte.number == widget.compte!.number);
        // final Compte compteAModifier =
        // listCompte[listCompte.indexOf(widget.compte!)];
        // on modifie le compte dans la liste en dur par la suite les champs en bdd
        compteAModifier.name = _nameController.text;
        // compteAModifier.number = _numberController.text;
        compteAModifier.amount =
            double.tryParse(_amountController.text) ?? widget.compte!.amount;
      } else {
        // sinon on est en mode creation
        // on ajoute le compte à la liste en dur qui sera par la suite en bdd

        Compte compte = Compte(
          name: _nameController.text,
          number: _numberController.text == ""
              ? DateTime.now().millisecondsSinceEpoch.toString()
              : _numberController.text,
          amount: double.tryParse(_amountController.text) ?? 0.0,
        );

        listCompte.add(compte);
      }

      // un temps d'attente de 3 secondes pour simuler un traitement
      await Future.delayed(const Duration(seconds: 2));

      reInitControllers();

      Navigator.pop(context);

      // on affiche un snackbar pour indiquer que le traitement est terminé
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.green,
          content: Text("Traitement terminé"),
          duration: Duration(seconds: 1),
        ),

        // mis a jour de la liste
      );
    }
  }

  // void _modal(BuildContext context) => showModalBottomSheet(
  //       scrollControlDisabledMaxHeightRatio: 1,
  //       useSafeArea: true,
  //       context: context,
  //       builder: (context) => Padding(
  //         padding: const EdgeInsets.symmetric(
  //           vertical: 5.0,
  //           horizontal: 20.0,
  //         ),
  //         child: Form(
  //           key: _formKey,
  //           onPopInvoked: (didPop) {
  //             reInitControllers();
  //           },
  //           child: Column(
  //             children: [
  //               Padding(
  //                 padding: const EdgeInsets.symmetric(vertical: 8.0),
  //                 child: Text(
  //                   "compte creator".toUpperCase(),
  //                   style: TextStyle(fontSize: 20),
  //                 ),
  //               ),

  //               // numero de compte
  //               Padding(
  //                 padding: const EdgeInsets.symmetric(vertical: 3.0),
  //                 child: TextFormField(
  //

  //                   readOnly: readOnly,
  //                   textInputAction: TextInputAction.next,
  //                   controller: _numberController,
  //                   validator: ((value) {
  //                     // on efface les espaces avant et après la valeur
  //                     if (value != null) {
  //                       value = value.trim();
  //                     }

  //                     if (value == null || value.isEmpty) {
  //                       _nameController.text = "";
  //                       return null;
  //                     } else if (int.tryParse(value) == null) {
  //                       return "Le numéro de compte doit être un nombre entier";
  //                     }
  //                     return null;
  //                   }),
  //                   decoration: const InputDecoration(
  //                     hintText: "Ex: 1234567890",
  //                     border: OutlineInputBorder(),
  //                     labelText: "Numéro du compte (facultatif)",
  //                   ),
  //                 ),
  //               ),

  //               // nom du compte
  //               Padding(
  //                 padding: const EdgeInsets.symmetric(vertical: 3.0),
  //                 child: TextFormField(
  //                   textInputAction: TextInputAction.next,
  //                   controller: _nameController,
  //                   validator: ((value) {
  //                     // on efface les espaces avant et après la valeur
  //                     if (value != null) {
  //                       value = value.trim();
  //                     }

  //                     if (value == null || value.isEmpty) {
  //                       return "Veuillez entrer un nom de compte";
  //                     } else if (value.contains(".") ||
  //                         value.contains(",") ||
  //                         value.contains(":") ||
  //                         value.contains(";") ||
  //                         value.contains("!") ||
  //                         value.contains("?")) {
  //                       return "Les caractères . , : ; ! ? ne sont pas autorisés";
  //                     }
  //                     return null;
  //                   }),
  //                   decoration: const InputDecoration(
  //                     hintText: "Ex: Compte Courant {Nom de la banque}",
  //                     border: OutlineInputBorder(),
  //                     labelText: "Nom du compte",
  //                   ),
  //                 ),
  //               ),

  //               // solde initial
  //               Padding(
  //                 padding: const EdgeInsets.symmetric(vertical: 3.0),
  //                 child: TextFormField(
  //                   textInputAction: TextInputAction.done,
  //                   onFieldSubmitted: (value) {
  //                     if (_formKey.currentState!.validate()) {

  //                       print("form is valid on submit");
  //                       reInitControllers();
  //                       Navigator.pop(context);
  //                     }
  //                   },
  //                   controller: _amountController,
  //                   validator: ((value) {
  //                     // on efface les espaces avant et après la valeur
  //                     if (value != null) {
  //                       value = value.trim();
  //                     }
  //                     // si la valeur est vide on attribue la valeur par defaut au controller
  //                     if (value != null && value.isEmpty) {
  //                       _amountController.text = "0.0";
  //                       return null;
  //                       // si la valeur contient une virgule
  //                     } else if (value != null && value.contains(",")) {
  //                       return "La virgule doit être un point";
  //                       // si la valeur n'est pas un double
  //                     } else if (value != null &&
  //                         double.tryParse(value) == null) {
  //                       return "Le solde doit être un nombre";
  //                     }
  //                     // on attribue la valeur au controller
  //                     if (value != null) {
  //                       _amountController.text = value;
  //                     }
  //                     return null;
  //                   }),
  //                   decoration: const InputDecoration(
  //                     hintText: "Ex: 1000.00",
  //                     border: OutlineInputBorder(),
  //                     labelText: "Solde initial (facultatif)",
  //                   ),
  //                 ),
  //               ),

  //               // boutons sur une meme ligne
  //               Row(
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 children: [
  //                   OutlinedButton(
  //                     onPressed: () {
  //                       reInitControllers();

  //                       Navigator.pop(context);
  //                     },
  //                     child: Text("annuler".toUpperCase()),
  //                   ),
  //                   SizedBox(
  //                     // width = largeur de l'écran * 0.1
  //                     width: MediaQuery.of(context).size.width * 0.1,
  //                   ),
  //                   OutlinedButton(
  //                     onPressed: () {
  //                       if (_formKey.currentState!.validate()) {

  //                         ///
  //                         print("form is valid");
  //                         reInitControllers();
  //                         Navigator.pop(context);
  //                       }
  //                     },
  //                     child: Text("valider".toUpperCase()),
  //                   ),
  //                 ],
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //     );

  // @override
  // Widget build(BuildContext context) {
  //   return FloatingActionButton(
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.circular(30.0),
  //     ),
  //     mini: true,
  //     elevation: 0.0,
  //     backgroundColor: Theme.of(context).primaryColor.withOpacity(0.2),
  //     onPressed: () => _modal(context),
  //     child: const Icon(Icons.add),
  //   );
  // }
}
