if Rails.env.production?
  Rails.application.config.content_security_policy do |policy|
    policy.default_src :self, :https
    policy.font_src    :self, :https, :data
    policy.img_src     :self, :https, :data
    policy.object_src  :none
    policy.script_src  :self, :https
    policy.style_src   :self, :https
    policy.connect_src :self, :https, "wss://#{ ENV['HOST'] }"
  end

  Rails.application.config.content_security_policy_nonce_generator = -> request { SecureRandom.base64(16) }
end
