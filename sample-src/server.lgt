/*******************************************************************************
Author: Jacques Robin, Camilo Correa Restrepo, 2021.

COOLAPS Sample Server

This object defines the server that will expose a REST API for consumption
by the external components. It is automatically loaded at startup and defines
the predicates that will be called when receiving an HTTP request.

version: 0.0.1
*******************************************************************************/ 

:- object(server).
	:- threaded.
	
	%Route handling
	%Here we connect each handler predicate to the route
	%% To add more routes, add directives in this style
	%% {:- http_handler(root(<your_route>), [Request]>>(server::<your_predicate>(Request)), [])}.
	%% where root(<your_route>) -> <host>:8081/<your_route>
	{:- http_handler(root(.), [Request]>>(server::home_page(Request)), [])}.

	%% Run the server as a thread (and retain the top-level)
	%% Useful for debugging purposes and for running the server interactively
	%% Note that since the SWI init file autoloads all http libraries
	%% It is not necessary to explicitly module qualify the server predicates
	:- public(run/0).
	run :-
		{ http_server(http_dispatch, [port(8081)]) }.

	%% Gracefully stop the server
	:- public(stop/0).
	stop :-
		{ http_stop_server(8081, []) }.
	
	%% Sample request handler predicate
	:- public(home_page/1).
	home_page(_) :-
		{
			reply_html_page(
				title('Demo server'),
				[ h1('Hello world!')
				])
		}.

:- end_object.