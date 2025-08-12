import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:raya_mobile/util/AppColorPalette.dart';

TextField appInputField(labelTxt, hintTxt, controller, type) {
  // bool showError = _submitted && !widget.emailValidator.isValid(value);
  return TextField(
    decoration: InputDecoration(
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black, width: 1.0),
      ),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey, width: 1.0),
      ),
      labelText: hintTxt,
      labelStyle: const TextStyle(color: Colors.black),
      //hintText: hintTxt,
      // hintStyle: const TextStyle(color: Colors.black),
      // errorText: showError ? 'Can\'t be Empty' : null,
    ),
    // focusNode: _emailFocusNode,
    controller: controller,
    autocorrect: false,
    textInputAction: TextInputAction.next,
    keyboardType: type,
    obscureText: false,
    cursorColor: Colors.black38,
    // onEditingComplete: _onEmailEditingDone,
    // onChanged: _updateState,
  );
}

TextField appInputFieldNumber(labelTxt, hintTxt, controller, type,limit) {
  // bool showError = _submitted && !widget.emailValidator.isValid(value);
  return TextField(    maxLength: limit,

    inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r"[0-9.]"))],
    decoration: InputDecoration(
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black, width: 1.0),
      ),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey, width: 1.0),
      ),
      labelText: hintTxt,
      counterText: "",
      labelStyle: const TextStyle(color: Colors.black),
      //hintText: hintTxt,
      // hintStyle: const TextStyle(color: Colors.black),
      // errorText: showError ? 'Can\'t be Empty' : null,
    ),
    // focusNode: _emailFocusNode,
    controller: controller,
    autocorrect: false,
    textInputAction: TextInputAction.next,
    keyboardType: type,
    obscureText: false,
    cursorColor: Colors.black38,
    // onEditingComplete: _onEmailEditingDone,
    // onChanged: _updateState,
  );
}

TextField appInputFieldUnderLine(labelTxt, hintTxt, controller, type, int limit, TextInputAction tia) {
  // bool showError = _submitted && !widget.emailValidator.isValid(value);
  return TextField(
    maxLength: limit,
    decoration: InputDecoration(
      border: const UnderlineInputBorder(),
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: AppColorPalette.appColorRed),
      ),
      labelText: hintTxt,
      counterText: "",
      labelStyle: const TextStyle(color: Colors.black,fontSize: 12),

    ),
    controller: controller,
    autocorrect: false,
    textInputAction: tia,
    keyboardType: type,
    obscureText: false,
    cursorColor: Colors.black38,
    inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r"[0-9]"))],
  );
}

TextField appInputFieldDisabled(labelTxt, hintTxt, controller, type,Function onTap) {
  // bool showError = _submitted && !widget.emailValidator.isValid(value);
  return TextField(
    decoration: InputDecoration(
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black, width: 1.0),
      ),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey, width: 1.0),
      ),
      labelText: hintTxt,
      labelStyle: const TextStyle(color: Colors.black),
      //hintText: hintTxt,
      // hintStyle: const TextStyle(color: Colors.black),
      // errorText: showError ? 'Can\'t be Empty' : null,
    ),
    // focusNode: _emailFocusNode,
    controller: controller,
    autocorrect: false,
    textInputAction: TextInputAction.next,
    keyboardType: type,
    obscureText: false,
    readOnly: true,
    enableInteractiveSelection: true,
    onTap: ()=>{
      onTap('Data')
    },
    // onEditingComplete: _onEmailEditingDone,
    // onChanged: _updateState,
  );
}

TextField appInputFieldDone(labelTxt, hintTxt, controller, type) {
  return TextField(
    decoration: InputDecoration(
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black, width: 1.0),
      ),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey, width: 1.0),
      ),
      labelText: hintTxt,
      labelStyle: const TextStyle(color: Colors.black),
    ),
    // focusNode: _emailFocusNode,
    controller: controller,
    autocorrect: false,
    textInputAction: TextInputAction.done,
    keyboardType: type,
    obscureText: false,
    cursorColor: Colors.black38,
  );
}

TextField appInputFieldDoneHeight(labelTxt, hintTxt, controller, type) {
  return TextField(
    decoration: InputDecoration(
      /*focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black, width: 1.0),
      ),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey, width: 1.0),
      ),*/
      focusedBorder: InputBorder.none,
      enabledBorder: InputBorder.none,
      border: InputBorder.none,
      labelText: hintTxt,
      labelStyle: const TextStyle(color: Colors.black),
      isDense: true,                      // Added this
      contentPadding: const EdgeInsets.all(7),
    ),
    // focusNode: _emailFocusNode,
    controller: controller,
    autocorrect: false,
    enableSuggestions: false,
    textInputAction: TextInputAction.done,
    keyboardType: type,
    obscureText: false,
    cursorColor: Colors.black38,
  );
}


TextField appInputFieldError(labelTxt, hintTxt, controller, type,String? error) {
  // bool showError = _submitted && !widget.emailValidator.isValid(value);
  return TextField(
    cursorColor: Colors.black38,
    decoration: InputDecoration(
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black, width: 1.0),
      ),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey, width: 1.0),
      ),errorBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.black38, width: 1.0),
    ),
      focusedErrorBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black38, width: 1.0),
      ),
      labelText: hintTxt,
      labelStyle: const TextStyle(color: Colors.black),
      //hintText: hintTxt,
      // hintStyle: const TextStyle(color: Colors.black),
      errorText: error,
    ),
    // focusNode: _emailFocusNode,
    controller: controller,
    autocorrect: false,
    textInputAction: TextInputAction.next,
    keyboardType: type,
    obscureText: false,
    // onEditingComplete: _onEmailEditingDone,
    onChanged: (value)=>{
      if(value.isNotEmpty){
        error=""
      }

    },
  );
}

TextField appInputFieldMultiline(labelTxt, hintTxt, controller, type,String? error) {
  // bool showError = _submitted && !widget.emailValidator.isValid(value);
  return
    TextField(
        cursorColor: Colors.black38,

        decoration: InputDecoration(
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 1.0),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 1.0),
          ),errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black38, width: 1.0),
        ),
          focusedErrorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black38, width: 1.0),
          ),
          labelText: hintTxt,
          labelStyle: const TextStyle(color: Colors.black),
          //hintText: hintTxt,
          // hintStyle: const TextStyle(color: Colors.black),
          errorText: error,
        ),
        // focusNode: _emailFocusNode,
        controller: controller,
        autocorrect: false,
        // textInputAction: TextInputAction.next,
        keyboardType: type,
        minLines: 1,//Normal textInputField will be displayed
        maxLines: 5,
        obscureText: false,
        // onEditingComplete: _onEmailEditingDone,
        onChanged: (value)=>{
          if(value.isNotEmpty){
            error=""
          }
        }
    );
}

TextField appInputFieldMail(labelTxt, hintTxt, controller, type) {
  return TextField(
    cursorColor: Colors.black38,
    decoration: InputDecoration(
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 1.0),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 1.0),
        ),
        labelText: hintTxt,
        labelStyle: const TextStyle(color: Colors.black),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black38, width: 1.0),
        )
    ),
    // focusNode: _emailFocusNode,
    controller: controller,
    autocorrect: false,
    textInputAction: TextInputAction.next,
    keyboardType: type,
    obscureText: false,
    // onEditingComplete: _onEmailEditingDone,
    onChanged: (value)=>{
    },
  );

}

TextField appInputFieldChange(labelTxt, hintTxt, controller, type,Function onChange ) {
  // bool showError = _submitted && !widget.emailValidator.isValid(value);
  return TextField(
    decoration: InputDecoration(
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black, width: 1.0),
      ),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey, width: 1.0),
      ),
      labelText: hintTxt,
      labelStyle: const TextStyle(color: Colors.black),
      //hintText: hintTxt,
      // hintStyle: const TextStyle(color: Colors.black),
      // errorText: showError ? 'Can\'t be Empty' : null,
    ),
    // focusNode: _emailFocusNode,
    controller: controller,
    autocorrect: false,
    textInputAction: TextInputAction.next,
    keyboardType: type,
    obscureText: false,
    cursorColor: Colors.black38,
    // onEditingComplete: _onEmailEditingDone,
    onChanged: (value)=>{
      onChange(value)
    },
  );
}


TextField appInputFieldChangeSearch(labelTxt, hintTxt, controller, type,Function onChange ) {
  // bool showError = _submitted && !widget.emailValidator.isValid(value);
  return TextField(
    style: TextStyle(color: Colors.black),
    decoration: InputDecoration(
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xffF04D6B), width: 1.0),
      ),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey, width: 1.0),
      ),
      labelText: hintTxt,
      labelStyle: const TextStyle(color: Colors.black),

      //hintText: hintTxt,
      // hintStyle: const TextStyle(color: Colors.black),
      // errorText: showError ? 'Can\'t be Empty' : null,
    ),
    // focusNode: _emailFocusNode,
    controller: controller,
    autocorrect: false,
    textInputAction: TextInputAction.search,
    keyboardType: type,
    obscureText: false,
    cursorColor: Colors.black38,
    // onEditingComplete: _onEmailEditingDone,
    onChanged: (value)=>{
      onChange(value)
    },
  );
}
TextField appDisabledInputField(labelTxt, hintTxt, controller, type) {
  // bool showError = _submitted && !widget.emailValidator.isValid(value);
  return TextField(
    decoration: InputDecoration(
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black, width: 1.0),
      ),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey, width: 1.0),
      ),
      labelText: hintTxt,
      labelStyle: const TextStyle(color: Colors.black),
      //hintText: hintTxt,
      // hintStyle: const TextStyle(color: Colors.black),
      // errorText: showError ? 'Can\'t be Empty' : null,
    ),
    // focusNode: _emailFocusNode,
    controller: controller,
    autocorrect: false,
    textInputAction: TextInputAction.next,
    keyboardType: type,
    obscureText: false,
    readOnly: true,
    enableInteractiveSelection: false,
    enabled: false,
    // onTap: ()=>{
    //   onTap('Data')
    // },
    // onEditingComplete: _onEmailEditingDone,
    // onChanged: _updateState,
  );
}


final RegExp emailValidatorRegExp =
RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");