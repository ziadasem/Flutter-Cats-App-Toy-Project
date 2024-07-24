import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

//short length
void openToast(context, message) {
  if (context != null) {
    ToastContext().init(context);
    Toast.show(message,
        textStyle: const TextStyle(color: Colors.white),
        backgroundRadius: 20,
        duration: Toast.lengthShort);
  }
}

//long length
void openToast1(context, message) {
  if (context != null){
    ToastContext().init(context);
    Toast.show(message,
      textStyle: const TextStyle(color: Colors.white),
      backgroundRadius: 20,
      duration: Toast.lengthLong);
  }
}
