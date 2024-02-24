class ContestMembership < Membership
  validate :user_must_not_be_contest_owner

  def contest
    membershipable
  end

  private

  def user_must_not_be_contest_owner
    return if contest.blank?

    errors.add :user, :taken if user == contest.owner
  end
end
