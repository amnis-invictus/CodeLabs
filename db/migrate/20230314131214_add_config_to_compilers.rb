class AddConfigToCompilers < ActiveRecord::Migration[6.0]
  def change
    add_column :compilers, :config, :text
  end
end
