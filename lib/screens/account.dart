import 'package:flutter/material.dart';
import 'package:livredecompte/bdd_dur/list_compte.dart';
import 'package:livredecompte/components/addaccount.dart';
import 'package:livredecompte/components/choice_account_component.dart';
import 'package:livredecompte/models/compte.dart';

class AccountSreen2 extends StatefulWidget {
  const AccountSreen2({super.key});

  @override
  State<AccountSreen2> createState() => _AccountSreen2State();
}

class _AccountSreen2State extends State<AccountSreen2> {
  String getImage(Compte compte) {
    // fonction qui retourne le chemin de l'image en fonction du montant
    if (compte.amount >= 1000) {
      return "assets/images/soleil-orange-happy.png";
    } else if (compte.amount >= 500) {
      return "assets/images/soleil-happy.png";
    } else if (compte.amount >= 100) {
      return "assets/images/soleil.png";
    } else if (compte.autorisationDecouvert != 0 &&
        compte.amount <= -(compte.autorisationDecouvert * 2.5)) {
      return "assets/images/orage.png";
    } else if (compte.autorisationDecouvert == 0 && compte.amount <= -1000) {
      return "assets/images/orage.png";
    } else if (compte.autorisationDecouvert != 0 &&
        compte.amount <= -(compte.autorisationDecouvert * 1.5)) {
      return "assets/images/eclair.png";
    } else if (compte.autorisationDecouvert == 0 && compte.amount <= -200) {
      return "assets/images/eclair.png";
    } else if (compte.amount <= compte.autorisationDecouvert) {
      return "assets/images/pluie.png";
    } else {
      return "assets/images/nuages-et-soleil.png";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Theme.of(context).colorScheme.background,
      floatingActionButton: FloatingActionButton(
        // shape: RoundedRectangleBorder(
        //   borderRadius: BorderRadius.circular(30.0),
        // ),
        mini: true,
        // elevation: 0.0,
        // backgroundColor: Theme.of(context).primaryColor.withOpacity(0.2),
        onPressed: () async {
          // showBottomSheet(
          //     context: context,
          //     builder: (context) => const AddAccountComponentV2());
          await showModalBottomSheet(
            // backgroundColor: Theme.of(context).colorScheme.background,
            // scrollControlDisabledMaxHeightRatio: 1,
            scrollControlDisabledMaxHeightRatio: 0.9,
            useSafeArea: true,
            context: context,
            builder: (context) => const AddAccountComponentV2(),
          );
          setState(() {});
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {},
        ),
        title: Text("mes comptes".toUpperCase()),
        actions: [
          IconButton(
              onPressed: () => setState(() {}),
              icon: const Icon(Icons.refresh_outlined))
        ],
      ),
      body: ListView.builder(
        itemCount: listCompte.length,
        itemBuilder: (context, index) {
          return ListTile(
            shape: Border(
              bottom: BorderSide(
                color: Theme.of(context).primaryColor,
                width: 1.0,
              ),
            ),
            splashColor: Theme.of(context).primaryColor.withOpacity(0.3),
            onTap: () async {
              await showModalBottomSheet(
                scrollControlDisabledMaxHeightRatio: 1,
                // scrollControlDisabledMaxHeightRatio: 0.9,
                useSafeArea: true,
                context: context,
                builder: (context) => ChoiceAccountComponent(
                  compte: listCompte[index],
                ),
              );
              setState(() {});
            },
            leading: Image(
              width: 40.0,
              image: AssetImage(
                getImage(listCompte[index]),
              ),
            ),
            title: Text(
              listCompte[index].name,
              // style: const TextStyle(
              //   fontSize: 20.0,
              // ),
            ),
            subtitle: Text(
              listCompte[index].number,
              // style: const TextStyle(
              //   fontSize: 10.0,
              //   color: Colors.grey,
              // ),
            ),
            trailing: Text(
              "${listCompte[index].amountString} €",
              style: TextStyle(
                color: listCompte[index].amount < 0
                    ? Colors.red
                    : listCompte[index].amount == 0
                        ? Colors.black
                        : Colors.green,
              ),
            ),
          );
        },
      ),
    );
  }
}
