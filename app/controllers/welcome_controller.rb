class WelcomeController < FrontendController
  def index
    render "index", layout: "application"
  end
end
