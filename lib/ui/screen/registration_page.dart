import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_to_do_app/ui/cubit/home_page_cubit.dart';
import 'package:flutter_to_do_app/ui/cubit/registration_page_cubit.dart';

class RegistrationPage extends StatelessWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var nameController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text("Create a Todo")),
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
                        .read<RegistrationPageCubit>()
                        .save(nameController.text)
                        .then(
                            (_) => context.read<HomePageCubit>().loadAllData());
                    Navigator.pop(context);
                  },
                  child: const Text("KAYDET")),
            ],
          ),
        ),
      ),
    );
  }
}
