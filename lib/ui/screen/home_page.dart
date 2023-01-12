import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_to_do_app/data/entity/toDos.dart';
import 'package:flutter_to_do_app/ui/cubit/home_page_cubit.dart';
import 'package:flutter_to_do_app/ui/screen/detail_page.dart';
import 'package:flutter_to_do_app/ui/screen/registration_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<HomePageCubit>().loadAllData();
  }

  bool isSearching = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: isSearching
            ? TextField(
                decoration: const InputDecoration(hintText: "Search"),
                onChanged: (searchResult) {
                  context.read<HomePageCubit>().search(searchResult);
                  print("Search ToDo : $searchResult");
                },
              )
            : const Text("ToDo List"),
        actions: [
          isSearching
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      isSearching = false;
                    });
                    context.read<HomePageCubit>().loadAllData();
                  },
                  icon: const Icon(Icons.clear))
              : IconButton(
                  onPressed: () {
                    setState(() {
                      isSearching = true;
                    });
                  },
                  icon: const Icon(Icons.search)),
        ],
      ),
      body: BlocBuilder<HomePageCubit,List<ToDos>>(
          builder: (context, toDoList) {
            if(toDoList.isNotEmpty){
              return ListView.builder(
                  itemCount: toDoList.length,
                  itemBuilder: (context, i) {
                    return GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  DetailPage(todo: toDoList[i])))
                          .then((_) => context.read<HomePageCubit>().loadAllData()),
                      child: Card(
                        child: ListTile(
                          leading: Text(
                            toDoList[i].id.toString(),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          title: Text(toDoList[i].name),
                          trailing: IconButton(
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("Delete ${toDoList[i].name}?"),
                                    action: SnackBarAction(
                                      label: "Yes",
                                      onPressed: () {
                                        print("Delete ToDo : ${toDoList[i].name}");
                                        context
                                            .read<HomePageCubit>()
                                            .delete(toDoList[i].id);
                                      },
                                    ),
                                  ),
                                );
                              },
                              icon: const Icon(
                                Icons.delete_outline_rounded,
                              )),
                        ),
                      ),
                    );
                  });
            } else {
              return const Center();
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const RegistrationPage()))
              .then((_) => context.read<HomePageCubit>().loadAllData());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
