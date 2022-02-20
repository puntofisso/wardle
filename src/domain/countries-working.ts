// Source:
// Countries with long/lat => https://developers.google.com/public-data/docs/canonical/countries_csv
// Countries images => https://github.com/djaiss/mapsicon

const countryCodesWithImage = ["e06000001", "e06000002", "e06000003"];

export interface Country {
  code: string;
  latitude: number;
  longitude: number;
  name: string;
}

export const countries: Country[] = [
  {
    code: "E06000001",
    latitude: 54.669024195334906,
    longitude: -1.2556649025120736,
    name: "Hartlepool",
  },
  {
    code: "E06000002",
    latitude: 54.54248982351388,
    longitude: -1.2224442845221546,
    name: "Middlesbrough",
  },
  {
    code: "E06000003",
    latitude: 54.55362675685401,
    longitude: -1.0216621755367932,
    name: "Redcar and Cleveland",
  },
];

export const countriesWithImage = countries.filter((c) =>
  countryCodesWithImage.includes(c.code.toLowerCase())
);

export function getCountryName(language: string, country: Country) {
  return country.name;
}

export function sanitizeCountryName(countryName: string): string {
  return countryName
    .normalize("NFD")
    .replace(/[\u0300-\u036f]/g, "")
    .replace(/[- '()]/g, "")
    .toLowerCase();
}
