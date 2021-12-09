/*******************************************************************************
Author: Jacques Robin, Camilo Correa Restrepo, 2021.

COOLAPS base loader file

This file contains all the loader code for your application and its dependencies.

version: 0.2
*******************************************************************************/


% Init script
:- initialization((
	logtalk_load([
		%% Your files go here
		server
	],[
		%% Uncomment this line to compile your code in debug mode
		%% Note: make sure the logtalk settings do not conflict with this setting to ensure it works as intended
		%% debug(on)
	])
)).
