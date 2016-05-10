require 'rbconfig'
require 'benchmark'
require 'benchmark/ips'
require 'webmock'

require 'airbrake-ruby'

BIG_EXCEPTION = RuntimeError.new('App crashed!')
# rubocop:disable Metrics/LineLength
BIG_EXCEPTION.set_backtrace(
  ["lib/arel/visitors/to_sql.rb:729:in `unsupported'",
   "lib/arel/visitors/reduce.rb:13:in `visit'",
   "lib/arel/visitors/to_sql.rb:241:in `block in visit_Arel_Nodes_SelectCore'",
   "lib/arel/visitors/to_sql.rb:240:in `visit_Arel_Nodes_SelectCore'",
   "lib/arel/visitors/to_sql.rb:210:in `block in visit_Arel_Nodes_SelectStatement'",
   "lib/arel/visitors/to_sql.rb:209:in `visit_Arel_Nodes_SelectStatement'",
   "lib/arel/visitors/reduce.rb:13:in `visit'",
   "lib/arel/visitors/reduce.rb:7:in `accept'",
   "lib/active_record/connection_adapters/abstract/database_statements.rb:12:in `to_sql'",
   "lib/active_record/connection_adapters/abstract/database_statements.rb:32:in `select_all'",
   "lib/active_record/connection_adapters/abstract/query_cache.rb:70:in `select_all'",
   "lib/active_record/querying.rb:39:in `find_by_sql'",
   "lib/active_record/relation.rb:638:in `exec_queries'",
   "lib/active_record/relation.rb:514:in `load'",
   "lib/active_record/relation.rb:243:in `to_a'",
   "lib/bullet/active_record42.rb:29:in `to_a'",
   "lib/active_record/relation/delegation.rb:46:in `each'",
   "app/controllers/rubric_items_controller.rb:52:in `block in update'",
   "lib/active_record/connection_adapters/abstract/database_statements.rb:213:in `block in transaction'",
   "lib/active_record/connection_adapters/abstract/transaction.rb:188:in `within_new_transaction'",
   "lib/active_record/connection_adapters/abstract/database_statements.rb:213:in `transaction'",
   "lib/active_record/transactions.rb:220:in `transaction'",
   "app/controllers/rubric_items_controller.rb:51:in `update'",
   "lib/action_controller/metal/implicit_render.rb:4:in `send_action'",
   "lib/abstract_controller/base.rb:198:in `process_action'",
   "lib/action_controller/metal/rendering.rb:10:in `process_action'",
   "lib/abstract_controller/callbacks.rb:20:in `block in process_action'",
   "lib/active_support/callbacks.rb:117:in `call'",
   "lib/active_support/callbacks.rb:555:in `block (2 levels) in compile'",
   "lib/active_support/callbacks.rb:505:in `call'",
   "lib/active_support/callbacks.rb:92:in `_run_callbacks'",
   "lib/active_support/callbacks.rb:776:in `_run_process_action_callbacks'",
   "lib/active_support/callbacks.rb:81:in `run_callbacks'",
   "lib/abstract_controller/callbacks.rb:19:in `process_action'",
   "lib/action_controller/metal/rescue.rb:29:in `process_action'",
   "lib/action_controller/metal/instrumentation.rb:32:in `block in process_action'",
   "lib/active_support/notifications.rb:164:in `block in instrument'",
   "lib/active_support/notifications/instrumenter.rb:20:in `instrument'",
   "lib/active_support/notifications.rb:164:in `instrument'",
   "lib/action_controller/metal/instrumentation.rb:30:in `process_action'",
   "lib/action_controller/metal/params_wrapper.rb:250:in `process_action'",
   "lib/active_record/railties/controller_runtime.rb:18:in `process_action'",
   "lib/abstract_controller/base.rb:137:in `process'",
   "lib/action_view/rendering.rb:30:in `process'",
   "lib/action_controller/metal.rb:196:in `dispatch'",
   "lib/action_controller/metal/rack_delegation.rb:13:in `dispatch'",
   "lib/action_controller/metal.rb:237:in `block in action'",
   "lib/action_dispatch/routing/route_set.rb:74:in `dispatch'",
   "lib/action_dispatch/routing/route_set.rb:43:in `serve'",
   "lib/action_dispatch/journey/router.rb:43:in `block in serve'",
   "lib/action_dispatch/journey/router.rb:30:in `serve'",
   "lib/action_dispatch/routing/route_set.rb:819:in `call'",
   "lib/omniauth/strategy.rb:186:in `call!'",
   "lib/omniauth/strategy.rb:164:in `call'",
   "lib/omniauth/strategy.rb:186:in `call!'",
   "lib/omniauth/strategy.rb:164:in `call'",
   "lib/omniauth/builder.rb:59:in `call'",
   "lib/meta_request/middlewares/app_request_handler.rb:13:in `call'",
   "lib/meta_request/middlewares/meta_request_handler.rb:13:in `call'",
   "lib/bullet/rack.rb:12:in `call'",
   "lib/rack/livereload.rb:23:in `_call'",
   "lib/rack/livereload.rb:14:in `call'",
   "lib/rack/etag.rb:24:in `call'",
   "lib/rack/conditionalget.rb:38:in `call'",
   "lib/rack/head.rb:13:in `call'",
   "lib/action_dispatch/middleware/params_parser.rb:27:in `call'",
   "lib/action_dispatch/middleware/flash.rb:260:in `call'",
   "lib/rack/session/abstract/id.rb:225:in `context'",
   "lib/rack/session/abstract/id.rb:220:in `call'",
   "lib/action_dispatch/middleware/cookies.rb:560:in `call'",
   "lib/active_record/query_cache.rb:36:in `call'",
   "lib/active_record/connection_adapters/abstract/connection_pool.rb:649:in `call'",
   "lib/active_record/migration.rb:378:in `call'",
   "lib/action_dispatch/middleware/callbacks.rb:29:in `block in call'",
   "lib/active_support/callbacks.rb:88:in `_run_callbacks'",
   "lib/active_support/callbacks.rb:776:in `_run_call_callbacks'",
   "lib/active_support/callbacks.rb:81:in `run_callbacks'",
   "lib/action_dispatch/middleware/callbacks.rb:27:in `call'",
   "lib/action_dispatch/middleware/reloader.rb:73:in `call'",
   "lib/action_dispatch/middleware/remote_ip.rb:78:in `call'",
   "lib/bugsnag/rack.rb:36:in `call'",
   "lib/better_errors/middleware.rb:84:in `protected_app_call'",
   "lib/better_errors/middleware.rb:79:in `better_errors_call'",
   "lib/better_errors/middleware.rb:57:in `call'",
   "lib/rack/contrib/response_headers.rb:17:in `call'",
   "lib/meta_request/middlewares/headers.rb:16:in `call'",
   "lib/action_dispatch/middleware/debug_exceptions.rb:17:in `call'",
   "lib/action_dispatch/middleware/show_exceptions.rb:30:in `call'",
   "lib/rails/rack/logger.rb:38:in `call_app'",
   "lib/rails/rack/logger.rb:22:in `call'",
   "config/initializers/quiet_assets.rb:7:in `call_with_quiet_assets'",
   "lib/request_store/middleware.rb:8:in `call'",
   "lib/action_dispatch/middleware/request_id.rb:21:in `call'",
   "lib/rack/methodoverride.rb:22:in `call'",
   "lib/rack/runtime.rb:18:in `call'",
   "lib/active_support/cache/strategy/local_cache_middleware.rb:28:in `call'",
   "lib/rack/lock.rb:17:in `call'",
   "lib/action_dispatch/middleware/static.rb:113:in `call'",
   "lib/rack/sendfile.rb:113:in `call'",
   "lib/rails/engine.rb:518:in `call'",
   "lib/rails/application.rb:164:in `call'",
   "lib/rack/content_length.rb:15:in `call'",
   "lib/unicorn/http_server.rb:576:in `process_client'",
   "lib/unicorn/http_server.rb:670:in `worker_loop'",
   "lib/unicorn/http_server.rb:525:in `spawn_missing_workers'",
   "lib/unicorn/http_server.rb:140:in `start'",
   "lib/unicorn_rails.rb:33:in `run'",
   "lib/rack/server.rb:286:in `start'",
   "lib/rails/commands/server.rb:80:in `start'",
   "lib/rails/commands/commands_tasks.rb:80:in `block in server'",
   "lib/rails/commands/commands_tasks.rb:75:in `server'",
   "lib/rails/commands/commands_tasks.rb:39:in `run_command!'",
   "lib/rails/commands.rb:17:in `<top (required)>'",
   "lib/rails/commands.rb:17:in `<top (required)>'",
   "lib/spring/client/rails.rb:28:in `call'",
   "lib/spring/client/command.rb:7:in `call'",
   "lib/spring/client.rb:26:in `run'",
   "bin/spring:48:in `<top (required)>'",
   "lib/spring/binstub.rb:11:in `<top (required)>'",
   "lin/spring:13:in `<top (required)>'",
   "bin/rails:3:in `<main>'"]
)

SMALL_EXCEPTION = RuntimeError.new('App crashed!')
SMALL_EXCEPTION.set_backtrace(
  ["/home/kyrylo/code/airbrake/ruby/spec/spec_helper.rb:23:in `<top (required)>'",
   "/opt/rubies/ruby-2.2.2/lib/ruby/2.2.0/rubygems/core_ext/kernel_require.rb:54:in `require'",
   "/opt/rubies/ruby-2.2.2/lib/ruby/2.2.0/rubygems/core_ext/kernel_require.rb:54:in `require'",
   "/home/kyrylo/code/airbrake/ruby/spec/airbrake_spec.rb:1:in `<top (required)>'",
   "/home/kyrylo/.gem/ruby/2.2.2/gems/rspec-core-3.3.2/lib/rspec/core/configuration.rb:1327:in `load'",
   "/home/kyrylo/.gem/ruby/2.2.2/gems/rspec-core-3.3.2/lib/rspec/core/configuration.rb:1327:in `block in load_spec_files'",
   "/home/kyrylo/.gem/ruby/2.2.2/gems/rspec-core-3.3.2/lib/rspec/core/configuration.rb:1325:in `each'",
   "/home/kyrylo/.gem/ruby/2.2.2/gems/rspec-core-3.3.2/lib/rspec/core/configuration.rb:1325:in `load_spec_files'",
   "/home/kyrylo/.gem/ruby/2.2.2/gems/rspec-core-3.3.2/lib/rspec/core/runner.rb:102:in `setup'",
   "/home/kyrylo/.gem/ruby/2.2.2/gems/rspec-core-3.3.2/lib/rspec/core/runner.rb:88:in `run'",
   "/home/kyrylo/.gem/ruby/2.2.2/gems/rspec-core-3.3.2/lib/rspec/core/runner.rb:73:in `run'",
   "/home/kyrylo/.gem/ruby/2.2.2/gems/rspec-core-3.3.2/lib/rspec/core/runner.rb:41:in `invoke'",
   "/home/kyrylo/.gem/ruby/2.2.2/gems/rspec-core-3.3.2/exe/rspec:4:in `<main>'"]
)
# rubocop:enable Metrics/LineLength

# Make sure we don't send any remote requests.
WebMock.disable_net_connect!(allow_localhost: true)

# Raise any errors (just in case).
Thread.abort_on_exception = true
