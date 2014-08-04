feature "ToDos" do
  scenario "A user can sign in a create a ToDo" do
    register_and_signin_user("hunta")

    expect(page).to have_content "Welcome, hunta"

    add_todo("Get a haircut")

    expect(page).to have_content "ToDo added"

    within ".todos" do
      expect(page).to have_content "Get a haircut"
    end
  end

  scenario "A user can edit a ToDo" do
    register_and_signin_user("sean")

  end
end

def register_and_signin_user(name)
  visit "/"

  click_link "Register"

  fill_in "Username", with: name
  fill_in "Password", with: "pazzword"

  click_button "Register"

  fill_in "Username", with: name
  fill_in "Password", with: "pazzword"

  click_button "Sign In"
end

def add_todo(todo)
  fill_in "What do you need to do?", with: todo
  click_button "Add ToDo"
end
