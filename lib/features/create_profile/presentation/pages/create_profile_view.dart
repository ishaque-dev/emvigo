import 'package:emvigo/features/create_profile/domain/entities/user_profile_entity.dart';
import 'package:emvigo/features/create_profile/presentation/bloc/user_profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CreateProfileView extends StatefulWidget {
  final String uid;
  const CreateProfileView({super.key, this.uid = ''});

  @override
  State<CreateProfileView> createState() => _CreateProfileViewState();
}

class _CreateProfileViewState extends State<CreateProfileView> {
  final _formKey = GlobalKey<FormState>();

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _dobController = TextEditingController();

  DateTime? _dateOfBirth;
  Gender? _gender;
  String? _nationality;
  List<String> _languages = [];

  static const _languageOptions = [
    'English',
    'Arabic',
    'French',
    'Spanish',
    'German',
  ];
  static const _nationalityOptions = ['UK', 'UAE', 'USA'];

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _dobController.dispose();
    super.dispose();
  }

  Future<void> _pickDateOfBirth() async {
    final now = DateTime.now();
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: _dateOfBirth ?? DateTime(now.year - 18, now.month, now.day),
      firstDate: DateTime(1900),
      lastDate: now,
    );
    if (selectedDate != null) {
      setState(() {
        _dateOfBirth = selectedDate;
        _dobController.text =
            "${selectedDate.day.toString().padLeft(2, '0')}-"
            "${selectedDate.month.toString().padLeft(2, '0')}-"
            "${selectedDate.year}";
      });
    }
  }

  Future<void> _pickLanguages() async {
    final tempSelection = List<String>.from(_languages);
    final result = await showDialog<List<String>>(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text('Select languages'),
              content: SizedBox(
                width: double.maxFinite,
                child: ListView(
                  shrinkWrap: true,
                  children: _languageOptions.map((language) {
                    final isChecked = tempSelection.contains(language);
                    return CheckboxListTile(
                      title: Text(language),
                      value: isChecked,
                      onChanged: (checked) {
                        setDialogState(() {
                          if (checked == true) {
                            tempSelection.add(language);
                          } else {
                            tempSelection.remove(language);
                          }
                        });
                      },
                    );
                  }).toList(),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context, tempSelection),
                  child: const Text('Done'),
                ),
              ],
            );
          },
        );
      },
    );

    if (result != null) {
      setState(() => _languages = result);
      // re-run the FormField validator for languages
      _formKey.currentState?.validate();
    }
  }

  void _handleSave() {
    final isFormValid = _formKey.currentState?.validate() ?? false;

    if (!isFormValid) return;

    final entity = UserProfileEntity(
      uid: widget.uid,
      firstName: _firstNameController.text.trim(),
      lastName: _lastNameController.text.trim(),
      dateOfBirth: _dateOfBirth!,
      gender: _gender!,
      nationality: _nationality!,
      languages: _languages,
    );

    context.read<UserProfileBloc>().add(CreateUserProfile(userProfile: entity));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserProfileBloc, UserProfileState>(
      listener: (context, state) {
        if (state is UserProfileSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Profile saved successfully')),
          );
          Navigator.of(context).maybePop();
        } else if (state is UserProfileFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errorMessage)));
        }
      },
      builder: (context, state) {
        final isLoading = state is UserProfileLoading;
        return _buildScaffold(context, isLoading);
      },
    );
  }

  Widget _buildScaffold(BuildContext context, bool isLoading) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                SizedBox(height: 50.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Text(
                    "Create your Profile",
                    style: TextStyle(
                      fontSize: 30.sp,
                      fontWeight: FontWeight.bold,
                      fontFamily: GoogleFonts.dmSerifDisplay().fontFamily,
                    ),
                  ),
                ),
                SizedBox(height: 27.h),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    "Create your profile with some basic information",
                    textAlign: TextAlign.left,
                    style: getTextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 28.h),

                SizedBox(
                  width: double.infinity,
                  child: Text("Whats your name", style: getTextStyle()),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 10.h,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _firstNameController,
                          textCapitalization: TextCapitalization.words,
                          decoration: getDecoration(hintText: 'First Name'),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Required';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: TextFormField(
                          controller: _lastNameController,
                          textCapitalization: TextCapitalization.words,
                          decoration: getDecoration(hintText: 'Last Name'),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Required';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10.h),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    "First name is only visible on your profile.",
                    textAlign: TextAlign.left,
                    style: getTextStyle(),
                  ),
                ),
                SizedBox(height: 28.h),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    "Whats your Date of Birth",
                    style: getTextStyle(),
                  ),
                ),
                SizedBox(height: 27.h),
                TextFormField(
                  controller: _dobController,
                  readOnly: true,
                  decoration: getDecoration(hintText: 'DD-MM-YYYY'),
                  onTap: _pickDateOfBirth,
                  validator: (value) {
                    if (_dateOfBirth == null) {
                      return 'Please select your date of birth';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 28.h),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    "Whats your Gender",
                    textAlign: TextAlign.left,
                    style: getTextStyle(),
                  ),
                ),
                SizedBox(height: 15.h),

                FormField<Gender>(
                  validator: (value) {
                    if (_gender == null) {
                      return 'Please select a gender';
                    }
                    return null;
                  },
                  builder: (field) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: RadioListTile<Gender>(
                                title: const Text("Male"),
                                value: Gender.male,
                                groupValue: _gender,
                                onChanged: (value) {
                                  setState(() => _gender = value);
                                  field.didChange(value);
                                },
                              ),
                            ),
                            Expanded(
                              child: RadioListTile<Gender>(
                                title: const Text("Female"),
                                value: Gender.female,
                                groupValue: _gender,
                                onChanged: (value) {
                                  setState(() => _gender = value);
                                  field.didChange(value);
                                },
                              ),
                            ),
                          ],
                        ),
                        if (field.hasError)
                          Padding(
                            padding: EdgeInsets.only(left: 12.w, top: 4.h),
                            child: Text(
                              field.errorText!,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.error,
                                fontSize: 12.sp,
                              ),
                            ),
                          ),
                      ],
                    );
                  },
                ),

                SizedBox(height: 27.h),
                SizedBox(
                  width: double.infinity,
                  child: Text("Whats your Nationality", style: getTextStyle()),
                ),
                SizedBox(height: 20.h),
                DropdownButtonFormField<String>(
                  initialValue: _nationality,
                  items: _nationalityOptions
                      .map(
                        (country) => DropdownMenuItem(
                          value: country,
                          child: Text(country),
                        ),
                      )
                      .toList(),
                  onChanged: (value) => setState(() => _nationality = value),
                  decoration: getDecoration(hintText: "Select Nationality"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select your nationality';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 27.h),
                SizedBox(
                  width: double.infinity,
                  child: Text("Languages spoken", style: getTextStyle()),
                ),
                SizedBox(height: 20.h),
                FormField<List<String>>(
                  validator: (value) {
                    if (_languages.isEmpty) {
                      return 'Please select at least one language';
                    }
                    return null;
                  },
                  builder: (field) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: _pickLanguages,
                          child: InputDecorator(
                            decoration:
                                getDecoration(
                                  hintText: "Select Language",
                                ).copyWith(
                                  errorText: field.hasError
                                      ? field.errorText
                                      : null,
                                ),
                            child: Text(
                              _languages.isEmpty ? '' : _languages.join(', '),
                              style: getTextStyle(),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),

                SizedBox(height: 27.h),
                SizedBox(
                  width: double.infinity,
                  height: 50.h,
                  child: ElevatedButton(
                    onPressed: isLoading ? null : _handleSave,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0E7C66),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14.r),
                      ),
                    ),
                    child: isLoading
                        ? SizedBox(
                            width: 22.w,
                            height: 22.w,
                            child: const CircularProgressIndicator(
                              strokeWidth: 2.5,
                              color: Colors.white,
                            ),
                          )
                        : Text(
                            "Save",
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                  ),
                ),
                SizedBox(height: 27.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

InputDecoration getDecoration({required String hintText}) {
  return InputDecoration(
    hintText: hintText,
    filled: true,
    fillColor: const Color(0xFFF5F5F5),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide.none,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide.none,
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide.none,
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide.none,
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
  );
}

TextStyle getTextStyle({FontWeight? fontWeight}) {
  return TextStyle(
    fontSize: 13.sp,
    fontWeight: fontWeight ?? FontWeight.normal,
    fontFamily: GoogleFonts.outfit().fontFamily,
  );
}
