%%This is a sample autoloader file for SWI-Prolog
%%For now it only includes the libraries necessary for running
%%the server daemon, but you should add other libraries
%%you would like to be globally available 
%%(BE WARY OF THE GLOBAL PREDICATE VISIBILITY - YOU HAVE BEEN WARNED)
:- use_module(library(clpfd)).
:- use_module(library(http/http_server)).
:- use_module(library(http/http_log)).
