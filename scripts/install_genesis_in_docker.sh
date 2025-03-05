readonly RED='\033[1;31m'
readonly GREEN='\033[0;32m'
readonly RESET_COLOR='\e[0m'

(cd ../
git submodule update --init --recursive)

# install genesis
apt update
apt install python3-pip -y
pip3 install torch torchvision --index-url https://download.pytorch.org/whl/cu126
apt install python3-dev -y
(cd ../libs/Genesis/ && pip3 install . -i https://pypi.org/simple) && echo -e "${GREEN}installation of genesis succeeded!${RESET_COLOR}"
pip3 install joblib==1.2.0 -i https://pypi.org/simple
pip3 install scikit-learn==1.5.2 -i https://pypi.org/simple
pip3 install numpy==1.26.4 -i https://pypi.org/simple
pip3 install networkx==2.8.8 -i https://pypi.org/simple
pip3 install scikit-image==0.19.3 -i https://pypi.org/simple
pip3 install trimesh -i https://pypi.org/simple
mv /opt/lib/python3.9/site-packages/mpl_toolkits /opt/lib/python3.9/site-packages/__deprecated__mpl_toolkits
echo -e "${GREEN}finished installing genesis.${RESET_COLOR}"

# install LuisaRenderer
(cd ../libs/Genesis/genesis/ext/LuisaRender/build/bin/
export PYTHONPATH=$(pwd):$PYTHONPATH
cd ../../ && echo -e "linking $(pwd)"
rm -r /usr/local/lib/python3.9/dist-packages/genesis/ext/LuisaRender
ln -s $(pwd) /usr/local/lib/python3.9/dist-packages/genesis/ext/)

python3 -c "import LuisaRenderPy" && echo -e "done."

