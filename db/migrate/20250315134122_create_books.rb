class CreateBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :books do |t|

      # 以下の2行を追加
      t.string :title
      t.string :body
      t.timestamps
    end
  end
end
