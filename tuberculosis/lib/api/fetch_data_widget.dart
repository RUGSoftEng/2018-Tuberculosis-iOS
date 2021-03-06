import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef Widget FetchDataWidgetBuilder<T>(BuildContext context, T data);

class FetchDataWidget<T> extends StatefulWidget {

  final Function getFutureFunction;
  final FetchDataWidgetBuilder<T> builder;
  final String language;

  FetchDataWidget({this.getFutureFunction, this.builder, this.language});

  @override
  _FetchDataWidgetState<T> createState() => _FetchDataWidgetState<T>(getFutureFunction());
}

class _FetchDataWidgetState<T> extends State<FetchDataWidget<T>> {

  Future<T> _future;

  _FetchDataWidgetState(this._future);

  @override
  bool didUpdateWidget(FetchDataWidget<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.language != widget.language) {
      setState(() {
        _future = widget.getFutureFunction();
      });
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
      future: _future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Center(
                child: CupertinoButton(
                  child: Text("Probeer opnieuw."),
                  onPressed: () {
                    setState(() {
                      _future = widget.getFutureFunction();
                    });
                  },
                )
            );
          } else {
            return widget.builder(context, snapshot.data);
          }
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

}