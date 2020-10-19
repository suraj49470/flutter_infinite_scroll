import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:infinite_scroll/bloc/post_bloc.dart';
import 'package:infinite_scroll/models/post_model.dart';

part 'custome_appbar_bloc_event.dart';
part 'custome_appbar_bloc_state.dart';

class CustomeAppbarBloc
    extends Bloc<CustomeAppbarBlocEvent, CustomeAppbarBlocState> {
  final PostBloc postBloc;
  StreamSubscription postBlocSubscription;
  CustomeAppbarBloc({this.postBloc}) : super(WishListNotificationInitial()) {
    postBlocSubscription = postBloc.listen((state) {
      print('****CustomeAppbarBloc****');
      print(state);
      print('***CustomeAppbarBloc*****');
      if (state is PostSuccess) {
        final int wishListedItemsLength =
            state.posts.where((Post post) => post.isWishlisted).length;
        add(UpdateWishListNotification(
            notificationNumber: wishListedItemsLength));
      }
    });
  }

  @override
  Stream<CustomeAppbarBlocState> mapEventToState(
    CustomeAppbarBlocEvent event,
  ) async* {
    if (event is UpdateWishListNotification) {
      final int num = event.notificationNumber;
      if (num != 0) {
        yield num != 0 && num <= 99
            ? WishListNotification(notificationNums: num.toString())
            : WishListNotification(notificationNums: '99+');
      } else {
        yield WishListNotificationInitial();
      }
    }
  }

  @override
  Future<void> close() {
    postBlocSubscription.cancel();
    return super.close();
  }
}
