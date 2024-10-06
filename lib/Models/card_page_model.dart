import 'dart:core';

class CardModel{
  final int pid;
  final String title;
  final int review;
  final String imgUrl;
  final double price;
  final String shortDescription;
  final String longDescription;
  final double rating;
  bool isSelected;
  int qty;

  CardModel({
    required this.pid,
    required this.title,
    required this.review,
    required this.imgUrl,
    required this.price,
    required this.rating,
    required this.shortDescription,
    required this.longDescription,
    this.qty = 1,
    this.isSelected = false});
}