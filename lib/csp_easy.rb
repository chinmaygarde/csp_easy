class CSPEasy
  def initialize(app, policy="")
    @app = app
    @policy = policy
  end

  def call(env)
    dup._call(env)
  end

  def _call(env)
    @status, @headers, @response = @app.call(env)
    @headers["X-Content-Security-Policy"] = @policy unless @policy.blank?
    [@status, @headers, self]
  end

  def each(&block)
    @response.each(&block)
  end
end
