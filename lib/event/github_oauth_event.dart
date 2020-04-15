class UserGithubOAuthEvent {
  final String loginName;
  final String token;
  final bool isSuccess;

  UserGithubOAuthEvent(this.loginName, this.token, this.isSuccess);
}
