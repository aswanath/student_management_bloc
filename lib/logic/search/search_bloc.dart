import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:student_management/student_database.dart';

import '../../model/student.dart';

part 'search_event.dart';

part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc()
      : super(SearchResult(studentList: StudentDatabase().getStudentList())) {
    on<SearchEvent>((event, emit) {
      if (event is EnterInput) {
        List<Student> data = StudentDatabase()
            .getStudentList()
            .where((element) => element.name
                .toLowerCase()
                .contains(event.searchInput.toLowerCase()))
            .toList();
        if (data.isEmpty) {
          emit(NoSearchResult());
        } else {
          emit(SearchResult(studentList: data));
        }
      }
      if (event is ClearInput) {
        emit(SearchResult(studentList: StudentDatabase().getStudentList()));
      }
    });
  }
}
