class AddEmailConstraintToUsers < ActiveRecord::Migration
  # based on "Rails, Angular, Postgres, and Bootstrap" recommendation
  # to ue def up/down instad of def change because we need to execut
  # sql code directly. Note that this constraint works in postgresql
  # but may not work in other OSs
  def up
    execute %{
      ALTER TABLE users
      ADD CONSTRAINT email_must_look_like_email
      CHECK ( email ~* '[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}' )
   }
  end

  def down
    execute %{
      ALTER TABLE users
      DROP CONSTRAINT email_must_look_like_email
    }
  end
end
