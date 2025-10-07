# if you want to use GUI apps
#xhost+ local

docker rm jupyter-brev
# UID and GID can be different change accordingly, try 1000 or 1001 
echo "Starting container with UID: $(id -u) and GID: $(id -g)"


docker run -it \
    --name jupyter-brev \
    --gpus all \
    -p 8888:8888 \
    -e NB_UID=$(id -u) -e NB_GID=$(id -g) \
    -e JUPYTER_TOKEN=12345123 \
    -v $(pwd)/../../../dataset:/home/jovyan/dataset \
    -v $(pwd)/src:/home/jovyan/src \
    -v $(pwd)/saved_weight:/home/jovyan/saved_weight \
    --user root \
    jupyter-brev \

