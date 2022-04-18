import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'icon_state.dart';

class IconCubit extends Cubit<IconState> {
  IconCubit() : super(ChangeIconState(iconData: Icons.search));

  void changeICon(IconData iconData){
    if(iconData == Icons.search){
      emit(ChangeIconState(iconData: Icons.close));
    }else{
      emit(ChangeIconState(iconData: Icons.search));
    }
  }
}
