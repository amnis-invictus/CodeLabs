class ApplicationPolicy
  attr_reader :user, :resource

  def initialize user, resource
    @user, @resource = user, resource
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
