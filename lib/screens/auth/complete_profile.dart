import 'package:easy_localization/easy_localization.dart';
import 'package:farmer/model/result.dart';
import 'package:farmer/profile_image.dart';
import 'package:farmer/widgets/custome_dropdown.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../import.dart';

class CompleteProfile extends StatefulWidget {
  final String uid;
  final String mobile;
  const CompleteProfile({Key? key, required this.uid, required this.mobile})
      : super(key: key);

  @override
  createState() => _CompleteProfileState();
}

class _CompleteProfileState extends State<CompleteProfile> {
  final appCtrl = Get.find<AppController>();
  final formState = GlobalKey<FormState>();
  final nameCtrl = TextEditingController();
  final mobileCtrl = TextEditingController();
  final stateCtrl = TextEditingController();
  final regionCtrl = TextEditingController();
  final districtCtrl = TextEditingController();
  final aadharCtrl = TextEditingController();
  final addressCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();

  final orgNameCtrl = TextEditingController();
  final orgAddressCtrl = TextEditingController();
  final orgWebsiteCtrl = TextEditingController();
  final orgEmailCtrl = TextEditingController();

  final RxString stateID = "".obs;
  final RxString regionID = "".obs;
  final RxString districtID = "".obs;
  final RxBool hasDistillationUnit = false.obs;

  List state = [];
  List region = [];
  List district = [];

  @override
  initState() {
    super.initState();
    mobileCtrl.text = widget.mobile;
    getLocations();
  }

  getLocations() {
    DBServices.call.location().then((Result result) {
      setState(() {
        state = result.data["state"];
        region = result.data["region"];
        district = result.data["city"];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          tr("complete_profile.title"),
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
        ),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 0,
              child: Opacity(
                opacity: 0.08,
                child: Image.asset(
                  "assets/profile_bg.png",
                  width: 100.w,
                ),
              ),
            ),
            GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    key: formState,
                    child: Column(
                      children: [
                        AppTextFormField(
                          title: tr("complete_profile.tb_name"),
                          controller: nameCtrl,
                          onValidate: validate.requireValidation,
                        ),
                        AppDropdown(
                          title: tr("complete_profile.dd_state"),
                          controller: stateCtrl,
                          list: state,
                          displayField: "state_name",
                          filter: (value) => true,
                          onValidate: validate.requireValidation,
                          onChanged: (value) {
                            stateID.value = value["pk_utm_state_id"].toString();
                          },
                        ),
                        // AppDropdown(
                        //   title: tr("complete_profile.dd_region"),
                        //   controller: regionCtrl,
                        //   list: region,
                        //   displayField: "region_name",
                        //   filter: (value) => true,
                        //   onValidate: validate.requireValidation,
                        //   onChanged: (value) {
                        //     regionID.value =
                        //         value["pk_utm_region_id"].toString();
                        //   },
                        // ),
                        AppDropdown(
                          title: tr("complete_profile.dd_district"),
                          controller: districtCtrl,
                          list: district,
                          displayField: "city_name",
                          filter: (value) =>
                              value["fk_utm_state_id"].toString() ==
                              stateID.value.toString(),
                          onValidate: validate.requireValidation,
                          onChanged: (value) {
                            districtID.value =
                                value["pk_utm_city_id"].toString();
                          },
                        ),
                        AppTextFormField(
                          title: tr("complete_profile.tb_aadhar"),
                          controller: aadharCtrl,
                        ),
                        if (appCtrl.selectedUserType.value.toLowerCase() ==
                            "buyer")
                          Column(
                            children: [
                              AppTextFormField(
                                title: tr("complete_profile.tb_org_name"),
                                controller: orgNameCtrl,
                                onValidate: validate.requireValidation,
                              ),
                              AppTextFormField(
                                title: tr("complete_profile.tb_org_address"),
                                controller: orgAddressCtrl,
                                onValidate: validate.requireValidation,
                              ),
                              AppTextFormField(
                                title: tr("complete_profile.tb_org_website"),
                                controller: orgWebsiteCtrl,
                              ),
                              AppTextFormField(
                                title: tr("complete_profile.tb_org_email"),
                                controller: orgEmailCtrl,
                              ),
                            ],
                          ),
                        Obx(
                          () => CheckboxListTile(
                              controlAffinity: ListTileControlAffinity.leading,
                              value: hasDistillationUnit.value,
                              title: Text(tr(
                                  "complete_profile.tb_has_distillation_unit")),
                              onChanged: (value) =>
                                  hasDistillationUnit.value = value ?? false),
                        ),
                        Obx(
                          () => hasDistillationUnit.value
                              ? AppTextFormField(
                                  title: tr("complete_profile.tb_address"),
                                  controller: addressCtrl,
                                )
                              : const SizedBox(),
                        ),
                        AppTextFormField(
                          title: "Password",
                          obscureText: true,
                          controller: passwordCtrl,
                          onValidate: validate.requireValidation,
                        ),
                        Row(
                          children: [
                            // AppSmallElevatedButton(
                            //   tr("complete_profile.btn_update"),
                            //   () => Get.to(const ProfileImage()),
                            // ),
                            SizedBox(width: 2.w),
                            AppElevatedButton(
                              tr("complete_profile.btn_update"),
                              () => onSave(),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  onSave() async {
    formState.currentState!.save();
    if (formState.currentState!.validate()) {
      dynamic data = {
        "firebase_uid": widget.uid,
        "mobile_number": mobileCtrl.text,
        "prefered_language": appCtrl.selectedLanguage.value,
        "customer_type": appCtrl.selectedUserType.value,
        "customer_name": nameCtrl.text,
        "state_id": stateID.value,
        "city_id": districtID.value,
        "region_id": regionID.value,
        "aadhar_no": aadharCtrl.text,
        "has_distillation_unit": hasDistillationUnit.value ? 1 : 0,
        "distillation_unit_address": addressCtrl.text,
        "org_address": orgAddressCtrl.text,
        "org_name": orgNameCtrl.text,
        "org_email": orgEmailCtrl.text,
        "org_website": orgWebsiteCtrl.text,
        "password": passwordCtrl.text,
      };
      Result result = await DBServices.call.addUser(data);
      if (result.status) {
        var user = FirebaseAuth.instance.currentUser;
        user?.updateDisplayName(nameCtrl.text);
        await StorageService.to.write("id", result.data);
        Get.off(ProfileImage(id: result.data));
      } else {
        utility.showSnackbar(title: "Error", message: result.message);
      }
    }
  }
}
