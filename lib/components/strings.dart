RegExp emailRexExp = RegExp(r'^[\w-\.]+@([\w-]+.)+[\w-]{2,4}$');

RegExp passwordRexExp = RegExp(
    r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~`)\%\-(_+=;:,.<>/?"[{\]}\|^]).{8,}$');

RegExp specialCharRexExp =
    RegExp(r'^(?=.*?[!@#$&*~`)\%\-(_+=;:,.<>/?"[{\]}\|^])');

String tourPlanImage = "assets/tour_plan_image.png";

const String gmapsApiKey = "AIzaSyAgLFO4XZ0S8ywCdBsOdNh1tDtv3dlPMOE";
