# CNN-BNN-Accelerator

## Introduction

This repo is mainly used for better documentation of my undergraduate thesis. If somehow you find this repo useful feel free to use it.

## Prerequisite

If you are using the container make sure you have [nvidia toolkit](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html).

## Running the docker

1. Building the docker

I'm naming my docker jupyter-brev

```bash
docker build -t jupyter-brev .
```

2. Starting the docker

```bash
bash ./start_contaiter.sh
```

3. starting new terminal

In a new console run:

``` bash
docker exec -it jupyter-brev
```

4. Stoping the container

to stop the container, just terminat where you started the conainer

<kbd>Ctrl</kbd> + <kbd>c</kbd> 


## Making new file

I prefer to store my file in the src and then mounting it in the docker, but you can also use the original workspace from the image.

## Running the jupyer notebook

There are two option:
1. Running in web by going to [localhost](http://127.0.0.1:8888/lab?token=12345123)

or

2. Using the kernel inside an opened vscode jupyter file


## RTL

The RTL code will be designed and verified using vivado from xilinx.