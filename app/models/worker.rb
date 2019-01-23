class Worker < ApplicationRecord
  validates :name, :ips, :status, :api_type, :alive_at, presence: true

  validates :api_version, presence: true, numericality: { only_integer: true }

  validates :webhook_supported, inclusion: { in: [true, false] }

  enum api_type: { HTTP: 0, WS: 1, }

  enum status: { disabled: 0, ok: 1, failed: 2, stale: 3, stopped: 4 }

  delegate :as_json, to: :decorate
end
