import 'package:flutter/material.dart';

Future<void> bottomSheet(context) async {
  showModalBottomSheet(
      isScrollControlled: true,
      isDismissible: true,
      enableDrag: false,
     
      context: context,
      builder: (ctx) {
        return Container(
          
          width: double.infinity,
          height: MediaQuery.of(context).size.height / 2,
          color: const Color.fromARGB(255, 216, 213, 213),
          child: ListView.separated(
            // controller: ScrollController(keepScrollOffset: true),
            // shrinkWrap: true,
            itemBuilder: (context, index) {
              return const ListTile(
                title: Text('songs'),
              );
            },
            separatorBuilder: (context, index) => Divider(),
            itemCount: 10,
          ),
        );
      });
}
