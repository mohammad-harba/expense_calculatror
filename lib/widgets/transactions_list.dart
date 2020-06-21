import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List userTransactions;
  final Function deleteTransaction;

  TransactionList(this.userTransactions, this.deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return userTransactions.isEmpty
            ? Column(
                children: <Widget>[
                  Container(
                    height: constraints.maxHeight * 0.15,
                    child: Text(
                      "There are no transactions",
                      style: Theme.of(context).textTheme.title,
                    ),
                  ),
                  SizedBox(height: constraints.maxHeight * 0.05),
                  Container(
                    height: constraints.maxHeight * 0.8,
                    child: Image.asset(
                      "assets/images/waiting.png",
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              )
            : ListView.builder(
                itemBuilder: (ctx, index) {
                  return Card(
                    elevation: 10,
                    margin: EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                    shape: Theme.of(context).cardTheme.shape,
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Theme.of(context).primaryColor,
                        radius: 30,
                        child: FittedBox(
                          child: Text(
                            "\$${userTransactions[index].amount.toStringAsFixed(2)}",
                            style: TextStyle(
                                fontWeight: Theme.of(context)
                                    .textTheme
                                    .headline6
                                    .fontWeight),
                          ),
                        ),
                      ),
                      title: Text(
                        userTransactions[index].title,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      subtitle: Text(
                        DateFormat.yMMMd().format(userTransactions[index].date),
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                      trailing: MediaQuery.of(context).size.width > 500
                          ? FlatButton.icon(
                              onPressed:(){
                                  deleteTransaction(userTransactions[index].id);
                                  },
                              icon: Icon(Icons.delete),
                              label: Text("delete Tx"),
                            )
                          : IconButton(
                              icon: Icon(Icons.delete),
                              color: Theme.of(context).errorColor,
                              onPressed: () {
                                deleteTransaction(userTransactions[index].id);
                              },
                            ),
                    ),
                  );
                },
                itemCount: userTransactions.length,
              );
      },
    );
  }
}
