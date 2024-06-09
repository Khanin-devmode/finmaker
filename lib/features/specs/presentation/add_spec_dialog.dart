import 'package:flutter/material.dart';

Future<void> newSpecDialog(BuildContext context) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AddSpecDialog();
    },
  );
}

class AddSpecDialog extends StatelessWidget {
  AddSpecDialog({
    super.key,
  });

  final _formKey = GlobalKey<FormState>();
  final currentYear = DateTime.now().year + 543;

  @override
  Widget build(
    BuildContext context,
  ) {
    return const AlertDialog(
      content: DefaultTabController(
        length: 3,
        child: SizedBox(
          width: 400,
          height: 600,
          child: Column(
            children: [
              TabBar(tabs: [
                Tab(
                  text: 'one-time',
                ),
                Tab(
                  text: 'period',
                ),
                Tab(
                  text: 'custom',
                )
              ]),
              Expanded(
                child: TabBarView(children: [
                  Center(
                    child: Text('One-time'),
                  ),
                  Center(
                    child: Text('period'),
                  ),
                  Center(
                    child: Text('custom'),
                  ),
                ]),
              )
            ],
          ),
        ),
      ),
      //tabbarview
      //- tab1
      //-- form
      //-- contract period
      //-- amount
      //-- isExense
    );
  }
}
