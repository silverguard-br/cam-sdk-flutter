enum HttpResponseStatusEnum { success, error }

sealed class RemoteResult {}

abstract class RemoteResultApi<T> extends RemoteResult {
  final T? dataValue;
  final HttpResponseStatusEnum? httpResponseStatusEnum;
  final String? statusCode;
  final String? message;

  RemoteResultApi({
    this.dataValue,
    this.httpResponseStatusEnum,
    this.statusCode,
    this.message,
  });
}

class SuccessResultApi<T> extends RemoteResultApi<T> {
  final T? data;

  SuccessResultApi({this.data})
    : super(
        dataValue: data,
        httpResponseStatusEnum: HttpResponseStatusEnum.success,
        statusCode: "200",
        message: null,
      );
}

class ErrorResultApi<T> extends RemoteResultApi<T> {
  final String? errorMessage;
  final String? statusCodeError;

  ErrorResultApi({this.errorMessage, this.statusCodeError})
    : super(
        dataValue: null,
        statusCode: statusCodeError,
        message: errorMessage,
        httpResponseStatusEnum: HttpResponseStatusEnum.error,
      );
}
