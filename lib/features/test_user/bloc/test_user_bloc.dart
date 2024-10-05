import 'package:bloc/bloc.dart';

part 'test_user_event.dart';
part 'test_user_state.dart';

class TestUserBloc extends Bloc<TestUserEvent, TestUserState> {
  TestUserBloc() : super(TestUserInitial()) {
    on<TestUserEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
