class ApiResponse<T> {
  ApiResponse.error(this.message) : status = Status.error;

  ApiResponse.success(this.data) : status = Status.success;

  T? data;
  String? message;
  Status status;

  @override
  String toString() {
    return "Status : $status \n Message : $message \n Data : $data";
  }
}

enum Status { success, error }
