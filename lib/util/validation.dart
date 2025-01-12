import 'package:intl/intl.dart';

class Validation {
  // final String _invalidChars = r'^[a-zA-Z0-9_\-=@,\:\.; ]+$';
  final String _nameReg = r"^[a-zA-Z\\s]*\$";
  final String _mobileReg = r"(^[6-9][0-9]*\$)";
  final String _landlineReg = r"(^[0-9 ]*\$)";
  final String _panReg = r"(^([a-zA-Z]){5}([0-9]){4}([a-zA-Z]){1}?\$)";
  final String _aadharReg = r"(^[0-9 ]*\$)";
  final String _pincodeReg = r"^[1-9]{1}[0-9]{2}\\s{0, 1}[0-9]{3}$";
  final String _passwordReg =
      r"(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[^\w\s])^.{8,}$";
  final String _emailReg =
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$";

  final String _requiredErrorMessage = "This field required";
  final String _emailErrorMessage = "Enter Valid Email ID";
  final String _mobileNumberErrorMessage = "Enter valid mobile number";
  final String _landlineNumberErrorMessage = "Enter valid landline number";
  final String _dobErrorMessage = "Invalid dob date";
  final String _nameErrorMessage =
      "Number Symbols or Special Characters are allowed in Name";
  final String _aadharErrorMessage = "Enter valid aadhar number";
  final String _panErrorMessage = "Enter valid pan number";
  final String _passwordErrorMessage =
      "Password must have upper case alphabet, lower case alphabet, special characters, and 8 characters.";

  final String _backDateErrorMessage = "Back date not allowed";
  final String _futureDateErrorMessage = "You can not enter future date";

  final _dateFormat = DateFormat("dd/MM/yyyy");

  String? requireValidation(value, {String? errorMessage}) {
    return value?.isEmpty ?? true
        ? errorMessage ?? _requiredErrorMessage
        : null;
  }

  String? emailValidation(String? value,
      {bool isRequired = true, String? errorMessage}) {
    if (value?.isEmpty ?? true && isRequired) return _requiredErrorMessage;
    RegExp regex = RegExp(_emailReg);
    return regex.hasMatch(value!) ? null : errorMessage ?? _emailErrorMessage;
  }

  String? mobileValidation(String? value,
      {bool isRequired = true, String? errorMessage}) {
    if (value?.isEmpty ?? true && isRequired) return _requiredErrorMessage;
    RegExp regex = RegExp(_mobileReg);
    return regex.hasMatch(value!)
        ? null
        : errorMessage ?? _mobileNumberErrorMessage;
  }

  String? landlineValidation(String? value,
      {bool isRequired = true, String? errorMessage}) {
    if (value?.isEmpty ?? true && isRequired) return _requiredErrorMessage;
    RegExp regex = RegExp(_landlineReg);
    return regex.hasMatch(value!)
        ? null
        : errorMessage ?? _landlineNumberErrorMessage;
  }

  String? dobValidation(String? value,
      {bool isRequired = true, String? errorMessage}) {
    if (value?.isEmpty ?? true && isRequired) return _requiredErrorMessage;
    final dob = _dateFormat.parse(value!);
    final today = DateTime.now();
    return (dob.isAfter(today)) ? errorMessage ?? _dobErrorMessage : null;
  }

  String? backDateValidation(String? value,
      {bool isRequired = true, String? errorMessage}) {
    if (value?.isEmpty ?? true && isRequired) return _requiredErrorMessage;

    final givenDate = _dateFormat.parse(value!);
    final today = DateTime.now();
    return (givenDate.isAfter(today))
        ? errorMessage ?? _backDateErrorMessage
        : null;
  }

  String? futureDateValidation(value,
      {bool isRequired = true, String? errorMessage}) {
    if (value?.isEmpty ?? true && isRequired) return _requiredErrorMessage;

    final givenDate = _dateFormat.parse(value!);
    final today = DateTime.now();
    return (givenDate.isBefore(today))
        ? errorMessage ?? _futureDateErrorMessage
        : null;
  }

  ageValidation(value, {bool isRequired = true, String? errorMessage}) {
    if (value?.isEmpty ?? true && isRequired) return _requiredErrorMessage;
    return (int.parse(value) < 0 || int.parse(value) > 120)
        ? errorMessage ?? 'Invalid age.Enter age between 0-120 yr'
        : null;
  }

  String? nameValidation(value, {String? errorMessage}) {
    if (value?.isEmpty ?? true) return _requiredErrorMessage;
    RegExp regex = RegExp(_nameReg);
    return regex.hasMatch(value!) ? null : errorMessage ?? _nameErrorMessage;
  }

  String? panValidation(String? value,
      {bool isRequired = true, String? errorMessage}) {
    if (value?.isEmpty ?? true && isRequired) return _requiredErrorMessage;
    RegExp regex = RegExp(_panReg);
    return regex.hasMatch(value!) ? null : errorMessage ?? _panErrorMessage;
  }

  String? aadharValidation(String? value,
      {bool isRequired = true, String? errorMessage}) {
    if (value?.isEmpty ?? true && isRequired) return _requiredErrorMessage;
    RegExp regex = RegExp(_aadharReg);
    return regex.hasMatch(value!) ? null : errorMessage ?? _aadharErrorMessage;
  }

  String? pincodeValidation(String? value,
      {bool isRequired = true, String? errorMessage}) {
    if (value?.isEmpty ?? true && isRequired) return _requiredErrorMessage;
    RegExp regex = RegExp(_pincodeReg);
    return regex.hasMatch(value!) ? null : errorMessage;
  }

  String? passwordValidation(String? value, {String? errorMessage}) {
    RegExp regex = RegExp(_passwordReg);
    return regex.hasMatch(value!)
        ? null
        : errorMessage ?? _passwordErrorMessage;
  }

  String? confirmPasswordValidation(String? value, String? password) {
    if (value == null || value.isEmpty) return 'Password is not matching';
    return null;
  }
}

final validate = Validation();
