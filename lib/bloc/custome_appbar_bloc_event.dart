part of 'custome_appbar_bloc_bloc.dart';

abstract class CustomeAppbarBlocEvent extends Equatable {
  const CustomeAppbarBlocEvent();

  @override
  List<Object> get props => [];
}

class UpdateWishListNotification extends CustomeAppbarBlocEvent {
  final int notificationNumber;
  const UpdateWishListNotification({this.notificationNumber});

  @override
  List<Object> get props => [notificationNumber];

  @override
  String toString() {
    return 'notificationNumber $notificationNumber';
  }
}
