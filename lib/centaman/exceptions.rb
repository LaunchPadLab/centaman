module Centaman
  module Exceptions
    class CentamanError < StandardError; end
    class CentamanTimeout < CentamanError; end
    class CentamanUnauthorized < CentamanError; end
    class CentamanEmailError< CentamanError; end
  end
end
