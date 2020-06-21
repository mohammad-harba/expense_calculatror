import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:expense_calculatror/models/transactions.dart';
import './chart_bar.dart';

class Chart extends StatelessWidget {
  List<Transactions> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactionsValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));

      double totalSum = 0;
      for (int i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          // DateFormat.yMMMd(recentTransactions[i].date)== DateFormat.yMMMd(weekDay)) {
          totalSum += recentTransactions[i].amount;
        }
      }

      print(DateFormat.E().format(weekDay));
      print(totalSum);

      return {
        "day": DateFormat.E().format(weekDay).substring(0, 1),
        "amount": totalSum,
      };
    }).reversed.toList();
  }

  double totalSpending() {
    return groupedTransactionsValues.fold(0.0, (previousValue, element) {
      var value;
      value = previousValue + element["amount"];
      return value;
    });
  }

  @override
  Widget build(BuildContext context) {
    print(groupedTransactionsValues);

    return Card(
    margin: EdgeInsets.symmetric(vertical:6 , horizontal: 8),
    elevation: 50,
    shape: Theme.of(context).cardTheme.shape,
    child: Padding(
      padding: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: groupedTransactionsValues.map((data) {
          return Flexible(
            fit: FlexFit.tight,
            child: ChartBar(data["day"], data["amount"], () {
              if (totalSpending() == 0) {
                return 0.0;
              } else {
                return (data["amount"] as double) / totalSpending();
              }
            }()),
          );
        }).toList(),
      ),
    ));
  }
}
