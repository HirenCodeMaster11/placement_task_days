import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helper/todo.dart';
import '../modal/todo.dart';

class TodoProvider with ChangeNotifier {
  List<TodoModal> todos = [];
  bool isGrid = false;
  bool isDarkTheme = false;
  TodoHelper helper = TodoHelper();

  Future<void> fetchTodos() async {
    List json = await helper.fetchTodo();
    todos = json.map((data) => TodoModal.fromJson(data)).toList();
    notifyListeners();
  }

  Future<void> loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    isGrid = prefs.getBool('isGrid') ?? false;
    isDarkTheme = prefs.getBool('isDarkTheme') ?? false;
    notifyListeners();
  }

  Future<void> toggleView() async {
    isGrid = !isGrid;
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isGrid', isGrid);
    notifyListeners();
  }

  Future<void> toggleTheme() async {
    isDarkTheme = !isDarkTheme;
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDarkTheme', isDarkTheme);
    notifyListeners();
  }

  TodoProvider() {
    loadPreferences();
    fetchTodos();
  }
}