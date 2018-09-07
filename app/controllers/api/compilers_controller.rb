class Api::CompilersController < Api::ApplicationController
  skip_before_action :authorize_collection

  def collection
    @collection ||= Compiler.all
  end
end
