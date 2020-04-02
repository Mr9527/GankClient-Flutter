/// Created by guoshuyu
/// Date: 2018-08-16
class HttpErrorEvent {
  final int code;

  final String message;

  final bool noTip;

  HttpErrorEvent(this.code, this.message, {this.noTip = false});
}
