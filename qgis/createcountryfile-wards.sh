#!/bin/bash

echo "const countryCodesWithImage = ["
while read line
do
    # E05000026|Abbey|E09000002|Barking and Dagenham|0.07769926805400545|51.539959875294976
    wardid=`echo $line | awk -F"|" {'print tolower($1)'}`
    wardname=`echo $line | awk -F"|" {'print $2'}`
    laid=`echo $line | awk -F"|" {'print tolower($3)'}`
    laname=`echo $line | awk -F"|" {'print $4'}`
    lon=`echo $line | awk -F"|" {'print $5'}`
    lat=`echo $line | awk -F"|" {'print $6'}`
    echo "  \"$wardid\","
done < wards.psv
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
    wardid=`echo $line | awk -F"|" {'print tolower($1)'}`
    wardname=`echo $line | awk -F"|" {'print $2'}`
    laid=`echo $line | awk -F"|" {'print tolower($3)'}`
    laname=`echo $line | awk -F"|" {'print $4'}`
    lon=`echo $line | awk -F"|" {'print $5'}`
    lat=`echo $line | awk -F"|" {'print $6'}`
    echo "  {
    code: \"$wardid\",
    latitude: $lat,
    longitude: $lon,
    name: \"$wardname ($laname)\",
  },"
done < wards.psv
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
