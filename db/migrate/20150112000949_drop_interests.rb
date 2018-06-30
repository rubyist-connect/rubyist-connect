class DropInterests < ActiveRecord::Migration[4.2]
  def up
    drop_table :interests
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
