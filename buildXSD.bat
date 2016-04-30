cd Data

xsd cxx-tree --generate-serialization --std c++11 --hxx-suffix ".hpp" --cxx-suffix ".cpp" --root-element-last --namespace-map "http://www.brainreliefer.ch/Data=N_Data" Data.xsd 
