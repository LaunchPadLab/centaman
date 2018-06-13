module Centaman
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path('../templates', __FILE__)

      desc "Creates a Centaman initializer in your application."

      def copy_initializer
        copy_file "initializer.rb", "config/initializers/centaman.rb"
      end
    end
  end
end
