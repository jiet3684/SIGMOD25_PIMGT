#!/bin/bash

mkdir dataset
cd dataset

wget https://suitesparse-collection-website.herokuapp.com/MM/DIMACS10/delaunay_n18.tar.gz
tar -zxvf delaunay_n18.tar.gz
mv delaunay_n18/delaunay_n18.mtx .
rm -r delaunay_n18 delaunay_n18.tar.gz

wget https://suitesparse-collection-website.herokuapp.com/MM/QLi/largebasis.tar.gz
tar -zxvf largebasis.tar.gz
mv largebasis/largebasis.mtx .
rm -r largebasis largebasis.tar.gz

wget https://suitesparse-collection-website.herokuapp.com/MM/GHS_indef/mario001.tar.gz
tar -zxvf mario001.tar.gz
mv mario001/mario001.mtx .
rm -r mario001 mario001.tar.gz

wget https://suitesparse-collection-website.herokuapp.com/MM/GHS_indef/mario002.tar.gz
tar -zxvf mario002.tar.gz
mv mario002/mario002.mtx .
rm -r mario002 mario002.tar.gz

wget https://suitesparse-collection-website.herokuapp.com/MM/Sandia/ASIC_320ks.tar.gz
tar -zxvf ASIC_320ks.tar.gz
mv ASIC_320ks/ASIC_320ks.mtx .
rm -r ASIC_320ks ASIC_320ks.tar.gz

wget https://suitesparse-collection-website.herokuapp.com/MM/SNAP/amazon0302.tar.gz
tar -zxvf amazon0302.tar.gz
mv amazon0302/amazon0302.mtx .
rm -r amazon0302 amazon0302.tar.gz

wget https://suitesparse-collection-website.herokuapp.com/MM/Barabasi/NotreDame_www.tar.gz
tar -zxvf NotreDame_www.tar.gz
mv NotreDame_www/NotreDame_www.mtx .
rm -r NotreDame_www NotreDame_www.tar.gz

wget https://suitesparse-collection-website.herokuapp.com/MM/HVDC/hvdc2.tar.gz
tar -zxvf hvdc2.tar.gz
mv hvdc2/hvdc2.mtx .
rm -r hvdc2 hvdc2.tar.gz

wget https://suitesparse-collection-website.herokuapp.com/MM/VLSI/ss1.tar.gz
tar -zxvf ss1.tar.gz
mv ss1/ss1.mtx .
rm -r ss1 ss1.tar.gz

wget https://suitesparse-collection-website.herokuapp.com/MM/Hamm/scircuit.tar.gz
tar -zxvf scircuit.tar.gz
mv scircuit/scircuit.mtx .
rm -r scircuit scircuit.tar.gz

wget https://suitesparse-collection-website.herokuapp.com/MM/DIMACS10/coAuthorsCiteseer.tar.gz
tar -zxvf coAuthorsCiteseer.tar.gz
mv coAuthorsCiteseer/coAuthorsCiteseer.mtx .
rm -r coAuthorsCiteseer coAuthorsCiteseer.tar.gz

wget https://suitesparse-collection-website.herokuapp.com/MM/Pajek/patents_main.tar.gz
tar -zxvf patents_main.tar.gz
mv patents_main/patents_main.mtx .
rm -r patents_main patents_main.tar.gz

wget https://suitesparse-collection-website.herokuapp.com/MM/GHS_indef/darcy003.tar.gz
tar -zxvf darcy003.tar.gz
mv darcy003/darcy003.mtx .
rm -r darcy003 darcy003.tar.gz

wget https://suitesparse-collection-website.herokuapp.com/MM/Botonakis/thermomech_dM.tar.gz
tar -zxvf thermomech_dM.tar.gz
mv thermomech_dM/thermomech_dM.mtx .
rm -r thermomech_dM thermomech_dM.tar.gz
