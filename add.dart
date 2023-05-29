import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class AddUser extends StatefulWidget {
  const AddUser({super.key});

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  final CollectionReference donar =
      FirebaseFirestore.instance.collection('donor');
  TextEditingController donarName = TextEditingController();
  TextEditingController donarPhone = TextEditingController();
  final bloodGroups = ['A+', 'A', "B-", 'B+', 'o-', 'A-', 'AB+'];
  String? selectedGroup;
  void addDonar() {
    final data = {
      'name': donarName.text,
      'phone': donarPhone.text,
      'group': selectedGroup,
    };
    donar.add(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Add donars"),
          backgroundColor: Colors.red,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: donarName,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text("donor name"),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: donarPhone,
                  keyboardType: TextInputType.number,
                  maxLength: 10,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text("phone numner"),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButtonFormField(
                  decoration:
                      InputDecoration(label: Text('select blood group')),
                  items: bloodGroups
                      .map((e) => DropdownMenuItem(
                            child: Text(e),
                            value: e,
                          ))
                      .toList(),
                  onChanged: (val) {
                    selectedGroup = val as String;
                  },
                ),
              ),
              ElevatedButton(
                  style: ButtonStyle(
                      minimumSize:
                          MaterialStateProperty.all(Size(double.infinity, 50)),
                      backgroundColor: MaterialStateProperty.all(Colors.amber)),
                  onPressed: () {
                    addDonar();
                    Navigator.pop(context);
                  },
                  child: Text(
                    'submit',
                    style: TextStyle(fontSize: 20),
                  ))
            ],
          ),
        ));
  }
}
