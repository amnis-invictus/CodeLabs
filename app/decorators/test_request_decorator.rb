class TestRequestDecorator < Draper::Decorator
  delegate_all

  def as_json *args
    {
      id: id,
      solution_compiler: solution_compiler,
      checker_compiler: checker_compiler,
      problem_id: problem_id,
      solution_url: solution_url
    }
  end

  def solution_url
    h.url_for solution if solution.attached?
  end
end
