class Cook
  def self.start(name)
    # cook
    assets_dir = Rails.root.join("assets").to_s
    site_url = "http://localhost:3000"
    thread_size = 50

    records = Post.limit(2000)
    bar = ProgressBar.new(records.size)
    system "mkdir -p #{assets_dir}/#{name}/"
    size = records.size / thread_size

    threads = records.each_slice(size).map do |items|
      Thread.new do
        items.each do |item|
          key = "#{name}/#{item.id}.html"
          filename = "#{assets_dir}/#{key}"
          url = "#{site_url}/#{key}"
          File.open(filename, "wb") do |file|
            file.write URI.open(url, encoding: "UTF-8").read
          end
          bar.increment!
        end
      end
    end

    threads.each(&:join)
  end
end
