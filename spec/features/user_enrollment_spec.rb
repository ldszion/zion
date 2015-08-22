require 'rails_helper'
# require 'support/registration_process'

feature 'User enrollment' do
  given(:user) { User.first }
  given(:event) { Event.first }

  scenario 'enroll to an event successfuly' do
    user_is_logged_in
    when_i_enroll_in_a_event
    then_i_should_see_a_successful_message
    then_i_should_see_a_button_to_cancel_enrollment
  end

  scenario 'cancel enrollment with success' do
    user_is_logged_in
    when_i_cancel_the_event_enrollment
    then_i_should_see_cancel_enrollment_success_message
  end


  #############################################################################
  ################################## METHODS ##################################
  #############################################################################

  # Authentica usuário
  def user_is_logged_in
    login(user.email, '123456')
  end

  # Inscreve-se no evento clicando no botão de inscrição
  def when_i_enroll_in_a_event
    visit event_path(event)
    expect(page).to have_content(event.name)
    expect(page).to have_content('Inscrever-me')
    click_link I18n.t('text.enroll.enroll')
  end

  def then_i_should_see_a_successful_message
    expect(page).to have_content(I18n.t('text.enroll.successfuly'))
  end

  def then_i_should_see_a_button_to_cancel_enrollment
    expect(page).to have_content(I18n.t('text.enroll.cancel'))
  end

  def when_i_cancel_the_event_enrollment
    when_i_enroll_in_a_event
    then_i_should_see_a_button_to_cancel_enrollment

    click_link I18n.t('text.enroll.cancel')
  end

  def then_i_should_see_cancel_enrollment_success_message
    expect(page).to have_content(I18n.t('text.enroll.cancel_success'))
  end
end
