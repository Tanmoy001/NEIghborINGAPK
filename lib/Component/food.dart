import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:neighbouring/service/food_api.dart';
import 'package:neighbouring/model/food_model.dart';

class Food extends StatefulWidget {
  String? lat;
  String? long;
  Food({super.key, required this.lat, required this.long});

  @override
  State<Food> createState() => _FoodState();
}

class _FoodState extends State<Food> {
  int selectedRating = 0; // Default rating
  List<foodModel> foodlist = [];

  List<foodModel> fivestarFoodList = [];

  bool _loading = true;

  void getfooddData() async {
    Foodapi newclass = Foodapi();
    await newclass.getFoodDataList(widget.lat, widget.long);
    setState(() {
      _loading = false;
    });
    foodlist = newclass.list;
    setState(() {
      fivestarFoodList = foodlist.where((food) {
        if (food.rating != null) {
          double? rating = double.tryParse(food.rating!);
          return rating != null && rating > 4.0;
        }
        return false;
      }).toList();
//debugPrint(fivestarFoodList.toString());
    });
    debugPrint(foodlist[0].cuisine?[0]["name"].toString());
  }

  void filterFoodByRating(int value) {
    setState(() {
      debugPrint(value.toString());
      foodlist = foodlist.where((food) {
        if (food.rating != null) {
          double? rating = double.tryParse(food.rating!);
          return rating != null && rating > value.toDouble();
        }
        return false;
      }).toList();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getfooddData();
  }

  Widget buildImage(String image, int index, String title, String location,
          String rating, String ranking) =>
      GestureDetector(
        onTap: () {
          // Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewArtical(url: url, name: name)));
        },
        child: Stack(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(11),
                child: CachedNetworkImage(
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Image.network(
                    "https://images.unsplash.com/photo-1600891964599-f61ba0e24092?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2070&q=80", // Replace with your default image asset path
                    height: 150,
                    width: 150,
                    fit: BoxFit.cover,
                  ),
                  imageUrl: image,
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                )),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(11),
                  gradient: const LinearGradient(
                      begin: Alignment.centerRight,
                      end: Alignment.centerLeft,
                      colors: [
                        Color.fromRGBO(0, 0, 0, 0.9),
                        Color.fromRGBO(0, 0, 0, 0.05),
                      ])),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 90, right: 10),
                    child: Text(
                      title,
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 15),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 90, right: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.location_on, color: Colors.white),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 2,
                          child: Text(
                            location,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w300,
                                fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 92, right: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.star,
                          color: Colors.yellow,
                          size: 13,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 2,
                          child: Text(
                            rating,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w300,
                                fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 92, right: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // const Icon(Icons.star,color: Colors.yellow,size: 13,),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 2,
                          child: Text(
                            "Ranking : $ranking",
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w300,
                                fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade800,
        title: const Center(child: Text("foods")),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16.0),
                child: Card(
                  elevation: 4.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        const Text("Foods around you"),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const Text(
                              'Select a Rating',
                              style: TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 16.0),
                            DropdownButton<int>(
                              borderRadius: BorderRadius.circular(10),
                              padding: const EdgeInsets.symmetric(horizontal: 7),
                              value: selectedRating,
                              onChanged: (value) {
                                setState(() {
                                  selectedRating = value!;
                                  filterFoodByRating(selectedRating);
                                });
                              },
                              items: const <DropdownMenuItem<int>>[
                                DropdownMenuItem<int>(
                                  value: 0,
                                  child: Text('All'),
                                ),
                                DropdownMenuItem<int>(
                                  value: 2,
                                  child: Text('Above 2.0'),
                                ),
                                DropdownMenuItem<int>(
                                  value: 3,
                                  child: Text('Above 3.0'),
                                ),
                                DropdownMenuItem<int>(
                                  value: 4,
                                  child: Text('Above 4.0'),
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
              const SizedBox(
                height: 10,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        DefaultTextStyle(
                          style: const TextStyle(
                            fontSize:
                                21.0, // You can adjust the font size as needed
                            fontWeight: FontWeight.w800,

                            color: Color(0xFFF114b5f),
                            // fontFamily: 'Horizon',
                          ),
                          child: AnimatedTextKit(
                            animatedTexts: [
                              TypewriterAnimatedText(
                                  '5 Star Restaurant Around You ...'),
                              TypewriterAnimatedText(
                                  '৫ Star Restaurant Around You ...'),
                              TypewriterAnimatedText(
                                  '५ Star Restaurant Around You ...'),
                            ],
                            repeatForever: true,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              _loading
                  ? const SizedBox(
                      height: 200,
                      child: Center(child: CircularProgressIndicator()))
                  : CarouselSlider.builder(
                      itemCount: 6,
                      itemBuilder:
                          (BuildContext context, int index, int realIndex) {
                        String? res = fivestarFoodList[index].photo;
                        String? res1 = fivestarFoodList[index].name;
                        String? res2 =
                            fivestarFoodList[index].location.toString();
                        String? res3 = fivestarFoodList[index].rating;
                        String? res4 = fivestarFoodList[index].ranking;

                        return buildImage(
                            res!, index, res1!, res2, res3!, res4!);
                      },
                      options: CarouselOptions(
                          height: 200,
                          //viewportFraction: 1,
                          enlargeCenterPage: true,
                          autoPlay: true),
                    ),
              const SizedBox(
                height: 7,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,

                  children: [
                    DefaultTextStyle(
                      style: const TextStyle(
                        fontSize: 21.0, // You can adjust the font size as needed
                        fontWeight: FontWeight.w800,

                        color: Color(0xFFF114b5f),
                        // fontFamily: 'Horizon',
                      ),
                      child: AnimatedTextKit(
                        animatedTexts: [
                          TypewriterAnimatedText('Restaurant Around You ...'),
                        ],
                        repeatForever: true,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              _loading
                  ? const CircularProgressIndicator()
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      itemCount: 11,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          child: CardTitle(
                            name: foodlist[index].name.toString(),
                            url:
                                "https://www.ingentaconnect.com/images/journal-logos/smart/ajec.png",
                            location: foodlist[index].location.toString(),
                            cuisine: foodlist[index].cuisine ?? [],
                            // cuisine: foodlist[index].cuisine,
                            ranking:
                                foodlist[index].ranking ?? "Not Available",
                            rating:
                                foodlist[index].rating ?? "Not Available",
                            imageUrl: foodlist[index].photo ??
                                "https://images.unsplash.com/photo-1600891964599-f61ba0e24092?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2070&q=80",
                            // imageUrl: "https://www.ingentaconnect.com/images/journal-logos/smart/ajec.png"
                          ),
                        );
                      })
            ],
          ),
        ),
      ),
    );
  }
}

class CardTitle extends StatelessWidget {
  String imageUrl, location, url, name, ranking, rating;
  List cuisine;

  CardTitle({
    super.key,
    required this.name,
    required this.url,
    required this.location,
    required this.ranking,
    required this.imageUrl,
    required this.cuisine,
    required this.rating,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewArtical(url: url, name: name)));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 11),
        child: Material(
          elevation: 3.0,
          borderRadius: BorderRadius.circular(11),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(11),
                    child: CachedNetworkImage(
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Image.network(
                        'https://images.unsplash.com/photo-1600891964599-f61ba0e24092?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2070&q=80', // Replace with your default image asset path
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
                  padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                  width: MediaQuery.of(context).size.width / 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          name,
                          maxLines: 2,
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 16),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.location_on, color: Colors.blue),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 2.3,
                            child: Text(
                              location,
                              style: const TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w300,
                                  fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: cuisine
                              .map(
                                (cuisineItem) => Container(
                                  // color: Colors.black,
                                  padding:
                                      const EdgeInsets.only(right: 8.0),
                                  child: Material(
                                    elevation: 3.0,
                                    color: const Color(0xFFADD8E6),
                                    borderRadius: BorderRadius.circular(10),
                                    child: Container(
                                        // color: Colors.black,
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 2, horizontal: 10),
                                        child: Text(cuisineItem["name"]
                                            .toString())),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                        child: Text(
                          "Ranking : $ranking",
                          maxLines: 2,
                          style: const TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.w300,
                              fontSize: 13),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            color: Colors.redAccent,
                            size: 15,
                          ),
                          const SizedBox(
                            width: 9,
                          ),
                          const Text("Rating",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13)),
                          const SizedBox(
                            width: 9,
                          ),
                          Text(
                            rating,
                            style: const TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.w300,
                                fontSize: 13),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
