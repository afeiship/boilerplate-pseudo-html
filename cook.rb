class Cook
  def self.start(name)
    # cook
    assets_dir = Rails.root.join("assets").to_s
    site_url = "http://localhost:3000"

    records = Post.limit(10)
    bar = ProgressBar.new(records.size)
    records.each_with_index do |post, index|
      system "mkdir -p #{assets_dir}/#{name}/"
      key = "#{name}/#{post.id}.html"
      filename = "#{assets_dir}/#{key}"
      url = "#{site_url}/#{key}"

      File.open(filename, "wb") do |file|
        file.write URI.open(url, encoding: "UTF-8").read
      end

      bar.increment!
    end
  end
end
