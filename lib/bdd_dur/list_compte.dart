import 'package:livredecompte/models/compte.dart';
import 'package:livredecompte/models/operation.dart';

List<Compte> listCompte = [
  Compte(
    name: "Compte Courant BNP Paribas",
    number: "1",
    amount: -1500.10,
    autorisationDecouvert: -600.0,
    historique: List.generate(
      3,
      (index) => Operation(
        id: index.toString(),
        name: "Operation $index",
        amount: -100.0,
        type: "charge",
        isIllimited: false,
      ),
    ),
    operationMensuelle: [
      Operation(
          id: "1",
          name: "Salaire",
          amount: 2000.0,
          type: "revenu",
          isIllimited: true,
          isPointed: true),
      Operation(
        id: "2",
        name: "Loyer",
        amount: -500.0,
        type: "charge",
        isIllimited: true,
      ),
      Operation(
        id: "3",
        name: "Electricité",
        amount: -100.0,
        type: "charge",
        isIllimited: true,
      ),
    ],
  ),
  Compte(
    name: "Compte BPL",
    number: "2",
    amount: -400.23,
    autorisationDecouvert: -500.0,
    historique: [
      Operation(
        id: "1",
        name: "Salaire",
        amount: 2000.0,
        type: "revenu",
        isIllimited: false,
        isPointed: true,
      ),
      Operation(
        id: "2",
        name: "Loyer",
        amount: -500.0,
        type: "charge",
        isIllimited: false,
        isPointed: true,
      ),
      Operation(
        id: "3",
        name: "Electricité",
        amount: -100.0,
        type: "charge",
        isIllimited: false,
      ),
    ],
    operationMensuelle: [
      Operation(
        id: "1",
        name: "Salaire",
        amount: 2000.0,
        type: "revenu",
        isIllimited: true,
      ),
      Operation(
        id: "2",
        name: "Loyer",
        amount: -500.0,
        type: "charge",
        isIllimited: true,
      ),
    ],
  ),
  Compte(
    name: "Compte BNP",
    number: "3",
    amount: -200.04,
    autorisationDecouvert: -200.0,
  ),
  Compte(
    name: "Livret A Anthony",
    number: "4",
    amount: -100.56,
    autorisationDecouvert: 50.0,
  ),
  Compte(
    name: "Livret Jeune Céleste",
    number: "5",
    amount: -50.78,
    autorisationDecouvert: 20.0,
  ),
  Compte(
    name: "Livret A Justine",
    number: "6",
    amount: 0.91,
    autorisationDecouvert: 0.0,
  ),
  Compte(
    name: "PEL Justine BNP",
    number: "7",
    amount: 50.0,
    autorisationDecouvert: 0.0,
  ),
  Compte(
    name: "PEL Anthony BPL",
    number: "8",
    amount: 100.0,
    autorisationDecouvert: 0.0,
  ),
  Compte(
    name: "PERCO Justine",
    number: "9",
    amount: 200.0,
  ),
  Compte(name: "PEE Justine", number: "10", amount: 500.0),
  Compte(
    name: "Encore un nom de compte",
    number: "11",
    amount: 50000.0,
  ),
  Compte(
    name: "Et un dernier",
    number: "12",
    amount: 100000.0,
  ),
];
