cd logic\Data

xsd cxx-tree --generate-serialization --std c++11 --hxx-suffix ".hpp" --cxx-suffix ".cpp" --root-element-last --namespace-map "=N_Data" Data.xsd 
xsd cxx-tree --generate-serialization --std c++11 --hxx-suffix ".hpp" --cxx-suffix ".cpp" --root-element-last --namespace-map "=N_Data" IntrantList.xsd 
xsd cxx-tree --generate-serialization --std c++11 --hxx-suffix ".hpp" --cxx-suffix ".cpp" --root-element-last --namespace-map "=N_ApplicationData" Application.xsd 

pause


rem ~/Downloads/xsde-linux/xsde/xsde/xsde cxx-hybrid --generate-parser --generate-serializer --generate-aggregate --ixx-suffix .ipp --hxx-suffix .hpp --cxx-suffix .cpp --root-element-last --namespace-map "=N_ApplicationData" Application.xsd
