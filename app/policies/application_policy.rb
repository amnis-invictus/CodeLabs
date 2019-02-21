class ApplicationPolicy
  attr_reader :user, :resource, :params

  def initialize user, resource, **params
    @user, @resource, @params = user, resource, params
  end

  %i[index? show? create? update? destroy?].each do |name|
    define_method(name) { false }
  end

  def new?
    create?
  end

  def edit?
    update?
  end
end
