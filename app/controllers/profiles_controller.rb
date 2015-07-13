class ProfilesController < ApplicationController
  before_action :must_have_person_if_logged_in
end
