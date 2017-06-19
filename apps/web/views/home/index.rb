module Web::Views::Home
  class Index
    include Web::View
    include Hanami::Pagination::View

    def class_for(current_page, page_num)
      current_page == page_num || (current_page == 0 && page_num == 1) ? "primary" : ""
    end
  end
end
