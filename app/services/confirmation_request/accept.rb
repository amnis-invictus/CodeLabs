class ConfirmationRequest::Accept
  attr_reader :confirmation_request

  delegate :pending?, to: :confirmation_request, prefix: true

  def initialize confirmation_request
    @confirmation_request = confirmation_request
  end

  def save
    ConfirmationRequest.transaction do
      confirmation_request.user.update roles: :confirmed

      confirmation_request.update status: :accepted
    end
  end
end
