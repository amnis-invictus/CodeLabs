class MembershipsController < ApplicationController
  def create
    if resource.save
      redirect_to resource.contest
    else
      render :new, turbolinks: true
    end
  end

  def update
    resource.update resource_params

    redirect_back fallback_location: resource.contest
  end

  def destroy
    resource.destroy

    redirect_back fallback_location: resource.contest
  end

  private

  def parent
    @parent ||= Contest.find params[:contest_id] if params[:contest_id]
  end

  def collection
    @collection ||= (parent || current_user).pending_memberships.order(id: :desc).page(params[:page])
  end

  def resource
    @resource ||= Membership.find params[:id]
  end

  def resource_params
    { state: :accepted }
  end

  def create_resource_params
    params.require(:membership).permit(:user_id, :type).merge(contest: parent)
  end

  def initialize_resource
    @resource = parent.pending_memberships.new
  end

  def build_resource
    @resource = MembershipFactory.build current_user, create_resource_params
  end

  def policy record
    policy = Pundit::PolicyFinder.new(record).policy!

    policy == MembershipPolicy ? MembershipPolicy.new(current_user, record, parent: parent) : super
  end
end
