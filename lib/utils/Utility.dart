import 'package:intl/intl.dart';

class Utility {
  static final String mapBoxAccessToken =
      "pk.eyJ1IjoiaXJobnZpc2l0IiwiYSI6ImNqcnB6YTVjZDEyOG80OXBzb2JwZHY1ZTIifQ.HacauZ6ID0KQOGkksgNs1w";

  static String convertNumberPr(String num) {
    return num.replaceAll("1", "۱")
        .replaceAll("2", "۲")
        .replaceAll("3", "۳")
        .replaceAll("4", "۴")
        .replaceAll("5", "۵")
        .replaceAll("6", "۶")
        .replaceAll("7", "۷")
        .replaceAll("8", "۸")
        .replaceAll("9", "۹")
        .replaceAll("0", "۰");
  }

  static String convertMoney(String num) {
    final formatter = new NumberFormat("###,###");
    return convertNumberPr(formatter.format(double.parse(num)));
  }

  static String latLangConverter(double latitude, double longitude, int height, int width, int zoom) {
    String key = "service.Rle1X6qFrUkQJ5KgVjTVtqaj3GRwYjCNYCc5TZp1";
    String url = "https://api.neshan.org/v2/static?key=" + key +
        "&type=standard-day&zoom=$zoom&center=$latitude,$longitude&width=$width&height=$height&marker=red";
    return url;
  }

  static List<String> getVision(String value) {
    List<String> items = new List();

    if (value.contains("darya")) items.add("دریا");

    if (value.contains("jangal")) items.add("جنگل");

    if (value.contains("koohestan")) items.add("کوهستان");

    if (value.contains("koohpaye")) items.add("کوهپایه");

    if (value.contains("daryache")) items.add("دریاچه");

    if (value.contains("roodkhane")) items.add("رودخانه");

    if (value.contains("shahr")) items.add("شهر");

    if (value.contains("roosta")) items.add("روستا");

    return _sort(items);
  }

  static List<String> getVillaType(String value) {
    List<String> items = new List();

    if (value.contains("estakhrDar")) items.add("استخردار");

    if (value.contains("nazdikeDarya")) items.add("نزدیک دریا");

    if (value.contains("jangali")) items.add("جنگلی");

    if (value.contains("yeylaghi-koohestani")) items.add("ییلاقی - کوهستانی");

    if (value.contains("chasbideBeDarya")) items.add("چسبیده به دریا");

    return _sort(items);
  }

  static List<String> getVillaSecurity(String value) {
    List<String> items = new List();

    if (value.contains("dakheleShahrak")) items.add("داخل شهرک");

    if (value.contains("darbast")) items.add("دربست");

    if (value.contains("gheireDarbast")) items.add("غیر دربست");

    if (value.contains("seraydari")) items.add("دارای سرایدار");

    return _sort(items);
  }

  static List<String> getWelfareAmenities(String value) {
    List<String> items = new List();

    if (value.contains("ps-xbox")) items.add("کنسول بازی");

    if (value.contains("mobl")) items.add("مبلمان");

    if (value.contains("mizeNaharKhori")) items.add("میز نهارخوری");

    if (value.contains("tv")) items.add("تلوزیون");

    if (value.contains("anten")) items.add("آنتن");

    if (value.contains("internet")) items.add("اینترنت");

    if (value.contains("asansor")) items.add("آسانسور");

    if (value.contains("sistemSoti")) items.add("سیستم صوتی");

    if (value.contains("jarooBarghi")) items.add("جارو برقی");

    if (value.contains("otoo")) items.add("اتو");

    if (value.contains("cabinet")) items.add("کابینت");

    if (value.contains("zoroofAshpazkhoone")) items.add("ظروف آشپزخانه");

    if (value.contains("yakhchal")) items.add("یخچال");

    if (value.contains("mashinZarfShooie")) items.add("ماشین ظرفشویی");

    if (value.contains("mashinLebasShooie")) items.add("ماشین لباس شویی");

    if (value.contains("microfer")) items.add("مایکروفر");

    if (value.contains("chaiSaz")) items.add("چایی ساز");

    if (value.contains("dastgahTasfieAbKhanegi"))
      items.add("دستگاه تصویه آب خانگی");

    if (value.contains("takht-servicKhab")) items.add("تخت و سرویس خواب");

    if (value.contains("hamam")) items.add("حمام");

    if (value.contains("servicBehdashtiFarangi"))
      items.add("سرویس بهداشتی فرنگی");

    if (value.contains("servicBehdashtiIrani"))
      items.add("سرویس بهداشتی ایرانی");

    if (value.contains("estakhreSarPooshide")) items.add("استخر سر پوشیده");

    if (value.contains("sona")) items.add("سونا");

    if (value.contains("jacoozi")) items.add("جکوزی");

    if (value.contains("estakhreRooBaz")) items.add("استخر روباز");

    if (value.contains("doosheDakhelHayat")) items.add("دوش داخل حیاط");

    if (value.contains("vasayeleBadanSazi")) items.add("وسایل بدنسازی");

    if (value.contains("sandaliMasajor")) items.add("صندلی ماساژور");

    if (value.contains("mizeBiliard")) items.add("میز بیلیارد");

    if (value.contains("mizePingPong")) items.add("میز پینگ پنگ");

    if (value.contains("footbalDasti")) items.add("فوتبال دستی");

    if (value.contains("takhteNard")) items.add("تخته نرد");

    if (value.contains("mizeShatranj")) items.add("میز شطرنج");

    if (value.contains("zaminValibal")) items.add("زمین والیبال");

    if (value.contains("zaminFootbal")) items.add("زمین فوتبال");

    if (value.contains("zaminTenis")) items.add("زمین تنیس");

    if (value.contains("zaminBadminton")) items.add("زمین بدمینتن");

    if (value.contains("mohavateBaziKoodakan")) items.add("محوطه بازی کودکان");

    if (value.contains("taras-balkon")) items.add("تراس - بالکن");

    if (value.contains("parking")) items.add("پارکینگ");

    if (value.contains("hayat")) items.add("حیاط");

    if (value.contains("fazayeSabz")) items.add("فضای سبز");

    if (value.contains("alachigh")) items.add("آلاچیق");

    if (value.contains("barbeque")) items.add("باربکیو");

    if (value.contains("abNama")) items.add("آب نما");

    if (value.contains("coolerSpilit")) items.add("کولر اسپلیت");

    if (value.contains("coolerGaziPanjereie")) items.add("کولر گازی پنجره ای");

    if (value.contains("coolerAbi")) items.add("کولر آبی");

    if (value.contains("pankeSaghfi")) items.add("پنکه سقفی");

    if (value.contains("bokhariGazi")) items.add("بخاری گازی");

    if (value.contains("shoofazh")) items.add("شوفاژ");

    if (value.contains("packageDivari")) items.add("پکیج دیواری");

    if (value.contains("shoomine")) items.add("شومینه");

    if (value.contains("ojaghGas")) items.add("اجاق گاز");

    if (value.contains("seshoar")) items.add("سشوار");

    return _sort(items);
  }

  static List<String> _sort(List<String> list){
    list.sort();
    return list;
  }

  static List<String> getListDaysStay() {
    List<String> items = new List();

    items.add("انتخاب مدت اقامت");

    for(var i = 1;i<= 19;i++){
      items.add("مدت $i شب");
    }

    items.add("مدت ۲۰ شب و بیشتر");

    return items;
  }

  static List<String> getListCountPeople() {
    List<String> items = new List();

    items.add("انتخاب تعداد نفرات");

    for(var i = 1;i<= 19;i++){
      items.add("$i نفر");
    }

    items.add("۲۰ نفر و بیشتر");

    return items;
  }

}
