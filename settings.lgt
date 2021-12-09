%% This is a sample Logtalk settings file with some useful libraries autoloaded
%% You should customize this as needed for your application
%% and let your loader file take care of loading your application.
/*
:- initialization((
   set_logtalk_flag(events,allow),
   logtalk_load(meta_compiler(loader)),
   set_logtalk_flag(hook, meta_compiler),
   logtalk_load([types(loader),meta(loader),random(loader),uuid(loader)])
)).
*/