require 'test_helper'

class StoreControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    # añado estos assert porque los pone en el libro,
    # pero no le veo sentido testear algo que se puede cambiar en cualquier momento
    # algo tan pegado a la vista, me gustan mas los test unitarios
    # estos se pueden romper con mucha facilidad
    assert_select '#columns #side a', minimum: 4
    assert_select '#main .entry', 3
    assert_select 'h3', 'Programming Ruby 1.9'
    assert_select '.price', /\$[,\d]+\.\d\d/
  end

end
