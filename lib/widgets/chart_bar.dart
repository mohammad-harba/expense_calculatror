import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ChartBar extends StatelessWidget {
  String label;
  double amount;
  double percentageOftotalWeek;

  ChartBar(this.label, this.amount, this.percentageOftotalWeek);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, contstraints) {
        return Column(
          children: [
            Container(
              height: contstraints.maxHeight * 0.15,
              child: FittedBox(
                child: Text("\$" + amount.toStringAsFixed(0)),
              ),
            ),
            SizedBox(height: contstraints.maxHeight * 0.05),
            Container(
              height: contstraints.maxHeight * 0.6,
              width: 20,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      border: Border.all(width: 2),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  FractionallySizedBox(
                    heightFactor: percentageOftotalWeek,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.red,
                        border: Border.all(width: 2),
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: contstraints.maxHeight * 0.05),
            Container(
              height: contstraints.maxHeight * 0.15,
              child: FittedBox(
                child: Text(label),
              ),
            ),
          ],
        );
      },
    );
  }
}
