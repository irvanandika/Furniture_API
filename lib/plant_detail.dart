import 'package:flutter/material.dart';
import 'package:sqlite/models/db.dart';
import 'package:sqlite/models/plants.dart';
import 'package:sqlite/plant_cart.dart';

class PlantDetails extends StatefulWidget {
  final Plants plant;
  const PlantDetails({super.key, required this.plant});

  @override
  State<PlantDetails> createState() => _PlantDetailsState();
}

class _PlantDetailsState extends State<PlantDetails> {
  List<Map<String, dynamic>> details = [
    {"icon": Icons.shopping_bag_rounded, "data": "Product", "time": "362"},
    {"icon": Icons.show_chart_sharp, "data": "Rating", "time": "4.9"},
    {"icon": Icons.call, "data": "Contact", "time": "0822xx"},
  ];
  MyDb myDb = MyDb();
  @override
  void initState() {
    myDb.open();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PlantDetailsAppBar(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.plant.plantName,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  "Serenade Furniture \nFind Your Best",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey.shade600,
                  ),
                ),
                Container(
                  height: 200,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          PlantDetails("width", "70 cm"),
                          PlantDetails("Height", "120 cm"),
                          PlantDetails(
                              "Type of Product", widget.plant.plantName),
                        ],
                      ),
                      Container(
                        width: 160,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                          image: AssetImage("assets/${widget.plant.image}"),
                          fit: BoxFit.cover,
                        )),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          aboutPlant(),
          Container(
            height: 100,
            color: Colors.white,
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Price : ",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "\RP ${widget.plant.price}",
                      style: const TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 40,
                  width: 150,
                  child: ElevatedButton(
                    onPressed: () async {
                      //Inserting plant data into database
                      await myDb.db!.rawInsert(
                          "INSERT INTO plants (plant, image, price) VALUES(?, ?, ?);",
                          [
                            widget.plant.plantName,
                            widget.plant.image,
                            widget.plant.price,
                          ]);
                      //arahkan ke halaman keranjang
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => const PlantCart()),
                      );

                      //pop up pesan
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        backgroundColor: Colors.orange,
                        content: Text("Add to Chart",
                            style: TextStyle(
                              color: Colors.white,
                            )),
                      ));
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.yellow.shade600,
                    ),
                    child: const Text("Add to Chart"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget aboutPlant() => Container(
        height: 210,
        color: Colors.white,
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "About",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              "Limited items with elegant design, made of strong, premium and durable materials",
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: 13.2,
                color: Colors.grey,
              ),
            ),
            Container(
              height: 60,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: details.length,
                itemBuilder: (context, index) {
                  final detail = details[index];
                  return Padding(
                    padding: const EdgeInsets.only(right: 50),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 15,
                          backgroundColor: Colors.yellow.withOpacity(0.2),
                          child: Icon(
                            detail["icon"],
                            size: 18,
                            color: Colors.yellow.shade600,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              detail["data"],
                              style: const TextStyle(
                                fontSize: 13,
                                color: Colors.grey,
                              ),
                            ),
                            Text(
                              detail["time"],
                              style: const TextStyle(
                                fontSize: 13,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        ),
      );

  Widget PlantDetails(String text, String subText) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text,
            style: const TextStyle(
              color: Colors.grey,
            ),
          ),
          Text(
            subText,
          ),
        ],
      );

  Widget PlantDetailsAppBar() => Padding(
        padding: const EdgeInsets.fromLTRB(15, 15, 0, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(Icons.arrow_back)),
            Container(
                height: 70,
                width: 60,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.horizontal(
                    left: Radius.circular(12),
                  ),
                ),
                child: const Icon(
                  Icons.shopping_cart_outlined,
                  size: 22,
                )),
          ],
        ),
      );
}
