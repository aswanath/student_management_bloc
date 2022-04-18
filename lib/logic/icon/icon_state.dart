part of 'icon_cubit.dart';

@immutable
abstract class IconState extends Equatable{

}

class IconInitial extends IconState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ChangeIconState extends IconState{
  final IconData iconData;
  ChangeIconState({required this.iconData});
  // TODO: implement props
  @override
  List<Object> get props => [iconData];
}