cd logic\Data

xsd cxx-tree --generate-serialization --std c++11 --hxx-suffix ".hpp" --cxx-suffix ".cpp" --root-element-last --namespace-map "=N_Data" Data.xsd 
xsd cxx-tree --generate-serialization --std c++11 --hxx-suffix ".hpp" --cxx-suffix ".cpp" --root-element-last --namespace-map "=N_Data" IntrantList.xsd 
