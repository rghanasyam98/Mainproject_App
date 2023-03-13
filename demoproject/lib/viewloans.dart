import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Viewloans extends StatelessWidget {
  const Viewloans(Type buildContext, BuildContext context, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text("Loan1"),
            subtitle: Text("Description1"),
          );
        }, separatorBuilder: (BuildContext context, int index) => Divider(),
         itemCount: 5
    );
  }
}