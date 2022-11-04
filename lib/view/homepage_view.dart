import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:local_database_hive/model/contact.dart';

import 'new_contact_form.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({super.key});

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Hive Tutorial'),
        ),
        body: Column(
          children: <Widget>[
            Expanded(child: _buildListView()),
            NewContactForm(),
          ],
        ));
  }

  Widget _buildListView() {
    return StreamBuilder(
      stream: Hive.box('contacts').watch(),
      builder: (context, snapshot) {
        final conatctBox = Hive.box('contacts');
        return ListView.builder(
            itemCount: conatctBox.length,
            itemBuilder: ((context, index) {
              final contact = conatctBox.getAt(index) as Contact;
              return ListTile(
                title: Text(contact.name),
                subtitle: Text(contact.age.toString()),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                        onPressed: () {
                          conatctBox.putAt(
                              index,
                              Contact(
                                  name: '${contact.name}*',
                                  age: contact.age + 1));
                        },
                        icon: const Icon(Icons.add)),
                    IconButton(
                        onPressed: () {
                          conatctBox.deleteAt(index);
                        },
                        icon: const Icon(Icons.delete)),
                  ],
                ),
              );
            }));
      },
    );
  }
}
