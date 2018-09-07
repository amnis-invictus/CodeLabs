class Api::ConstantsController < Api::ApplicationController
  skip_before_action :authorize_collection

  def collection
    Constants
  end
end
