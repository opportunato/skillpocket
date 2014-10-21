class RemoveSkillDescriptions < ActiveRecord::Migration
  def up
    change_table :skills do |t|
      t.remove :description
    end
  end

  def down
    change_table :skills do |t|
      t.text :description, null: false
    end
  end
end
