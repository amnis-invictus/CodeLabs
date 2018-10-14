class Worker < ApplicationRecord
  validates :name, :ips, :status, :api_type, :alive_at, presence: true

  validates :api_version, presence: true, numericality: true

  enum api_type: { HTTP: 0, WS: 1, }, _prefix: true

  enum status: { disabled: 0, ok: 1, failed: 2, stale: 3 }, _prefix: true

  delegate :as_json, to: :decorate
end
