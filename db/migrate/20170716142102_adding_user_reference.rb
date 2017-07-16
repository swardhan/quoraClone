class AddingUserReference < ActiveRecord::Migration
  def change
    add_reference :questions, :user, index: true
    add_foreign_key :questions, :users
    add_reference :answers, :user, index: true
    add_foreign_key :answers, :users
  end
end
