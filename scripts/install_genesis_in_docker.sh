readonly RED='\033[1;31m'
readonly GREEN='\033[0;32m'
readonly RESET_COLOR='\e[0m'

(cd ../
git submodule update --init --recursive)

# install torch
apt update
apt install python3-pip -y
pip3 install torch torchvision --no-deps
export LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=/usr/local/cuda/extras/CUPTI/lib64:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=/usr/local/nccl/lib:$LD_LIBRARY_PATH

# install genesis
apt install python3-dev -y
(cd ../libs/Genesis/ && pip3 install -r requirements.txt -i https://pypi.org/simple && pip install --prefix=/usr/local dist/genesis_world-0.2.1-cp39-cp39-linux_x86_64.whl --no-deps) && echo -e "${GREEN}installation of genesis succeeded!${RESET_COLOR}"
mv /opt/lib/python3.9/site-packages/mpl_toolkits /opt/lib/python3.9/site-packages/__deprecated__mpl_toolkits
pip3 install xmltodict -i https://pypi.org/simple
echo -e "${GREEN}finished installing genesis.${RESET_COLOR}"

# install LuisaRenderer
(rm -r /usr/local/lib/python3.9/dist-packages/genesis/ext/LuisaRender
cd ../libs/Genesis/genesis/ext/LuisaRender/ && echo -e "linking $(pwd)"
ln -s $(pwd) /usr/local/lib/python3.9/dist-packages/genesis/ext/)

cd ../libs/Genesis/genesis/ext/LuisaRender/build/bin/
export PYTHONPATH=$(pwd):$PYTHONPATH

python3 -c "import LuisaRenderPy" && echo -e "done."

