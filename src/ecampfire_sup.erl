-module(ecampfire_sup).

-behaviour(supervisor).

%% API
-export([start_link/0, start_campfire_client/4]).

%% Supervisor callbacks
-export([init/1]).

%% ===================================================================
%% API functions
%% ===================================================================

start_link() ->
    supervisor:start_link({local, ?MODULE}, ?MODULE, []).

%% @doc Start new campfire client
%% @end
-spec start_campfire_client(CallbackModule :: atom() | pid(), 
                            Room :: integer(), 
                            Token :: binary(),
                            Domain :: binary()) 
                       -> {ok, Pid :: pid()} | {error, Reason :: term()}.
start_campfire_client(CallbackModule, Room, Token, Domain) ->
    % run new campfire client
    supervisor:start_child(?MODULE, [CallbackModule, Room, Token, Domain]).

%% ===================================================================
%% Supervisor callbacks
%% ===================================================================

init([]) ->
    % campfire client
    ChildSpec = [

        % start campfire client
        {ecampfire_client, 
            {ecampfire_client, start_link, []},
             temporary, 2000, worker, []
        }
    ],

    % init
    {ok,{{simple_one_for_one, 10, 60}, ChildSpec}}.

