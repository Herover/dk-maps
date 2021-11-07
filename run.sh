#!/usr/bin/env bash
url=$2

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
    folder=${2}
    mkdir -p "${outDir}${folder}/${key}"
    mkdir -p "${tmpDir}${folder}/${key}"
    ogr2ogr -f GeoJSON -lco RFC7946=YES -t_srs EPSG:4326 -s_srs EPSG:25832 "${outDir}${folder}/${key}/${key}.json" "${tmpDir}dagi.gml" "dagi_${key^}"
    npx geoproject "$projection" < "${outDir}${folder}/${key}/${key}.json" > "${tmpDir}${folder}/${key}/${key}.json" && \
    npx geo2svg -w 650 -h 500 < "${tmpDir}${folder}/${key}/${key}.json" > "${outDir}${folder}/${key}/${key}.svg"
}

process "Afstemningsomraade" $1
process "Kommuneinddeling" $1
process "Landsdel" $1
process "Menighedsraadsafstemningsomraade" $1
process "Opstillingskreds" $1
process "Politikreds" $1
process "Postnummerinddeling" $1
process "Regionsinddeling" $1
process "Retskreds" $1
process "Samlepostnummer" $1
process "Sogneinddeling" $1
process "Storkreds" $1
process "SupplerendeBynavn" $1
