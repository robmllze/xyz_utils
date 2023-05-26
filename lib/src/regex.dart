// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// XYZ Utils
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

/// Email, e.g. `foo@bar.com` or `foo@bar` (without `.com`)
/// Source: https://html.spec.whatwg.org/multipage/input.html#e-mail-state-%28type=email%29
const REG_EXP_EMAIL_0 = r"^[a-zA-Z\d.!#$%&'*+/=?^_`{|}~-]+"
    r"@"
    r"[a-zA-Z\d]"
    r"(?:[a-zA-Z\d-]{0,253}[a-zA-Z\d])?"
    r"(?:\.[a-zA-Z\d](?:[a-zA-Z\d-]{0,253}[a-zA-Z\d])?)*$";

/// Email, e.g. `foo@bar.com`.
const REG_EXP_EMAIL = r"^[a-zA-Z\d.!#$%&'*+/=?^_`{|}~-]+"
    r"@"
    r"[a-zA-Z\d]"
    r"(?:[a-zA-Z\d-]{0,253}[a-zA-Z\d])?"
    r"(?:\.[a-zA-Z\d](?:[a-zA-Z\d-]{0,253}[a-zA-Z\d])?)+$";

// Email, e.g. `foo@bar.com`.
const REG_EXP_EMAIL_OR_EMPTY = r"^([a-zA-Z\d.!#$%&'*+/=?^_`{|}~-]+"
    r"@"
    r"[a-zA-Z\d]"
    r"(?:[a-zA-Z\d-]{0,253}[a-zA-Z\d])?"
    r"(?:\.[a-zA-Z\d](?:[a-zA-Z\d-]{0,253}[a-zA-Z\d])?)+)?$";

/// Minimum eight characters, at least one letter and one number.
const REG_EXP_PASSWORD_STRENGTH_0 = r"^((?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,})$";

/// Minimum eight characters, at least one letter, one number and one special character.
const REG_EXP_PASSWORD_STRENGTH_1 =
    r"^((?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&_])[A-Za-z\d@$!%*#?&_]{8,})$";

/// Minimum eight characters, at least one uppercase letter, one lowercase letter and one number.
const REG_EXP_PASSWORD_STRENGTH_2 = r"^((?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,})$";

/// Minimum eight characters, at least one uppercase letter, one lowercase letter, one number and one special character.
const REG_EXP_PASSWORD_STRENGTH_3 =
    r"^((?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*#?&_])[A-Za-z\d@$!%*#?&_]{8,})$";

/// Minimim of two words without any special characters
const REG_EXP_FULL_NAME_OR_EMPTY = r"^([a-zA-Z]+([ ]+[a-zA-Z]+)+)?$";

/// Home or mobile phone number, e.g. `+14041234567` or `0412345678`
const REG_EXP_PHONE = r"^((\+\d{1,2}\s?)?1?\-?\.?\s?\(?\d{3}\)?[\s.-]?\d{3}[\s.-]?\d{4})$";

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

bool isValidEmail(String expression) {
  return RegExp(REG_EXP_EMAIL_0).hasMatch(expression);
}
