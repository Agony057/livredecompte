import 'package:flutter/material.dart';

class AddAccountComponent extends StatelessWidget {
  const AddAccountComponent({super.key});

  void _modal(BuildContext context) => showModalBottomSheet(
        context: context,
        builder: (context) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Wrap(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("compte creator".toUpperCase()),
              ),
              SizedBox(),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Numéro de compte (facultatif)",
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Nom de compte",
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Solde initial (facultatif)",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text("annuler".toUpperCase()),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text("valider".toUpperCase()),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => _modal(context),
      // backgroundColor: Colors.deepPurple,
      child: const Icon(Icons.add),
    );
  }
}
