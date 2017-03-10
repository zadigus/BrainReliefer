#! /bin/bash

cd logic/Data

$LIBRARIES/xsde/linux/bin/xsde cxx-hybrid --generate-parser --generate-serializer --generate-aggregate --ixx-suffix .ipp --hxx-suffix .hpp --cxx-suffix .cpp --root-element-last --namespace-map "=N_Data" --suppress-parser-val IntrantsList.xsd
