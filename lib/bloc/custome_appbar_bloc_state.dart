part of 'custome_appbar_bloc_bloc.dart';

abstract class CustomeAppbarBlocState extends Equatable {
  const CustomeAppbarBlocState();

  @override
  List<Object> get props => [];
}

class WishListNotificationInitial extends CustomeAppbarBlocState {}

class WishListNotification extends CustomeAppbarBlocState {
  final String notificationNums;
  const WishListNotification({this.notificationNums});

  @override
  List<Object> get props => [notificationNums];

  @override
  String toString() {
    return 'notificationNums $notificationNums';
  }
}
