# if you want to use GUI apps
#xhost+ local

docker rm jupyter-brev
# UID and GID can be different change accordingly, try 1000 or 1001 

docker run -it \
    --name jupyter-brev \
    --gpus all \
    -p 8888:8888 \
    -e NB_UID=1001 -e NB_GID=1001 \
    -e JUPYTER_TOKEN=241002 \
    -v $(pwd)/src:/home/jovyan/src \
    --user root \
    jupyter-brev \

