class ClairScanner < Formula
  desc "Docker containers vulnerability scan"
  homepage "https://github.com/arminc/clair-scanner"
  url "https://github.com/arminc/clair-scanner.git",
      :tag => "v8",
      :revision => "d3bde18cc21641f00772ed626a9bed9ce28237c8"


  depends_on "go" => :build
  depends_on "dep" => :build

  def install
    contents = Dir["{*,.git,.gitignore}"]
    gopath = buildpath/"gopath"
    (gopath/"src/github.com/arminc/clair-scanner").install contents

    ENV["GOPATH"] = gopath
    ENV.prepend_create_path "PATH", gopath/"bin"

    cd gopath/"src/github.com/arminc/clair-scanner" do
      system "make ensure && make build"
      bin.install "clair-scanner"
      prefix.install_metafiles
    end
  end
    
end
