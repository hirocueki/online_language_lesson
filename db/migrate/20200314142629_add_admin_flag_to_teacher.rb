class AddAdminFlagToTeacher < ActiveRecord::Migration[6.0]
  def change
    add_column :teachers, :admin, :boolean, null: false, default: false
  end
end
