# COOLAPS Docker Image

This repository contains the code necessary to create a Constraint Object-Oriented Logic Programming as a Service (COOLAPS) environment docker image. It has been created by the Center for Research for Informatics at University of Paris 1 Panthéon-Sorbonne. The motivation behind this is enabling developers to quickly bootstrap a working COOLAPS environment that allows them to very quickly begin developing their own web services based on the unique combination of Constraint Logic Programming (as a service) and Object-Oriented Logic programming.

Included in this repository are code samples with the necessary files to construct a headless daemon server, so that it straighforward to bootstrap your own project on this basis.

## How to use this repository

The primary intended use of this repository is allowing you to construct a COOLAPS docker image to use as a base for your own applications. The bundled makefile is designed to allow you to very quickly build your image and run it, though do keep in mind that it has designed with running the server daemon by default. Please see the Dockerfile for instructions on how to change this behavior.

The commands are as follows:
```
$ make
$ make all
```
Either of these commands builds your image and tags it as the latest version,

```
$ make run
```
This command will run the docker image as a non-interactive container. This is probably the command you want if you just want to launch the daemon for testing or production.

```
$ make ba
$ make nba
```
The first of these targets (ba) builds the docker image and attaches itself to the container. This is useful if you want to observe for any compiler warnings that may be emitted when loading your daemon, or for troubleshooting purposes. Keep in mind you will not have a top-level in the interpreter. The latter target (nba) performs the same action but forgoes rebuilding the image before running the container.

```
$ make exec
```
This target requires that **a single** COOLAPS container already be running, and will provide you with an interactive _bash_ shell on the container.

```
$ make tail
```
This target also requires that **a single** COOLAPS container already be running, and will run _tail -f_ on the server's logfile. This is quite useful for debugging purposes.

```
$ make cid
```
As before, with **a single** COOLAPS container already running, this target will output the container's process id.

```
$ make stop
```
This will stop your **single** COOLAPS container.

```
$ make clean
```
This target will clean your docker environment, pruning stale images, containers and volumes.

## Bootstrapping your application
Within the _sample-src_ folder, you will find a minimal working example of a COOLAPS web server that leverages SWI-Prolog's HTTP server libraries. In addition, and for convenience, the _clpfd_ library is autoloaded making declarative integer arithmetic predicates available everywhere by default. This can be used as your starting point for creating your own COOLAPS application.

