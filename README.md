This repository contains data from Styrelsen for Dataforsyning og
Effektivisering. If you use data from here you must follow their
[terms](https://dataforsyningen.dk/asset/PDF/rettigheder_vilkaar/Vilk%C3%A5r%20for%20brug%20af%20frie%20geografiske%20data.pdf)
and attribute them.

# About
A script for downloading the administrative boundaries of Denmark in a
automatic way. The project was made because the WFS Dataforsyningen and
Datafordeleren was hard to get working correctly in QGIS.

If you just want the DAGI files you can review the 1:2 000 000 files directly
in this [repo](https://github.com/Herover/dk-maps/tree/main/out/dagi2000) or
download more variants on the [release page](https://github.com/Herover/dk-maps/releases).

The script will produce a GML file with all layers, and GeoJSON and SVG files
for each layer.

The scripts are specifically for DAGI ([Danmarks Administrative Geografiske Inddeling](
https://dataforsyningen.dk/data/3559)) but it should be possible to
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
Code: MIT

Data: https://dataforsyningen.dk/asset/PDF/rettigheder_vilkaar/Vilk%C3%A5r%20for%20brug%20af%20frie%20geografiske%20data.pdf
