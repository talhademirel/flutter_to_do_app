import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_to_do_app/data/entity/toDos.dart';
import 'package:flutter_to_do_app/data/repo/toDos_repository.dart';

class HomePageCubit extends Cubit<List<ToDos>>{
  HomePageCubit():super(<ToDos>[]);

  var tRepo = ToDosRepository();

  Future<void> loadAllData() async {
    var list = await tRepo.loadAllData();
    emit(list);
  }

  Future<void> search(String query) async {
    var list = await tRepo.search(query);
    emit(list);
  }

  Future<void> delete(int id) async {
    await tRepo.delete(id);
    await loadAllData();
  }


}