#!/usr/bin/env bash
url=$1

projection="d3.geoMercator().center([13.5, 56.2]).scale(4900)"

# This is needed in case someone runs the script from a different directory
# than the script directory so we don't delete random files.
# https://stackoverflow.com/questions/59895/how-can-i-get-the-source-directory-of-a-bash-script-from-within-the-script-itsel
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

tmpDir="$SCRIPT_DIR/tmp/"
outDir="$SCRIPT_DIR/out/"

(cd $SCRIPT_DIR; npm install)

# Clean directories
#rm $tmpDir*
rm -rf $outDir

if [ ! -f "${outDir}" ]
then
    mkdir $outDir
fi
if [ ! -f "${tmpDir}" ]
then
    mkdir $tmpDir
fi

# Download GML from WFS
if [ ! -f "${tmpDir}dagi.gml" ]
then
    ogr2ogr -f GML "${tmpDir}dagi.gml" "WFS:$url"
fi

cp $tmpDir"dagi.gml" ${outDir}
cp $tmpDir"dagi.xsd" ${outDir}

function process () {
    key=${1,}
    mkdir "${outDir}${key}"
    mkdir "${tmpDir}${key}"
    ogr2ogr -f GeoJSON -lco RFC7946=YES -t_srs EPSG:4326 -s_srs EPSG:25832 "${outDir}${key}/dagi-${key}.json" "${tmpDir}dagi.gml" "dagi_${key^}"
    npx geoproject "$projection" < "${outDir}${key}/dagi-${key}.json" > "${tmpDir}${key}/dagi-${key}.json" && \
    npx geo2svg -w 650 -h 500 < "${tmpDir}${key}/dagi-${key}.json" > "${outDir}${key}/dagi-${key}.svg"
}

process "Afstemningsomraade"
process "Kommuneinddeling"
process "Landsdel"
process "Menighedsraadsafstemningsomraade"
process "Opstillingskreds"
process "Politikreds"
process "Postnummerinddeling"
process "Regionsinddeling"
process "Retskreds"
process "Samlepostnummer"
process "Sogneinddeling"
process "Storkreds"
process "SupplerendeBynavn"
