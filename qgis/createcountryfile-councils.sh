#!/bin/bash

echo "const countryCodesWithImage = ["
while read line
do
    # laid|laname|longitude|latitude
    laid=`echo $line | awk -F"|" {'print tolower($1)'}`
    laname=`echo $line | awk -F"|" {'print $2'}`
    lon=`echo $line | awk -F"|" {'print $3'}`
    lat=`echo $line | awk -F"|" {'print $4'}`
    echo "  \"$laid\","
done < LAs.psv
echo "];"

echo "export interface Country {
  code: string;
  latitude: number;
  longitude: number;
  name: string;
}"

echo "export const countries: Country[] = ["
while read line
do
    # laid|laname|longitude|latitude
    laid=`echo $line | awk -F"|" {'print $1'}`
    laname=`echo $line | awk -F"|" {'print $2'}`
    lon=`echo $line | awk -F"|" {'print $3'}`
    lat=`echo $line | awk -F"|" {'print $4'}`
    echo "  {
    code: \"$laid\",
    latitude: $lat,
    longitude: $lon,
    name: \"$laname\",
  },"
done < LAs.psv
echo "];"

echo "export const countriesWithImage = countries.filter((c) =>
  countryCodesWithImage.includes(c.code.toLowerCase())
);"

echo "
export function getCountryName(language: string, country: Country) {
  return country.name;
}

export function sanitizeCountryName(countryName: string): string {
  return countryName
    .normalize(\"NFD\")
    .replace(/[\u0300-\u036f]/g, \"\")
    .replace(/[- '()]/g, \"\")
    .toLowerCase();
}"
