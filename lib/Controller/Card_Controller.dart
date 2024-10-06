import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/Data/Card.dart';
import 'package:myapp/Models/card_page_model.dart';

class CardNotifier extends StateNotifier<List<CardModel>>{
  CardNotifier() : super(CardItems);
}

final cardNotifierProvider = StateNotifierProvider<CardNotifier, List<CardModel>>((ref){
  return CardNotifier();
});