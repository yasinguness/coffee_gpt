import "package:flutter/material.dart";

/// It is an error type generated from the StateError class.
class FlowError extends StateError {
  /// In this class, it holds the data type sent with the assertEqual function.
  dynamic status;

  /// In this class, it holds the result sent with the assertEqual function.
  dynamic result;

  /// Creates the FlowError class with the given parameters.
  FlowError({@required this.status, String? message, this.result}) : super(message ?? "");

  /// It checks the equality of the sent value and the expected value. If not equal it throws a FlowError.
  static void assertEqual(
    dynamic value,
    dynamic expectedValue,
    dynamic status, [
    dynamic result,
    String? message,
  ]) {
    if (value != expectedValue) {
      final e = FlowError(
        status: status,
        result: result,
        message: message ?? "value:$value expectedValue:$expectedValue status:$status \n${StackTrace.current}",
      );

      debugPrint(e.toString());
      debugPrint(StackTrace.current.toString());

      throw e;
    }
  }
}
