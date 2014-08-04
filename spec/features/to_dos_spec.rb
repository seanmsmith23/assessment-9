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
    add_todo("Make an edit button")

    expect(page).to have_link("Edit")

    click_link("Edit")

    expect(page).to have_content("Description")
    expect(find_field('description').value).to eq('Make an edit button')
    expect(page).to have_button("Update ToDo")

    fill_in "description", with: "Check if the test passed"
    click_button("Update ToDo")

    expect(page).to have_content("ToDo updated")
    expect(page).to have_content("Check if the test passed")
    expect(page).to_not have_button("Update ToDo")
  end

  scenario "User can complete a ToDo item" do
    register_and_signin_user("sean")
    add_todo("Let a user finish the todo")

    expect(page).to have_link("Complete")
    expect(page).to have_content("Let a user finish the todo")

    click_link("Complete")

    expect(page).to have_content("ToDo completed")
    expect(page).to_not have_content("Let a user finish the todo")
  end
end

## helper methods

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
