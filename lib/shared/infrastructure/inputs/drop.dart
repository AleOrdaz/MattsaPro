import 'package:formz/formz.dart';

// Define input validation errors
enum DrpdownError { empty, value }

// Extend FormzInput and provide the input type and error type.
class Drop extends FormzInput<int, DrpdownError> {
  static List<int> listaid = [];
  // Call super.pure to represent an unmodified form input.
  const Drop.pure() : super.pure(0);

  // Call super.dirty to represent a modified form input.
  const Drop.dirty(int value) : super.dirty(value);

  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == DrpdownError.empty) return 'El campo es requerido';
    if (displayError == DrpdownError.value)
      return 'Tiene que ser un número mayor o igual a cero';

    return null;
  }

  void largaList(List<int> list) {
    listaid = list;
  }

  // Override validator to handle validating a given input value.
  @override
  DrpdownError? validator(int value) {
    if (value.toString().isEmpty || value.toString().trim().isEmpty)
      return DrpdownError.empty;
    if (value < 0) return DrpdownError.value;

    return null;
  }
}
