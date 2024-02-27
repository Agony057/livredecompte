import 'package:flutter/material.dart';
import 'package:livredecompte/models/compte.dart';
import 'package:livredecompte/models/operation.dart';

class ShowHistoryComponent extends StatefulWidget {
  final Compte compte;

  const ShowHistoryComponent({super.key, required this.compte});

  @override
  State<ShowHistoryComponent> createState() => _ShowHistoryComponentState();
}

class _ShowHistoryComponentState extends State<ShowHistoryComponent> {
  late final List<Operation> history;

  @override
  void initState() {
    history = widget.compte.historique;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: ListView.builder(
          shrinkWrap: true,
          reverse: true,
          itemCount: history.length,
          itemBuilder: (context, index) {
            return ListTile(
              onTap: () => setState(() {
                history[index].isPointed = !history[index].isPointed;
              }),
              leading: Checkbox(
                value: history[index].isPointed,
                onChanged: (bool? value) {
                  setState(() {
                    history[index].isPointed = value!;
                  });
                },
              ),
              title: Text(history[index].name),
              subtitle: Text(history[index].dateString),
              trailing: Text(
                history[index].amountString,
                style: TextStyle(
                  color: history[index].type == "revenu"
                      ? Colors.greenAccent[700]
                      : Colors.redAccent[700],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
