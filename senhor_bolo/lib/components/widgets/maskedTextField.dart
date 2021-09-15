import 'package:flutter/material.dart';
import 'package:senhor_bolo/constants.dart';

// Campo de texto com máscara

Widget maskedTextField(String textFieldName,
    TextEditingController maskedController,
    var inputFormatter){
  return TextFormField(
    textInputAction: TextInputAction.next,
    controller: maskedController,
    keyboardType: TextInputType.number,
    inputFormatters: [inputFormatter],
    validator: (value){
      return value == null || value.isEmpty
          ? 'Preencha o campo $textFieldName'
          : null;
    },
    decoration: InputDecoration(
      contentPadding: EdgeInsets.only(left: 15),
      labelText: textFieldName,
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(11),
        borderSide: BorderSide(
          width: 0,
          style: BorderStyle.none,
        ),
      ),
      labelStyle: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.bold,
          color: textSecondaryColor
      ),
    ),
  );
}