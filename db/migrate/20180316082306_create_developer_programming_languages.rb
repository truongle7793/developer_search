class CreateDeveloperProgrammingLanguages < ActiveRecord::Migration[5.1]
  def change
    create_table :developer_programming_languages do |t|
      t.references :developer, foreign_key: true, index: { name: 'index_dev_pro_id'}
      t.references :programming_language, foreign_key: true, index: { name: 'index_pro_dev_id'}
      t.timestamps
    end
    add_index :developer_programming_languages,
              [:developer_id, :programming_language_id],
              unique: true, name: 'index_dev_pro_lang'
  end
end
