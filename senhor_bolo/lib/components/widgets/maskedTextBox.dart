import 'package:flutter/material.dart';
import '../../constants.dart';

// 

Widget maskedTextField ({
  required String txtLabel,
  required TextEditingController txtController,
  required TextInputType inputType,
  required var mask,
  double? widthButton

}){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        txtLabel,
        style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
            color: textSecondaryColor
        ),
      ),

      SizedBox(height: 4),

      SizedBox(
          width: widthButton,
          child: TextFormField(
            textInputAction: TextInputAction.next,
            controller: txtController,
            keyboardType: inputType,
            inputFormatters: [mask],
            validator: (value){
              return value == null || value.isEmpty
                  ? 'Preencha o campo $txtLabel'
                  : null;
            },
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(left: 15),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(11),
                borderSide: BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                ),
              ),
            ),
          ))
    ],
  );
}