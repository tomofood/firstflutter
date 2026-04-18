String? mobileValidator(String? value) {
  if (value == null) return '手机号不能为空';
  if (!RegExp(r'^1[3-9]\d{9}$').hasMatch(value)) {
    return '手机号码不正确';
  } else {
    return null;
  }
}

String? passwordValidator(String? value) {
  if (value == null) return '密码不能为空';
  if (RegExp(r'^[0-9a-zA-Z_]{6,12}$').hasMatch(value)) {
    return null;
  } else {
    return '密码格式不正确';
  }
}
