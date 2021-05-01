abstract class AuthenticationEvent{}

// Lần đầu tiên thì đã biết đăng nhập hay chưa đâu
class AuthenticationEventStarted extends AuthenticationEvent{}
class AuthenticationEventLoggedIn extends AuthenticationEvent{}
class AuthenticationEventLoggedOut extends AuthenticationEvent{}