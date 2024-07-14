import 'package:flutter/material.dart';
import 'package:wholesale_admin/screen/drawer_pages/brands/brands.dart';
import 'package:wholesale_admin/screen/drawer_pages/product/products.dart';
import 'package:wholesale_admin/screen/drawer_pages/promotions/promostions.dart';
import 'package:wholesale_admin/utils/colors.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Image.asset(
            "assets/logo.png",
            height: 100,
          ),
          Divider(
            color: primary.withOpacity(.5),
          ),
          ListTile(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (builder) => Promostions()));
            },
            leading: Icon(Icons.bolt),
            title: Text(
              "Promotions",
              style: TextStyle(
                  color: black, fontWeight: FontWeight.w300, fontSize: 12),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: black,
              size: 12,
            ),
          ),
          Divider(
            color: primary.withOpacity(.5),
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (builder) => Brands()));
            },
            leading: Icon(Icons.branding_watermark_sharp),
            title: Text(
              "Brands",
              style: TextStyle(
                  color: black, fontWeight: FontWeight.w300, fontSize: 12),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: black,
              size: 12,
            ),
          ),
          Divider(
            color: primary.withOpacity(.5),
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (builder) => Products()));
            },
            leading: Icon(Icons.insert_drive_file),
            title: Text(
              "Products",
              style: TextStyle(
                  color: black, fontWeight: FontWeight.w300, fontSize: 12),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: black,
              size: 12,
            ),
          )
        ],
      ),
    );
  }
}
