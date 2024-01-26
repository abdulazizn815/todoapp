import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contacts_app/model/contact_model.dart';
import 'package:contacts_app/services/cloud_firestorage_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<QueryDocumentSnapshot<Map<String, dynamic>>> list = [];
  Future<void> getAllData() async {
    list = await CFSService.readAllData(collectionPath: 'Contacts');
  }

  Future<void> create({required Contact contact}) async {
    await CFSService.createCollection(
        collectionPath: 'Contacts', data: contact.toJson());
  }

  @override
  void initState() {
    getAllData().then((value) {
      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('\nContacts'),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {});
              },
              icon: const Icon(
                Icons.refresh,
                size: 24,
                color: Colors.grey,
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, index) => Card(
                  child: ListTile(
                    onLongPress: () async {
                      showDialog(
                          context: context,
                          builder: (contex) {
                            return AlertDialog(
                              content: const Text('Are you sure you want to'),
                              actions: [
                                CupertinoButton(
                                    child: const Text(
                                      'Yes',
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    onPressed: () async {
                                      debugPrint(list[index].id);
                                      await CFSService.delete(
                                          id: list[index].id,
                                          collectionPath: 'Contacts');
                                      getAllData();
                                      setState(() {});
                                      Navigator.pop(context);
                                      // await CFSServise.daleteContact(
                                      //     id: list[index].id,
                                      //     collectionPath: 'Contacts');
                                      // ignore: use_build_context_synchronously
                                      Navigator.pop(context);
                                    }),
                                CupertinoButton(
                                    child: const Text(
                                      'No',
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.green,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    })
                              ],
                            );
                          });
                      debugPrint(list[index].id);

                      getAllData();
                      setState(() {});
                    },
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                'Name : ${list[index].data()['name']}',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.grey.shade800,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Address : ${list[index].data()['address']}',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.grey.shade800,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Company : ${list[index].data()['company']}',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.grey.shade800,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Phone Number :\n${list[index].data()['phoneNumber']}',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.grey.shade800,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              // Text(
                              //   list[index].data()['is'],
                              //   style: TextStyle(
                              //     fontSize: 18,
                              //     color: Colors.grey.shade800,
                              //     fontWeight: FontWeight.bold,
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                      );
                    },
                    leading: CircleAvatar(
                      radius: 20,
                      child: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.call,
                            size: 24,
                            color: Colors.grey.shade700,
                          )),
                    ),
                    title: Text(
                      list[index].data()['name'],
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey.shade800,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      list[index].data()['phoneNumber'],
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                            onPressed: () async {
                              bool a = list[index].data()['isFavorited'];
                              await CFSService.updateLike(
                                  collectionPath: 'Contacts',
                                  docId: list[index].id,
                                  data: !a);
                              await getAllData();
                              setState(() {});
                            },
                            icon: Icon(
                              list[index].data()['isFavorited']
                                  ? Icons.favorite
                                  : Icons.favorite_border_outlined,
                              size: 24,
                              color: list[index].data()['isFavorited']
                                  ? Colors.redAccent
                                  : Colors.grey,
                            )),
                        IconButton(
                            onPressed: () async {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      TextField(
                                        controller: CFSService.editName,
                                        decoration: InputDecoration(
                                            hintText: 'Name:',
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20))),
                                      ),
                                      const SizedBox(height: 8),
                                      TextField(
                                        controller: CFSService.editPhoneNumber,
                                        decoration: InputDecoration(
                                            hintText: 'Phone Number:',
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20))),
                                      ),
                                      const SizedBox(height: 8),
                                      TextField(
                                        controller: CFSService.editAddress,
                                        decoration: InputDecoration(
                                            hintText: 'Address:',
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20))),
                                      ),
                                      const SizedBox(height: 8),
                                      TextField(
                                        controller: CFSService.editCompany,
                                        decoration: InputDecoration(
                                            hintText: 'Company:',
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20))),
                                      ),
                                    ],
                                  ),
                                  actions: [
                                    CupertinoButton(
                                        child: Text(
                                          'Cancel',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey.shade800,
                                          ),
                                        ),
                                        onPressed: () {
                                          Navigator.pop(context);
                                          setState(() {});
                                        }),
                                    CupertinoButton(
                                        child: Text(
                                          'Save',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey.shade800,
                                          ),
                                        ),
                                        onPressed: () async {
                                          // var id = CFSService.id.text;
                                          var name = CFSService.editName.text;
                                          var phoneNumber =
                                              CFSService.editPhoneNumber.text;
                                          var address =
                                              CFSService.editAddress.text;
                                          var company =
                                              CFSService.editCompany.text;
                                          String id = list[index].data()['id'];
                                          if (name.isNotEmpty &&
                                              phoneNumber.isNotEmpty &&
                                              address.isNotEmpty &&
                                              company.isNotEmpty &&
                                              id.isNotEmpty) {
                                            Contact contact = Contact(
                                                name: name,
                                                id: id.toString(),
                                                phoneNumber: phoneNumber,
                                                address: address,
                                                company: company,
                                                isFavorited: list[index].data()[
                                                        'isFavorited'] ??
                                                    false);
                                            Navigator.pop(context);
                                            await CFSService.updateContact(
                                                collectionPath: 'Contacts',
                                                data: contact.toJson(),
                                                docId: list[index].id);

                                            CFSService.editName.clear();
                                            CFSService.editPhoneNumber.clear();
                                            CFSService.editAddress.clear();
                                            CFSService.editCompany.clear();
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                                    content: Text(
                                                        'Something in your eyes!')));
                                          }

                                          setState(() async {
                                            await getAllData();
                                          });
                                        }),
                                  ],
                                ),
                              );
                            },
                            icon: const Icon(
                              Icons.edit,
                              size: 24,
                              color: Colors.grey,
                            )),
                      ],
                    ),
                  ),
                )),
      ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        child: Text(
          'Add',
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade600,
            fontWeight: FontWeight.w400,
          ),
        ),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: CFSService.name,
                    decoration: InputDecoration(
                        hintText: 'Name:',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20))),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: CFSService.phoneNumber,
                    decoration: InputDecoration(
                        hintText: 'Phone Number:',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20))),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: CFSService.address,
                    decoration: InputDecoration(
                        hintText: 'Address:',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20))),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: CFSService.company,
                    decoration: InputDecoration(
                        hintText: 'Company:',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20))),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: CFSService.fav,
                    decoration: InputDecoration(
                        hintText: 'Is your favourite ? (y/n):',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20))),
                  ),
                ],
              ),
              actions: [
                CupertinoButton(
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade800,
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      setState(() {});
                    }),
                CupertinoButton(
                    child: Text(
                      'Save',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade800,
                      ),
                    ),
                    onPressed: () async {
                      // var id = CFSService.id.text;
                      var name = CFSService.name.text;
                      var phoneNumber = CFSService.phoneNumber.text;
                      var address = CFSService.address.text;
                      var company = CFSService.company.text;
                      var fav = CFSService.fav.text;
                      if (name.isNotEmpty &&
                          phoneNumber.isNotEmpty &&
                          address.isNotEmpty &&
                          company.isNotEmpty &&
                          fav.isNotEmpty) {
                        var y = list.last.data()['id'];
                        var x = fav[0];
                        int id = int.tryParse(y) ?? 0;
                        id++;
                        Contact contact = Contact(
                            name: name,
                            id: id.toString(),
                            phoneNumber: phoneNumber,
                            address: address,
                            company: company,
                            isFavorited: x == 'y' || x == 'Y');
                        Navigator.pop(context);

                        await CFSService.createCollection(
                            collectionPath: 'Contacts', data: contact.toJson());

                        CFSService.name.clear();
                        CFSService.phoneNumber.clear();
                        CFSService.address.clear();
                        CFSService.company.clear();
                        CFSService.fav.clear();
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Something in your eyes!')));
                      }

                      setState(() async {
                        await getAllData();
                      });
                    }),
              ],
            ),
          );
        },
      ),
    );
  }
}
