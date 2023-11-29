import 'package:appmattsa/config/theme/app_theme.dart';
import 'package:appmattsa/features/auth/presentation/providers/auth_provider.dart';
import 'package:appmattsa/features/auth/presentation/providers/login_form_provider.dart';
import 'package:appmattsa/shared/widgets/replacehelpformflied.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../shared/shared.dart';
import '../../../../../singleton.dart';

class LoginScreen extends ConsumerWidget {
  static const name = "login-screen";

  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final scaffoldBackgroundColor = Theme.of(context).scaffoldBackgroundColor;

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
         backgroundColor: AppTheme.blueMattsa,
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              image: DecorationImage(
              image: AssetImage("assets/images/fondo.jpg"),
              fit: BoxFit.cover,
              ),
            ),
            child:SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.05,
                  top:  MediaQuery.of(context).size.height * 0.2,
                  right: MediaQuery.of(context).size.width * 0.05,
                ),
                child:  Container(
                  width: MediaQuery.of(context).size.width * 0.85,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: AppTheme.blueTransparentMattsa,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //const SizedBox(height: 80),
                      Padding(
                        padding: const EdgeInsets.only(bottom:0),
                        child: Align(
                          alignment: Alignment.center,
                          child: Image.asset(
                            "assets/images/logo_white.png",
                            fit: BoxFit.contain,
                            width: MediaQuery.of(context).size.width * 0.85,
                          ),
                        ),
                      ),
                      const _LoginForm(),
                      /*Container(
                    height: size.height - 260, // 80 los dos sizebox y 100 el ícono
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: AppTheme.blueMattsa,
                      borderRadius:
                          BorderRadius.only(topLeft: Radius.circular(100)),
                    ),
                    child: const _LoginForm(),
                  )*/
                    ],
                  ),
                ),
              ),
            ),
        ),
      ),
    );
  }
}

class _LoginForm extends ConsumerWidget {
  const _LoginForm();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginForm = ref.watch(loginFormProvider);
    final textStyles = Theme.of(context).textTheme;
    Singleton singleton = Singleton();

    ref.listen(authProvider, (previous, next) {
      if (next.errorMessage.isEmpty) return;
      showSnackBar(context, next.errorMessage);
    });

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
          const SizedBox(height: 50),
          // CustomTextFormField(
          //   label: 'Correo',
          //   keyboardType: TextInputType.emailAddress,
          //   onChanged: ref.read(loginFormProvider.notifier).onEmailChange,
          //   errorMessage:
          //       loginForm.isFormPosted ? loginForm.email.errorMessage : null,
          // ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
            child: Text(
              "Login",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: Colors.white,
              ),
            ),
          ),
          CustomTextFormFieldReplace(
            label: 'Correo',
            keyboardType: TextInputType.emailAddress,
            onChanged: ref.read(loginFormProvider.notifier).onEmailChange,
            errorMessage:
            loginForm.isFormPosted ? loginForm.email.errorMessage : null,
            obscureText: false,
            borderFocusColor: Colors.white,
            prefixIconColor: Colors.white,
            borderColor: Colors.white,
            textColor: Colors.black,
            hintColor: Colors.white.withOpacity(0.7),
            borderRadius: 15,
            contentPadding: 10,
          ),
          const SizedBox(height: 30),
          CustomTextFormFieldReplace(
            label: 'Contraseña',
            obscureText: loginForm.obscureText,
            onChanged: ref.read(loginFormProvider.notifier).onPasswordChanged,
            errorMessage:
            loginForm.isFormPosted ? loginForm.password.errorMessage : null,
            borderFocusColor: Colors.white,
            prefixIconColor: Colors.white,
            borderColor: Colors.white,
            textColor: Colors.black,
            hintColor: Colors.white.withOpacity(0.7),
            borderRadius: 15,
            suffixIcon: IconButton(
              onPressed:(){
                ref.read(loginFormProvider.notifier).onChangeObscureText();
              },
              color: Colors.black,
              icon: Icon(
                loginForm.obscureText ? Icons.visibility_off : Icons.visibility,
              ),
            ),

          ),
          // CustomTextFormField(
          //   label: 'Contraseña',
          //   obscureText: true,
          //   onChanged: ref.read(loginFormProvider.notifier).onPasswordChanged,
          //   errorMessage:
          //       loginForm.isFormPosted ? loginForm.password.errorMessage : null,
          // ),
          const SizedBox(height: 30),

          !loginForm.isPosting ?
          SizedBox(
              width: double.infinity,
              height: 50,
              child: CustomFilledButton(
                text: 'Ingresar',
                buttonColor: Colors.black,
                onPressed:  !loginForm.isPosting ?() {
                  singleton.viewSubMenu = true;
                  singleton.showMenuMainPage = true;
                  FocusScope.of(context).requestFocus(FocusNode());
                  ref.read(loginFormProvider.notifier).onFormSubmit();
                }:null,
              )):const CircularProgressIndicator(),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  void showSnackBar(BuildContext context, String errorMessage) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(errorMessage)));
  }
}
