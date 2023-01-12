import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_to_do_app/data/repo/toDos_repository.dart';

class RegistrationPageCubit extends Cubit<void> {
  RegistrationPageCubit():super(0);

  var tRepo = ToDosRepository();

  Future<void> save(String name) async {
    await tRepo.save(name);
  }

}