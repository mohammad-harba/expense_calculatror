import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransactions extends StatefulWidget {
  final Function addUserTransaction;

  NewTransactions(this.addUserTransaction);

  @override
  _NewTransactionsState createState() => _NewTransactionsState();
}

class _NewTransactionsState extends State<NewTransactions> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  DateTime selectedDate;

  void onSubmit() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    if (enteredTitle == null || enteredAmount <= 0 || selectedDate == null) {
      return;
    }

    widget.addUserTransaction(
      enteredTitle,
      enteredAmount,
      selectedDate,
    );
    Navigator.of(context).pop();
  }

  void presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      } else {
        setState(() {
          selectedDate = pickedDate;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
          child: Container(
        margin: EdgeInsets.only(
          left: 8,
          top: 8,
          right: 8,
          bottom: MediaQuery.of(context).viewInsets.bottom +10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                labelText: "Title",
                hintText: "spesa..",
                border: OutlineInputBorder(),
              ),
              controller: titleController,
              keyboardType: TextInputType.text,
              onSubmitted: (_) => onSubmit(),
              //onChanged: (value) => titleInput = value,
            ),
            TextField(
              decoration: InputDecoration(
                labelText: "Amount",
                floatingLabelBehavior: FloatingLabelBehavior.never,
                hintText: "20 \$",
                border: OutlineInputBorder(),
              ),
              controller: amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => onSubmit(),
              // onChanged: (value) {
              //   amountInput = value;
              // },
            ),
            Row(children: <Widget>[
              Flexible(
                fit: FlexFit.tight,
                child: Text(selectedDate == null
                    ? "No date selected"
                    : DateFormat.yMMMd().format(selectedDate)),
              ),
              FlatButton(
                onPressed: presentDatePicker,
                child: Text(
                  "SelectDate",
                ),
                textColor: Theme.of(context).primaryColor,
              )
            ]),
            RaisedButton(
              onPressed: onSubmit,
              child: Text("add transaction"),
              color: Theme.of(context).primaryColor,
              textColor: Theme.of(context).textTheme.button.color,
            ),
          ],
        ),
      ),
    );
  }
}
