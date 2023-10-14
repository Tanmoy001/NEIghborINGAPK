import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
class Places extends StatefulWidget {
  const Places({super.key});

  @override
  State<Places> createState() => _PlacesState();
}

class _PlacesState extends State<Places> {

  int selectedRating = 3; // Default rating
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade800,
        title: Center(child: Text("Places")),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(16.0),
                child: Card(
                  elevation: 4.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(8.0),

                    child: Column(
                      children: [
                        Text("Places around you"),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Select a Rating',
                              style: TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 16.0),
                            DropdownButton<int>(

                              borderRadius: BorderRadius.circular(10),
                              padding: EdgeInsets.symmetric(horizontal: 10),

                              value: selectedRating,
                              onChanged: (value) {
                                setState(() {
                                  selectedRating = value!;
                                });
                              },
                              items: <DropdownMenuItem<int>>[
                                DropdownMenuItem<int>(
                                  value: 2,
                                  child: Text('2'),
                                ),
                                DropdownMenuItem<int>(
                                  value: 3,
                                  child: Text('3'),
                                ),
                                DropdownMenuItem<int>(
                                  value: 4,
                                  child: Text('4'),
                                ),
                                DropdownMenuItem<int>(
                                  value: 5,
                                  child: Text('5'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                child: ListView.builder(
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemCount: 11,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(

                        margin: EdgeInsets.symmetric(vertical: 10),
                        child: CardTitle(
                            name: "adfsdf",
                            url:"https://www.ingentaconnect.com/images/journal-logos/smart/ajec.png",
                            title: "sdfsdf",
                            desc: "safdsf",
                            imageUrl: "https://www.ingentaconnect.com/images/journal-logos/smart/ajec.png"
                        ),
                      );
                    }),

              )
            ],
          ),

        ),
      ),
    );
  }
}


class CardTitle extends StatelessWidget {
  String imageUrl, title, desc,url,name;

  CardTitle(
      {super.key,
        required this.name,
        required this.url,
        required this.title,
        required this.desc,
        required this.imageUrl});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewArtical(url: url, name: name)));
      },
      child: Container(
        padding:const EdgeInsets.symmetric(horizontal: 11),
        child: Material(
          elevation: 3.0,
          borderRadius: BorderRadius.circular(11),
          child: Padding(
            padding:const EdgeInsets.symmetric(horizontal: 2),
            child: Container(
              color: Colors.white,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(11),

                      child: CachedNetworkImage(
                        placeholder: (context, url) => CircularProgressIndicator(),
                        errorWidget: (context, url, error) => Image.network(
                          'images/news.jpg', // Replace with your default image asset path
                          height: 150,
                          width: 150,
                          fit: BoxFit.cover,
                        ),
                        imageUrl: imageUrl,
                        height: 150,
                        width: 150,
                        fit: BoxFit.cover,
                      )),
                  const SizedBox(
                    // height: 10,
                    width: 10,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 2,
                    child: Column(
                      children: [
                        Text(
                          title,
                          maxLines: 2,
                          style:const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 16),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "$desc...",
                          style:const TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.w300,
                              fontSize: 14),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

