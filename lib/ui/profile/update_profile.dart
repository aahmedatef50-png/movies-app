import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_movies_app/l10n/app_localizations.dart';
import 'package:my_movies_app/model/my_user.dart';
import 'package:my_movies_app/ui/profile/cubit/profile_states.dart';
import 'package:my_movies_app/ui/profile/cubit/profile_view_model.dart';
import 'package:my_movies_app/ui/widget/custom_bottom_sheet.dart';
import 'package:my_movies_app/ui/widget/edit_profile_widgets/edit_inputs.dart';
import 'package:my_movies_app/ui/widget/edit_profile_widgets/edit_profile_buttons.dart';
import 'package:my_movies_app/ui/widget/edit_profile_widgets/edit_profile_image_button.dart';
import 'package:my_movies_app/utils/app_color.dart';
import 'package:my_movies_app/utils/app_config.dart';
import 'package:my_movies_app/utils/app_route.dart';
import 'package:my_movies_app/utils/app_style.dart';
import 'package:my_movies_app/utils/toast_utils.dart';
import 'package:my_movies_app/utils/utils_dialog.dart';

import '../../cubit/my_user_cubit.dart';

class UpdateProfile extends StatefulWidget {
  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  late MyUser myUser;
  late final nameController = TextEditingController(text: myUser.name);
  late final phoneController = TextEditingController(text: myUser.phoneNumber);
  TextEditingController passwordController = TextEditingController();
  int profileIndex=1;
  ProfileViewModel viewModel = ProfileViewModel();
  @override
  Widget build(BuildContext context) {
    myUser = context
        .read<MyUserCubit>()
        .state;

    var height = AppConfig.height(context);
    var width = AppConfig.width(context);

    return BlocConsumer<ProfileViewModel, ProfileStates>(
      bloc: viewModel,
      buildWhen: (previous, current) => current is ProfileInitialState,
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(AppLocalizations.of(context)!.edit_profile,
              style: AppStyle.reg16Yellow,),
            centerTitle: true,
            backgroundColor: AppColor.blackColor,
            leading: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back, color: AppColor.yellowColor, size: 21,)),

          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                spacing: 35,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  EditProfileImageButton(
                    profileIndex: profileIndex, onAvatarChanged: (newIndex) {
                    setState(() {
                      profileIndex = newIndex;
                    });
                  },),
                  EditInputs(nameController: nameController,
                      phoneController: phoneController),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(
                          AppRoute.forgetPasswordScreen);
                    },
                    child: Text(AppLocalizations.of(context)!.reset_password,
                      style: AppStyle.reg20White,
                    ),
                  ),
                  SizedBox(height: height * 0.18,),
                  EditProfileButtons(
                    onDelete: () {
                      UtilsDialog.showMessage(
                        context: context,
                        content: AppLocalizations.of(context)!
                            .are_you_sure_you_want_to_delete_your_account,
                        posAction: AppLocalizations.of(context)!.ok,
                        posActions: () {
                          final user = FirebaseAuth.instance.currentUser;

                          if (user == null) return;

                          final provider = user.providerData.first.providerId;

                          if (provider == 'password') {
                            showModalBottomSheet(
                              isScrollControlled: true,
                              backgroundColor: AppColor.blackColor,
                              context: context,
                              builder: (context) {
                                return Padding(
                                  padding: EdgeInsets.only(
                                    bottom: MediaQuery
                                        .of(context)
                                        .viewInsets
                                        .bottom,
                                  ),
                                  child: CustomBottomSheet(
                                    passwordController: passwordController,
                                    onClick: () {
                                      Navigator.pop(context);

                                      viewModel.deleteAccount(
                                        password: passwordController.text,
                                      );
                                    },
                                  ),
                                );
                              },
                            );
                          } else if (provider == 'google.com') {
                            viewModel.deleteAccount();
                          }
                        },
                        negAction: AppLocalizations.of(context)!.cancel,
                        title: AppLocalizations.of(context)!.delete_account,
                      );
                    },
                    onclick: () {
                      return viewModel.updateProfile(
                          context, myUser, nameController.text,
                          phoneController.text
                      );
                    }
                    ,)
                ],
              ),
            ),
          ),
        );
      },
      listener: (context, state) {
        if (state is ProfileUpdateState) {
          Navigator.pop(context);
          ToastUtils.showToastMessage(
              message: AppLocalizations.of(context)!
                  .profile_updated_successfully,
              context: context);
        } else if (
        state is ProfileDeleteAccountWithEmailAndPasswordState ||
            state is ProfileDeleteAccountWithGoogleState
        ) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            AppRoute.loginScreen,
                (route) => false,
          );
        }
      },
    );
  }
}
