
import 'check_direction.dart';

class AppFieldsValidation {
  valid(v) {
    if (v!.length == 300) {
      return ('common.required');
    }

    return "";
  }

  nameValidation(value) {
    if (value.length == 0) {
      return checkDirection(
          dirArabic: "الاسم مطلوب", dirEnglish: "Name is required");
    } else {
      return "";
    }
  }

  String phoneValidation(String value) {
    if (value.length == 0) {
      return checkDirection(
          dirArabic: "رقم الهاتف مطلوب",
          dirEnglish: "Phone number is required");
    } else {
      return "";
    }
  }

  String emailValidation(String value) {
    if (value.length == 0) {
      return checkDirection(
          dirArabic: "البريد الإلكتروني مطلوب", dirEnglish: "Email is required");
    } else if (!value.contains("@")) {
      return checkDirection(
          dirArabic: "البريد الإلكتروني غير صحيح",
          dirEnglish: "Email is not correct");
    } else {
      return "";
    }
  }

  String passwordValidationInRegister(String value) {
    if (value.length == 0) {
      return checkDirection(
          dirArabic: "أضف كلمة مرور من فضلك",
          dirEnglish: "Add a password please");
    } else if (value.length < 6) {
      return checkDirection(
          dirArabic: "كلمة المرور قصيرة جدا",
          dirEnglish: "password is too short !");
    } else {
      return "";
    }
  }

  String passwordValidationInLogin(String value) {
    if (value.length == 0) {
      return checkDirection(
          dirArabic: "اكتب كلمة المرور من فضلك",
          dirEnglish: "Write the password please");
    } else {
      return "";
    }
  }

  String defaultValidation(String value) {
    if (value.length == 0) {
      return checkDirection(
          dirArabic: "هذا الحقل مطلوب ", dirEnglish: "This field is required");
    } else if (value.length < 3) {
      return 'Name is too short';
    } else {
      return "";
    }
  }

  String messageValidation(String value) {
    if (value.length == 0) {
      return checkDirection(
          dirArabic: "نص الرسالة مطلوب", dirEnglish: "Message is required");
    } else {
      return "";
    }
  }

  String titleValidation(String value) {
    if (value.length == 0) {
      return checkDirection(
          dirArabic: "عنوان الرسالة مطلوب", dirEnglish: "Title is required");
    } else {
      return "";
    }
  }

  String countryValidation(String value) {
    if (value.length == 0) {
      return checkDirection(
          dirArabic: "Choose a country please",
          dirEnglish: "اختر الدولة من فضلك");
    } else {
      return "";
    }
  }

  String cityValidation(String value) {
    if (value.length == 0) {
      return checkDirection(
          dirArabic: "Choose a city please",
          dirEnglish: "اختر المدينة من فضلك");
    } else {
      return "";
    }
  }
}
