import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll/bloc/custome_appbar_bloc_bloc.dart';

class CustomeAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 60.0,
            width: 60.0,
            decoration: BoxDecoration(),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: GestureDetector(
                    onTap: () {
                      print('whish');
                    },
                    child: Icon(
                      Icons.favorite,
                      color: Colors.red,
                      size: 35.0,
                    ),
                  ),
                ),
                BlocConsumer<CustomeAppbarBloc, CustomeAppbarBlocState>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    if (state is WishListNotification) {
                      return Align(
                        alignment: Alignment(0.5, -0.4),
                        child: Container(
                          padding: EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                              color: Colors.grey, shape: BoxShape.circle),
                          child: Text(
                            state.notificationNums,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 8.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      );
                    }
                    return Text('');
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
