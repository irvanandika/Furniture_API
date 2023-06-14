import 'package:flutter/material.dart';
import 'package:sqlite/models/plants.dart';
import 'package:sqlite/plant_detail.dart';

class PlantGarden extends StatefulWidget {
  const PlantGarden({super.key});

  @override
  State<PlantGarden> createState() => _PlantGardenState();
}

class _PlantGardenState extends State<PlantGarden>
    with TickerProviderStateMixin {
  late final TabController _tabController = TabController(
    length: 6,
    vsync: this,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: const Text(
          "Home",
        ),
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 17,
          fontWeight: FontWeight.w600,
        ),
        centerTitle: true,
        bottom: TabBar(
          isScrollable: true,
          labelColor: Colors.yellow.shade600,
          unselectedLabelColor: Colors.black54,
          controller: _tabController,
          tabs: const [
            Tab(
              text: "All",
            ),
            Tab(
              text: "Chair",
            ),
            Tab(
              text: "Sofa",
            ),
            Tab(
              text: "Lamp",
            ),
            Tab(
              text: "Kitchen",
            ),
            Tab(
              text: "Bed",
            ),
            Tab(
              text: "Table",
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          allPlantsLists(),
          const Text("Chair"),
          const Text("Sofa"),
          const Text("Lamp"),
          const Text("Kitchen"),
          const Text("Bed"),
          const Text("Table")
        ],
      ),
    );
  }
}

List<Plants> plants = plantsList;

Widget allPlantsLists() => ListView(
      children: [
        Container(
          height: 700,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 15,
              crossAxisSpacing: 15,
              childAspectRatio: 6 / 8,
            ),
            itemCount: plants.length,
            itemBuilder: (context, index) {
              final plant = plants[index];
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => PlantDetails(plant: plant),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: plant.lightColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Stack(
                    children: [
                      Container(
                        height: 130,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(8),
                          ),
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              plant.lightColor,
                              plant.darkColor,
                            ],
                          ),
                        ),
                        child: Column(
                          children: [
                            Text(
                              plant.plantName.toUpperCase(),
                              style: TextStyle(
                                color: plant.darkColor,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              plant.plant.toUpperCase(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 11.8,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: 25,
                        left: 32,
                        child: Container(
                          height: 150,
                          width: 110,
                          decoration: BoxDecoration(
                            //color: Colors.yellow,
                            image: DecorationImage(
                                image: AssetImage(
                                  "assets/${plant.image}",
                                ),
                                fit: BoxFit.cover),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
