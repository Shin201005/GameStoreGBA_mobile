import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/game_model.dart';

class GameService {
  Future<List<GameModel>> getGames() async {
    final jsonString = await rootBundle.loadString('assets/data/games.json');
    final List data = jsonDecode(jsonString);

    return data.map((item) => GameModel.fromJson(item)).toList();
  }
}
