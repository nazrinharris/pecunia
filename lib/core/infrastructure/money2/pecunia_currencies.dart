import 'package:money2/money2.dart';

class PecuniaCurrencies {
  static final Currency xxx = Currency.create(
    'XXX',
    2,
    country: 'No Currency',
    name: 'No Currency',
  );
  static final Currency usd = Currency.create(
    'USD',
    2,
    country: 'United States of America',
    name: 'US Dollar',
  );
  static final Currency eur = Currency.create(
    'EUR',
    2,
    country: 'European Union',
    name: 'Euro',
  );
  static final Currency gbp = Currency.create(
    'GBP',
    2,
    country: 'United Kingdom',
    name: 'Pound Sterling',
  );
  static final Currency jpy = Currency.create(
    'JPY',
    0,
    country: 'Japan',
    name: 'Japanese Yen',
  );
  static final Currency aud = Currency.create(
    'AUD',
    2,
    country: 'Australia',
    name: 'Australian Dollar',
  );
  static final Currency cad = Currency.create(
    'CAD',
    2,
    country: 'Canada',
    name: 'Canadian Dollar',
  );
  static final Currency chf = Currency.create(
    'CHF',
    2,
    country: 'Switzerland',
    name: 'Swiss Franc',
  );
  static final Currency cny = Currency.create(
    'CNY',
    2,
    country: 'China',
    name: 'Chinese Yuan',
  );
  static final Currency hkd = Currency.create(
    'HKD',
    2,
    country: 'Hong Kong',
    name: 'Hong Kong Dollar',
  );
  static final Currency nzd = Currency.create(
    'NZD',
    2,
    country: 'New Zealand',
    name: 'New Zealand Dollar',
  );
  static final Currency sek = Currency.create(
    'SEK',
    2,
    country: 'Sweden',
    name: 'Swedish Krona',
  );
  static final Currency krw = Currency.create(
    'KRW',
    0,
    country: 'South Korea',
    name: 'South Korean Won',
  );
  static final Currency sgd = Currency.create(
    'SGD',
    2,
    country: 'Singapore',
    name: 'Singapore Dollar',
  );
  static final Currency nok = Currency.create(
    'NOK',
    2,
    country: 'Norway',
    name: 'Norwegian Krone',
  );
  static final Currency mxn = Currency.create(
    'MXN',
    2,
    country: 'Mexico',
    name: 'Mexican Peso',
  );
  static final Currency inr = Currency.create(
    'INR',
    2,
    country: 'India',
    name: 'Indian Rupee',
  );
  static final Currency rub = Currency.create(
    'RUB',
    2,
    country: 'Russia',
    name: 'Russian Ruble',
  );
  static final Currency zar = Currency.create(
    'ZAR',
    2,
    country: 'South Africa',
    name: 'South African Rand',
  );
  static final Currency try_ = Currency.create(
    'TRY',
    2,
    country: 'Turkey',
    name: 'Turkish Lira',
  );
  static final Currency brl = Currency.create(
    'BRL',
    2,
    country: 'Brazil',
    name: 'Brazilian Real',
  );
  static final Currency twd = Currency.create(
    'TWD',
    2,
    country: 'Taiwan',
    name: 'New Taiwan Dollar',
  );
  static final Currency dkk = Currency.create(
    'DKK',
    2,
    country: 'Denmark',
    name: 'Danish Krone',
  );
  static final Currency pln = Currency.create(
    'PLN',
    2,
    country: 'Poland',
    name: 'Polish Zloty',
  );
  static final Currency thb = Currency.create(
    'THB',
    2,
    country: 'Thailand',
    name: 'Thai Baht',
  );
  static final Currency idr = Currency.create(
    'IDR',
    2,
    country: 'Indonesia',
    name: 'Indonesian Rupiah',
  );
  static final Currency huf = Currency.create(
    'HUF',
    2,
    country: 'Hungary',
    name: 'Hungarian Forint',
  );
  static final Currency czk = Currency.create(
    'CZK',
    2,
    country: 'Czech Republic',
    name: 'Czech Koruna',
  );
  static final Currency myr = Currency.create(
    'MYR',
    2,
    country: 'Malaysia',
    name: 'Malaysian Ringgit',
  );
  static final Currency sar = Currency.create(
    'SAR',
    2,
    country: 'Saudi Arabia',
    name: 'Saudi Riyal',
  );
  static final Currency ars = Currency.create(
    'ARS',
    2,
    country: 'Argentina',
    name: 'Argentine Peso',
  );
  static final Currency ils = Currency.create(
    'ILS',
    2,
    country: 'Israel',
    name: 'Israeli New Shekel',
  );
  static final Currency php = Currency.create(
    'PHP',
    2,
    country: 'Philippines',
    name: 'Philippine Peso',
  );
  static final Currency pkr = Currency.create(
    'PKR',
    2,
    country: 'Pakistan',
    name: 'Pakistani Rupee',
  );
  static final Currency egp = Currency.create(
    'EGP',
    2,
    country: 'Egypt',
    name: 'Egyptian Pound',
  );
  static final Currency cop = Currency.create(
    'COP',
    2,
    country: 'Colombia',
    name: 'Colombian Peso',
  );
  static final Currency irr = Currency.create(
    'IRR',
    2,
    country: 'Iran',
    name: 'Iranian Rial',
  );
  static final Currency clp = Currency.create(
    'CLP',
    0,
    country: 'Chile',
    name: 'Chilean Peso',
  );
  static final Currency pen = Currency.create(
    'PEN',
    2,
    country: 'Peru',
    name: 'Peruvian Sol',
  );

  static List<Currency> toList() {
    return [
      xxx,
      usd,
      eur,
      gbp,
      jpy,
      aud,
      cad,
      chf,
      cny,
      hkd,
      nzd,
      sek,
      krw,
      sgd,
      nok,
      mxn,
      inr,
      rub,
      zar,
      try_,
      brl,
      twd,
      dkk,
      pln,
      thb,
      idr,
      huf,
      czk,
      myr,
      sar,
      ars,
      ils,
      php,
      pkr,
      egp,
      cop,
      irr,
      clp,
      pen,
    ];
  }

  static Currency fromString(String code) {
    return toList().firstWhere(
      (c) => c.isoCode == code,
      orElse: () => throw Exception('Invalid currency code: $code'),
    );
  }
}
