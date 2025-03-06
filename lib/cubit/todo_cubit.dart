import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/cubit/todo_state.dart';
import 'package:todo/helper/db_helper.dart';
import 'package:todo/models/todo_model.dart';

class TodoCubit extends Cubit<TodoState> {
  final DbHelper dbHelper;

  TodoCubit() : dbHelper = DbHelper.getInstance(), super(TodoState(mData: []));

  void getAllTodo() async {
    List<ToDoModel> todos = await dbHelper.fetchAllToDo();
    emit(TodoState(mData: todos));
  }

  void addTodo(ToDoModel newTodo) async {
    bool? check = await dbHelper.addToDo(newToDo: newTodo);
    if (check) {
      List<ToDoModel> todos = await dbHelper.fetchAllToDo();
      emit(TodoState(mData: todos));
    }
  }

  void deleteTodo(int id) async {
    bool check = await dbHelper.deleteToDo(id);
    if (check) {
      List<ToDoModel> todos = await dbHelper.fetchAllToDo();
      emit(TodoState(mData: todos));
    }
  }

  void completed({ required int id ,required bool value}) async {
    bool check = await dbHelper.completedTask(id , value);
    if (check) {
      List<ToDoModel> todos = await dbHelper.fetchAllToDo();
      emit(TodoState(mData: todos));
    }
  }
}
