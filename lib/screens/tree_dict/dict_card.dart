import 'package:flutter/material.dart';

class DictCard extends StatelessWidget {
  final String imageURL;
  final String commonName ;
  final String scientificName ;

  DictCard(this.scientificName,this.commonName,this.imageURL);

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
                image: NetworkImage(imageURL),
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
                    commonName,
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.black,
                      fontFamily: "Poppins",
                    ),
                  ),
                  Text(
                    scientificName,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 15,
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
