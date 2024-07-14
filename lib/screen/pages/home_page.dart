import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wholesale_admin/screen/drawer_pages/brands/brand_detail.dart';
import 'package:wholesale_admin/utils/colors.dart';
import 'package:wholesale_admin/widgets/my_drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> imageUrls = [];
  @override
  void initState() {
    super.initState();
    loadImages();
  }

  Future<void> loadImages() async {
    List<String> urls = await fetchImageUrls();
    setState(() {
      imageUrls = urls;
    });
  }

  Future<List<String>> fetchImageUrls() async {
    List<String> imageUrls = [];
    await FirebaseFirestore.instance
        .collection('promotionsImages')
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        imageUrls.add(doc['image']);
      });
    });
    return imageUrls;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: MyDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          imageUrls.isEmpty
              ? Center(child: CircularProgressIndicator())
              : CarouselSlider(
                  options: CarouselOptions(height: 200.0, autoPlay: true),
                  items: imageUrls.map((url) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.network(
                            url,
                            fit: BoxFit.cover,
                            height: 200,
                            width: MediaQuery.of(context).size.width,
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Brands",
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 20, color: black),
            ),
          ),
          SizedBox(
            height: 72,
            width: MediaQuery.of(context).size.width,
            child: StreamBuilder(
                stream:
                    FirebaseFirestore.instance.collection("brands").snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.data!.docs.isEmpty) {
                    return Center(
                      child: Text(
                        "No Brands Available",
                        style: TextStyle(color: black),
                      ),
                    );
                  }
                  return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        final List<DocumentSnapshot> documents =
                            snapshot.data!.docs;
                        final Map<String, dynamic> data =
                            documents[index].data() as Map<String, dynamic>;
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (builder) => BrandDetail(
                                          serviceImage: data['image'],
                                          providerName: data['brandName'],
                                          uuid: data['uuid'],
                                        )));
                          },
                          child: SizedBox(
                            height: 72,
                            width: 72,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                radius: 72,
                                backgroundImage: NetworkImage(
                                  data['image'],
                                ),
                              ),
                            ),
                          ),
                        );
                      });
                }),
          ),
        ],
      ),
    );
  }
}
