import 'package:flutter/material.dart';
import 'package:sqlite/home_page.dart';
import 'package:sqlite/models/db.dart';

class PlantCart extends StatefulWidget {
  const PlantCart({super.key});

  @override
  State<PlantCart> createState() => _PlantCartState();
}

class _PlantCartState extends State<PlantCart> {
  MyDb myDb = MyDb();
  List<Map> plantsList = [];
  @override
  void initState() {
    super.initState();

    myDb.open();
    getPlantData();
  }

  void getPlantData() {
    Future.delayed(const Duration(milliseconds: 1000), () async {
      //select all data from database
      plantsList = await myDb.db!.rawQuery("SELECT * FROM plants");
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget build(BuildContext context) {
    //find total dari harga tanaman
    num total = plantsList.fold(0, (prev, value) => prev + value["price"]);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () {
            //arah kembali ke halaman beranda
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
          },
          child: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        elevation: 0.0,
        title: const Text(
          "My Chart",
        ),
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 17,
          fontWeight: FontWeight.bold,
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          plantsCartContainer(),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total",
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "\Rp $total",
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 30,
                      width: 145,
                      decoration: BoxDecoration(
                        border:
                            Border.all(width: 2, color: Colors.yellow.shade600),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: OutlinedButton(
                        onPressed: () {},
                        child: Text(
                          "Add More",
                          style: TextStyle(
                            color: Colors.yellow.shade600,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 30,
                      width: 145,
                      decoration: BoxDecoration(
                        color: Colors.yellow.shade600,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: OutlinedButton(
                        onPressed: () {},
                        child: const Text(
                          "CheckOut",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget plantsCartContainer() => Container(
        height: 450,
        color: Colors.grey.shade100,
        child: ListView(
          children: plantsList.map((plant) {
            return Container(
              height: 110,
              margin: const EdgeInsets.fromLTRB(20, 15, 20, 0),
              padding: const EdgeInsets.all(12),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      imageWidget(plant),
                      const SizedBox(
                        width: 12,
                      ),
                      cartDetails(plant),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                          onTap: () async {
                            //Hapus data tanaman dari database
                            await myDb.db!.rawDelete(
                                "DELETE FROM plants Where id = ?",
                                [plant["id"]]);
                            //popup message
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              backgroundColor: Colors.orange,
                              content: Text(
                                "Item Dihapus",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ));
                            getPlantData();
                          },
                          child: Icon(Icons.delete_outline,
                              color: Colors.grey.shade400)),
                      Text(
                        "\Rp ${plant["price"]}",
                        style: TextStyle(
                          color: Colors.yellow.shade600,
                          fontSize: 15,
                        ),
                      )
                    ],
                  )
                ],
              ),
            );
          }).toList(),
        ),
      );

  Widget cartDetails(Map<dynamic, dynamic> plant) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              plant["plant"],
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Text(
              "On Delivery",
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ],
        ),
        Row(
          children: [
            Container(
              height: 20,
              width: 20,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(width: 2, color: Colors.grey.shade400),
              ),
              child: Icon(Icons.remove, color: Colors.grey.shade400, size: 15),
            ),
            const SizedBox(
              width: 10,
            ),
            const Text(
              "1",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Container(
              height: 20,
              width: 20,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(width: 2, color: Colors.grey.shade400),
              ),
              child: Icon(Icons.add, color: Colors.grey.shade400, size: 15),
            ),
          ],
        ),
      ],
    );
  }

  Widget imageWidget(Map<dynamic, dynamic> plant) {
    return Container(
      height: 100,
      width: 80,
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Stack(
        children: [
          Container(
            height: 65,
            decoration: BoxDecoration(
                border: Border.all(width: 2, color: Colors.grey.shade400)),
          ),
          Positioned(
            bottom: 5,
            left: 7,
            child: Container(
              height: 80,
              width: 70,
              decoration: BoxDecoration(
                //color: Colors.yellow,
                image: DecorationImage(
                  image: AssetImage(
                    "assets/${plant["image"]}",
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
