require_relative '../../../week-2/lecture/stacks_queues_bags/linked_queue_of_strings.rb'
require 'net/http'
require 'set'
# use httparty and nokogiri?

class WebCrawler
  def initialize(source_url)
    @urls = Set.new
    @source_url = source_url
    crawl
  end

  def crawl
    q = Queue.new
    q.enqueue(@source_url)

    curr = @source_url
    while queue.size > 0
      links = scrape_hyperlinks(curr)

      links.each do |l|
        q.enqueue(l) if @urls.add?(l)
      end
    end
  end

  def scrape_hyperlinks(url)

  end
end