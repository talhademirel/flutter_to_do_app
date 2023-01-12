import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_to_do_app/data/entity/toDos.dart';
import 'package:flutter_to_do_app/ui/cubit/detail_page_cubit.dart';

class DetailPage extends StatelessWidget {
  final ToDos todo;
  const DetailPage({Key? key, required this.todo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var nameController = TextEditingController(text: todo.name);

    return Scaffold(
      appBar: AppBar(title: const Text("Todo Details")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 50, right: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(hintText: "Todo Name"),
              ),
              ElevatedButton(
                  onPressed: () {
                    context
                        .read<DetailPageCubit>()
                        .update(todo.id, nameController.text);
                    Navigator.pop(context);
                  },
                  child: const Text("UPDATE")),
            ],
          ),
        ),
      ),
    );
  }
}
