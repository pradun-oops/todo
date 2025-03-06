import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/cubit/todo_cubit.dart';
import 'package:todo/helper/db_helper.dart';
import 'package:todo/models/todo_model.dart';
import 'package:todo/widget/custom_text.dart';
import 'package:todo/widget/custom_textfield.dart';

class AddTodo extends StatefulWidget {
  const AddTodo({super.key});

  @override
  State<AddTodo> createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  DbHelper? mdb;

  @override
  void initState() {
    super.initState();
    mdb = DbHelper.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(text: "Add TO DO", size: 25),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Image.asset("assets/logo/check-list.png", width: 350),
              const SizedBox(height: 15),
              CustomTextfield(hint: 'Title', controller: titleController),
              const SizedBox(height: 10),
              CustomTextfield(hint: 'To Do', controller: descriptionController),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: CustomText(text: "Cancel"),
                  ),
                  const SizedBox(width: 10),
                  OutlinedButton(
                    onPressed: () async {
                      if (titleController.text.isNotEmpty &&
                          descriptionController.text.isNotEmpty) {
                        context.read<TodoCubit>().addTodo(
                          ToDoModel(
                            title: titleController.text,
                            description: descriptionController.text,
                            createdAt:
                                DateTime.now().microsecondsSinceEpoch
                                    .toString(),
                            completed: false,
                          ),
                        );
                        Navigator.pop(context);
                      }
                    },
                    child: CustomText(text: "Save"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
