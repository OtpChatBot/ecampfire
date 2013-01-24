ecampfire
===========

ecampfire - is erlang library, provides campfire chat streaming api. I made it for [Ybot](https://github.com/0xAX/Ybot) chat robot, after that i decided to move it in separate library, hope that it can be useful for somebody.

Features
=========

When you start new campfire client with ecampfire, it try to join in room and after room joining, it will listen campfire incoming messages and send it to handler when receiving.

  * Leave campfire room 
  * Join campfire room
  * Campfire streaming api

Installing
=============

First of all you must get source code:

```
git clone https://github.com/0xAX/ecampfire.git
```

After that you must get ecampfire's dependencies and build it:

```
./rebar get-deps && ./rebar compile
```

Usage
===========

For ecampfire usage you must wrote simple gen_server handler like this:

```erlang
-module(campfire_handler).

-behaviour(gen_server).
 
-export([start_link/0]).
 
%% gen_server callbacks
-export([init/1,
         handle_call/3,
         handle_cast/2,
         handle_info/2,
         terminate/2,
         code_change/3]).
 
-record(state, {
    }).
 
start_link() ->
    gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).
 
init([]) ->
	% Start campfire client
	ecampfire_sup:start_campfire_client(self(), <<"room_id_int()">>, <<"your_token">>, <<"campfire_sub_domain">>),
	% init
    {ok, #state{}}.
 
handle_call(_Request, _From, State) ->
    {reply, ignored, State}.

handle_cast(_Msg, State) ->
    {noreply, State}.

%% @doc Receiving incoming message
handle_info({incoming_message, IncomingMessage}, State) ->
	% Do something with incoming message here
    {noreply, State};

handle_info(_Info, State) ->
    {noreply, State}.
 
terminate(_Reason, _State) ->
    ok.
 
code_change(_OldVsn, State, _Extra) ->
    {ok, State}.
 
%% Internal functions
```

Contribute
============

  * Fork main ybot repository (https://github.com/0xAX/ecampfire).
  * Make your changes in your clone of ecampfire.
  * Test it.
  * Send pull request.

Author
========

[@0xAX](https://twitter.com/0xAX)