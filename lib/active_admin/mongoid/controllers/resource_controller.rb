require 'active_admin/engine'

ActiveAdmin::Engine.module_eval do
  config.after_initialize do
    if defined?(ActiveAdmin::ResourceController)
      ActiveAdmin::ResourceController.class_eval do
        def build_new_resource
          scoped_collection.send(
            method_for_build,
            *resource_params
          )
        end
      end
    else
      warn "⚠️ ActiveAdmin::ResourceController is not loaded yet — skipping patch"
    end
  end
end
