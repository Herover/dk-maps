# About
A script for downloading the administrative boundaries of Denmark in a
automatic way. The project was made because the WFS Dataforsyningen and
Datafordeleren was hard to get working correctly in QGIS.

The script will produce a GML file with all layers, and GeoJSON and SVG files
for each layer.

The scripts are specifically for DAGI ([https://dataforsyningen.dk/data/3559](
Danmark Administrative Geografiske Inddeling)) but it should be possible to
adjust for other datasets.

# Use
**nodejs** and **GDAL** (specifically ogr2ogr with WFS, GML and GeoJSON
support) is required.

Run the script with
`$ ./run.sh "http://api.dataforsyningen.dk/DAGI_2000MULTIGEOM_GMLSFP_DAF?NAMESPACES=xmlns(dagi,http://data.gov.dk/schemas/dagi/2/gml3sfp)&token=your-token-here"`
where `your-token-here` is your secret token on dataforsyningen.dk.

The `NAMESPACES` parameter is required since ogr2ogr and Dataforsyningens WFS
server seems to disagree on how to use namespaces.

# License
MIT
