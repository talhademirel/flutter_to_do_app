import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_to_do_app/data/repo/toDos_repository.dart';

class DetailPageCubit extends Cubit<void> {
  DetailPageCubit():super(0);

  var tRepo = ToDosRepository();

  Future<void> update(int id, String name) async {
    await tRepo.update(id, name);
  }
}