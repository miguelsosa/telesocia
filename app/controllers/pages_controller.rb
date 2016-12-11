class PagesController < ApplicationController
  # Helper handling forwarding for missing pages

  def handle_missing_page_error_404
    render status: 404
  end
end
