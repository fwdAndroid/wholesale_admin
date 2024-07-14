import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wholesale_admin/screen/drawer_pages/promotions/add_promotions.dart';
import 'package:wholesale_admin/utils/colors.dart';

class Promostions extends StatefulWidget {
  const Promostions({super.key});

  @override
  State<Promostions> createState() => _PromostionsState();
}

class _PromostionsState extends State<Promostions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: colorWhite),
          centerTitle: true,
          title: Text(
            "Promotions",
            style: TextStyle(color: colorWhite),
          ),
          backgroundColor: primary,
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: primary,
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (builder) => AddPromotionImages()));
          },
          child: Icon(
            Icons.add,
            color: colorWhite,
          ),
        ),
        body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("promotionsImages")
                    .snapshots(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData || snapshot.data == null) {
                    return Center(child: Text('No Promotion Avaialble'));
                  }
                  return StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("promotionsImages")
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (snapshot.data!.docs.isEmpty) {
                          return Center(
                            child: Text(
                              "No Promotion Available",
                              style: TextStyle(color: black),
                            ),
                          );
                        }
                        return ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              final List<DocumentSnapshot> documents =
                                  snapshot.data!.docs;
                              final Map<String, dynamic> data = documents[index]
                                  .data() as Map<String, dynamic>;
                              return Column(
                                children: [
                                  Card(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Image.network(
                                          data['image'],
                                          height: 200,
                                          fit: BoxFit.cover,
                                          width:
                                              MediaQuery.of(context).size.width,
                                        ),
                                        TextButton(
                                            onPressed: () {
                                              showDialog<void>(
                                                context: context,
                                                barrierDismissible:
                                                    false, // user must tap button!
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    title: const Text(
                                                        'Delete Alert'),
                                                    content:
                                                        const SingleChildScrollView(
                                                      child: ListBody(
                                                        children: <Widget>[
                                                          Text(
                                                              'Do you want to delete the image'),
                                                        ],
                                                      ),
                                                    ),
                                                    actions: <Widget>[
                                                      TextButton(
                                                        child: const Text(
                                                            'Approve'),
                                                        onPressed: () async {
                                                          await FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  "promotionsImages")
                                                              .doc(data['uuid'])
                                                              .delete();
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                      ),
                                                      TextButton(
                                                        child: const Text('No'),
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                            },
                                            child: Text("Delete"))
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            });
                      });
                })));
  }
}
