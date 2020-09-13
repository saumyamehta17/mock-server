class CreateEndpoints < ActiveRecord::Migration[5.2]
  def change
    create_table :endpoints do |t|
      t.string :verb
      t.string :path
      t.string :response_code
      t.string :response_body
      t.json :response_headers
      t.timestamps
    end
  end
end
