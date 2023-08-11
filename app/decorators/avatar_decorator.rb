class AvatarDecorator < Draper::Decorator
  delegate_all

  def as_json *_args
    { url: url }
  end

  def url
    return unless user.avatar.attached?

    helpers.url_for user.avatar.variant(resize: '300x400', crop: '300x400+0+0', gravity: 'center')
  end
end
