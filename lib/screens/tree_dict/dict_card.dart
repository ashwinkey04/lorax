import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class DictCard extends StatelessWidget {
  final String imageURL;
  final String commonName;
  final String scientificName;
  final String genus;
  final String family;

  DictCard(this.scientificName,this.commonName,this.imageURL, this.genus, this.family);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
      height: 200,
      width: double.maxFinite,
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15))),
        elevation: 10,
        child: Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width/3,
              child: Image(
                image: imageURL != null ? NetworkImage(imageURL) : new AssetImage('assets/images/tree1.png'),
                fit: BoxFit.fill,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    commonName != null ? commonName : "",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontFamily: "Poppins",
                    ),
                  ),
                  Text(
                    scientificName != null ? scientificName : "",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black54,
                      fontFamily: "Poppins",
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Genus: $genus",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black54,
                      fontFamily: "Poppins",
                    ),
                  ),
                  Text(
                    "Family: $family",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black54,
                      fontFamily: "Poppins",
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
