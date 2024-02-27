import 'package:flutter/material.dart';
import 'package:livredecompte/models/compte.dart';
import 'package:livredecompte/models/operation.dart';

class ShowMonthlyOperation extends StatefulWidget {
  final Compte compte;

  const ShowMonthlyOperation({
    super.key,
    required this.compte,
  });

  @override
  State<ShowMonthlyOperation> createState() => _ShowMonthlyOperationState();
}

class _ShowMonthlyOperationState extends State<ShowMonthlyOperation> {
  late List<Operation> monthlyOperation;

  @override
  void initState() {
    monthlyOperation = widget.compte.operationMensuelle;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: ListView.builder(
          itemCount: monthlyOperation.length,
          itemBuilder: (context, index) {
            return ListTile(
              onTap: () => setState(() {
                monthlyOperation[index].isPointed =
                    !monthlyOperation[index].isPointed;
              }),
              leading: Checkbox(
                value: monthlyOperation[index].isPointed,
                onChanged: (bool? value) {
                  setState(() {
                    monthlyOperation[index].isPointed = value!;
                  });
                },
              ),
              title: Text(monthlyOperation[index].name),
              subtitle: Text(monthlyOperation[index].dateString),
              trailing: Text(
                monthlyOperation[index].amountString,
                style: TextStyle(
                  color: monthlyOperation[index].type == "revenu"
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
