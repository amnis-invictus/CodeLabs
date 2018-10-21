class ConfirmationRequest::Accept
  attr_reader :confirmation_request

  delegate :pending?, to: :confirmation_request, prefix: true

  def initialize confirmation_request
    @confirmation_request = confirmation_request
  end

  def save
    confirmation_request.update(status: :accepted).tap do |result|
      confirmation_request.user.update! roles: :confirmed if result
    end
  end
end
