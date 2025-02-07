part of 'register_bloc.dart';

sealed class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

// class NavigateLoginScreenEvent extends RegisterEvent {
//   final BuildContext context;
//   final Widget destination;

//   const NavigateLoginScreenEvent({
//     required this.context,
//     required this.destination,
//   });
// }

class NavigateVerifyScreenEvent extends RegisterEvent {
  final BuildContext context;
  final Widget destination;

  const NavigateVerifyScreenEvent({
    required this.context,
    required this.destination,
  });
}


class RegisterUserEvent extends RegisterEvent {
  final BuildContext context;
  final String email;
  final String contactNo;
  final String name;
  final String password;
  final String? image;
  final String? otp;

  const RegisterUserEvent({
    required this.context,
    required this.email,
    required this.contactNo,
    required this.name,
    required this.password,
    this.image,
    this.otp,
  });
}

class LoadImage extends RegisterEvent {
  final File file;
  const LoadImage({
    required this.file,
  });
}
