import 'package:flutter/material.dart';

class Plants {
  final String image, plantName, plant;
  final Color lightColor, darkColor;
  final double price;

  const Plants({
    required this.image,
    required this.plant,
    required this.plantName,
    required this.lightColor,
    required this.darkColor,
    required this.price,
  });
}

final plantsList = [
  Plants(
    image: "chair.jpeg",
    plant: "Gaming",
    plantName: "Chair",
    lightColor: Colors.grey.shade400,
    darkColor: Colors.black,
    price: 550.247,
  ),
  Plants(
    image: "sofa.jpeg",
    plant: "Richmond",
    plantName: "Sofa",
    lightColor: Colors.grey.shade400,
    darkColor: Colors.black,
    price: 150.756,
  ),
  Plants(
    image: "lamp.jpeg",
    plant: "Pata de Elefante",
    plantName: "Table Lamp",
    lightColor: Colors.grey.shade400,
    darkColor: Colors.black,
    price: 85.294,
  ),
  Plants(
    image: "kitchen.jpeg",
    plant: "Modern Farmhouse",
    plantName: "Kitchen",
    lightColor: Colors.grey.shade400,
    darkColor: Colors.black,
    price: 135.957,
  ),
  Plants(
    image: "bed.jpeg",
    plant: "Super King",
    plantName: "Bed",
    lightColor: Colors.grey.shade400,
    darkColor: Colors.black,
    price: 50.596,
  ),
  Plants(
    image: "table.jpeg",
    plant: "Frato",
    plantName: "Chair",
    lightColor: Colors.grey.shade400,
    darkColor: Colors.black,
    price: 45.877,
  ),
];
