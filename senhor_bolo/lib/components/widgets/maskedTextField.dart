import 'package:flutter/material.dart';
import 'package:senhor_bolo/constants.dart';

Widget maskedTextField({
  required String textFieldName,
  required TextEditingController txtController,
  required TextInputType textInputType,
  var inputFormatter,
  double? textFieldWidth
}){
  return SizedBox(
    width: textFieldWidth,
    child: TextFormField(
      textInputAction: TextInputAction.next,
      controller: txtController,
      keyboardType: textInputType,
      inputFormatters: [inputFormatter],
      validator: (value){
        return value == null || value.isEmpty
            ? 'Preencha o campo $textFieldName'
            : null;
      },
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.only(left: 15),
        labelText: textFieldName,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(11),
          borderSide: const BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
        ),
        labelStyle: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
            color: textSecondaryColor
        ),
      ),
    ),
  );
}