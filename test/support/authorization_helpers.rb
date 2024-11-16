module Support
  module AuthorizationHelpers
    def requires_authorization
      raise(ArgumentError, 'Block missing. Example: requires_authorization {get edit_object_path(object)}') unless block_given?

      yield

      assert_redirected_to('/')
      assert_not(flash[:alert].nil?)
    end
  end
end
