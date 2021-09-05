import 'package:flutter/material.dart';
import 'package:sigaa_student/components/fields/text_input.dart';
import 'package:sigaa_student/config/routes/router.dart';
import 'package:sigaa_student/config/routes/routes.dart';
import 'package:sigaa_student/models/login/login.dart';
import 'package:sigaa_student/services/sync.dart';
import 'package:sigaa_student/utils/validators.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {
  /// The path to the logo image
  late final AssetImage _backgroundImage;

  /// The variable that will control if the cpf is a valid one
  late bool _invalidCpf;

  /// The variable that will control if the login was successfull
  late bool _invalid;

  /// The textfields that will hold the user's password
  late TextEditingController _passwordController;

  /// The textfield that wil hold the user's login
  late TextEditingController _userController;

  /// The variable that will hold the password typed
  late String _password;

  /// The variable that will hold the user typed
  late String _user;

  /// The variable that will make the system's connection
  late SyncService system;

  /// will be used to show/hide the login loading object
  late bool _doingLogin;

  @override
  void initState() {
    _backgroundImage = AssetImage("assets/images/EFEI_logo.png");
    _invalid = false;
    _invalidCpf = false;
    _doingLogin = false;
    _passwordController = TextEditingController();
    _userController = TextEditingController();
    _password = "";
    _user = "";
    system = SyncService();

    _passwordController.addListener(() {
      _password = _passwordController.text;
    });
    _userController.addListener(() {
      _user = _userController.text;
      var inv = false;

      if ((_user.length == 11) && (!validateCPF(_user))) {
        inv = true;
        print("cpf invalid");
      }

      setState(() {
        _invalidCpf = inv;
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _userController.dispose();
    super.dispose();
  }

  /// onSubmit is the function triggered when the user click on the login btn
  /// This function will try to login into sigaa's system
  void onSubmit() async {
    print("on submit triggered");

    // don't allow empty fields
    final inv =
        _userController.text.isEmpty || _passwordController.text.isEmpty;
    if (_invalid) {
      setState(() {
        _invalid = inv;
      });
      return;
    }

    // show the circle loading
    setState(() {
      _doingLogin = true;
    });

    // try to login into sigaa's system
    try {
      final payload = LoginPayload(login: _user, password: _password);

      final success = await system.login(payload);
      if (!success) throw "occurred a problem in the sync service";

      // changing screen
      print("changing screen");
      AppRouter.router.navigateTo(context, AppRoutes.rootRoute.route,
          transition: AppRoutes.rootRoute.transitionType);
    } catch (e) {
      print("failed to login");
      print(e);

      setState(() {
        _invalid = true;
        _doingLogin = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GestureDetector(
      child: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
          ),
          alignment: Alignment.center,
          child: Wrap(children: <Widget>[
            // image
            Padding(
              padding: EdgeInsets.all(50),
              child: Center(
                  child: Image(
                image: this._backgroundImage,
                width: 200,
              )),
            ),

            // field cpf
            InputField(
                maxlength: 11,
                controller: _userController,
                error: _invalid || _invalidCpf,
                icon: Icons.person_outline,
                textfield: 'Entre com o seu usuário (cpf)',
                title: 'Usuário'),

            // field password
            InputField(
                maxlength: 80,
                controller: _passwordController,
                error: _invalid,
                icon: Icons.lock_open,
                textfield: 'Entre com sua senha',
                title: 'Senha',
                shouldObscure: true),

            // error
            Padding(
              padding: EdgeInsets.only(top: 15.0),
              child: Center(
                  child: Text(
                _invalid ? "Falha no login. Verifique suas credenciais" : "",
                style: TextStyle(
                  color: Theme.of(context).errorColor,
                ),
                textAlign: TextAlign.center,
              )),
            ),

            // login button
            !_doingLogin
                ? Container(
                    margin: const EdgeInsets.only(top: 20.0),
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                elevation: 0,
                                primary: !_invalidCpf
                                    ? Theme.of(context).accentColor
                                    : Theme.of(context).disabledColor),
                            child: Text("ENTRAR"),
                            onPressed: !_invalidCpf ? onSubmit : () {},
                          ),
                        ),
                      ],
                    ),
                  )
                : Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                          Theme.of(context).accentColor),
                    ),
                  ),
          ]),
        ),
      ),
      onTap: () => FocusScope.of(context).unfocus(),
    ));
  }
}
