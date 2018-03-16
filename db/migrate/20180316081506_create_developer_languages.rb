class CreateDeveloperLanguages < ActiveRecord::Migration[5.1]
  def change
    create_table :developer_languages do |t|
      t.references :developer, foreign_key: true, index: { name: 'index_dev_id'}
      t.references :language, foreign_key: true, index: { name: 'index_language_id'}
      t.timestamps
    end
    add_index :developer_languages,
              [:developer_id, :language_id],
              unique: true, name: 'index_dev_lang'
  end
end
