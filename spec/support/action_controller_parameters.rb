module ActionControllerParameters
  def acp(...)
    ActionController::Parameters.new(...)
  end

  def acpp(...)
    ActionController::Parameters.new(...).permit!
  end
end
