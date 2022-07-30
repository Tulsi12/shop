import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:restaurant/Bloc/User/user_bloc.dart';
import 'package:restaurant/Helpers/validate_form.dart';
import 'package:restaurant/Screen/Login/LoginPage.dart';
import 'package:restaurant/Themes/ColorsFrave.dart';
import 'package:restaurant/Widgets/AnimationRoute.dart';
import 'package:restaurant/Widgets/Widgets.dart';
import 'package:restaurant/Helpers/Helpers.dart';

class RegisterClientPage extends StatefulWidget {
  @override
  _RegisterClientPageState createState() => _RegisterClientPageState();
}

class _RegisterClientPageState extends State<RegisterClientPage> {
  late TextEditingController _nameController;
  late TextEditingController _lastnameController;
  late TextEditingController _phoneController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  final _keyForm = GlobalKey<FormState>();

  @override
  void initState() {
    _nameController = TextEditingController();
    _lastnameController = TextEditingController();
    _phoneController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    clearForm();
    _nameController.dispose();
    _lastnameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void clearForm() {
    _nameController.clear();
    _lastnameController.clear();
    _phoneController.clear();
    _emailController.clear();
    _passwordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final userBloc = BlocProvider.of<UserBloc>(context);

    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        if (state is LoadingUserState) {
          modalLoading(context);
        } else if (state is SuccessUserState) {
          Navigator.pop(context);
          modalSuccess(
              context,
              'Client Registered successfully',
              () => Navigator.pushReplacement(
                  context, routeFrave(page: LoginPage())));
        } else if (state is FailureUserState) {
          Navigator.pop(context);
          errorMessageSnack(context, state.error);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
              clearForm();
            },
            child: Container(
                alignment: Alignment.center,
                child: TextFrave(
                    text: 'Cancel',
                    color: ColorsFrave.primaryColor,
                    fontSize: 16)),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          leadingWidth: 70,
          title: TextFrave(
            text: 'Add new Account',
          ),
          centerTitle: true,
          actions: [
            InkWell(
              onTap: () {
                if (_keyForm.currentState!.validate()) {
                  userBloc.add(OnRegisterClientEvent(
                    _nameController.text,
                    _emailController.text,
                    _passwordController.text,
                  ));
                }
              },
              child: Container(
                margin: EdgeInsets.only(right: 10.0),
                alignment: Alignment.center,
                child: TextFrave(
                    text: 'Save',
                    color: ColorsFrave.primaryColor,
                    fontSize: 16),
              ),
            ),
          ],
        ),
        body: Form(
          key: _keyForm,
          child: ListView(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            children: [
              SizedBox(height: 40.0),
              TextFrave(text: 'Full Name'),
              SizedBox(height: 5.0),
              FormFieldFrave(
                controller: _nameController,
                hintText: 'Enter your Full  Name',
                validator: RequiredValidator(errorText: 'Name is required'),
              ),
              SizedBox(height: 15.0),
              TextFrave(text: 'Email'),
              SizedBox(height: 5.0),
              FormFieldFrave(
                  controller: _emailController,
                  hintText: 'email@aweclick.com',
                  keyboardType: TextInputType.emailAddress,
                  validator: validatedEmail),
              SizedBox(height: 15.0),
              TextFrave(text: 'Password'),
              SizedBox(height: 5.0),
              FormFieldFrave(
                controller: _passwordController,
                hintText: '********',
                isPassword: true,
                validator: passwordValidator,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
