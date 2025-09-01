{
  afm = {
    groups = [ "default" ];
    platforms = [ ];
    source = {
      remotes = [ "https://rubygems.org" ];
      sha256 = "06kj9hgd0z8pj27bxp2diwqh6fv7qhwwm17z64rhdc4sfn76jgn8";
      type = "gem";
    };
    version = "0.2.2";
  };
  Ascii85 = {
    groups = [ "default" ];
    platforms = [ ];
    source = {
      remotes = [ "https://rubygems.org" ];
      sha256 = "1c62cx96r0v265mywnlik43qx0wf6bjbzl54qa47x6dzjg861mvk";
      type = "gem";
    };
    version = "1.1.1";
  };
  bigdecimal = {
    groups = [ "default" ];
    platforms = [ ];
    source = {
      remotes = [ "https://rubygems.org" ];
      sha256 = "1gi7zqgmqwi5lizggs1jhc3zlwaqayy9rx2ah80sxy24bbnng558";
      type = "gem";
    };
    version = "3.1.8";
  };
  hashery = {
    groups = [ "default" ];
    platforms = [ ];
    source = {
      remotes = [ "https://rubygems.org" ];
      sha256 = "0qj8815bf7q6q7llm5rzdz279gzmpqmqqicxnzv066a020iwqffj";
      type = "gem";
    };
    version = "2.1.2";
  };
  observer = {
    groups = [ "default" ];
    platforms = [ ];
    source = {
      remotes = [ "https://rubygems.org" ];
      sha256 = "1b2h1642jy1xrgyakyzz6bkq43gwp8yvxrs8sww12rms65qi18yq";
      type = "gem";
    };
    version = "0.1.2";
  };
  pdf-reader = {
    dependencies = [ "Ascii85" "afm" "hashery" "ruby-rc4" "ttfunk" ];
    groups = [ "default" ];
    platforms = [ ];
    source = {
      remotes = [ "https://rubygems.org" ];
      sha256 = "0n0pp7blk3np3fqsb54l34fsamrww80cp3dhlhskfayg7542mrv1";
      type = "gem";
    };
    version = "2.12.0";
  };
  pdfbeads = {
    dependencies = [ "pdf-reader" "rmagick" ];
    groups = [ "default" ];
    platforms = [ ];
    source = {
      remotes = [ "https://rubygems.org" ];
      sha256 = "121g6j1x0fc5cj25c53hw9n3m27g3h060hhlw8l6gi9qqgdqczdl";
      type = "gem";
    };
    version = "1.1.3";
  };
  pkg-config = {
    groups = [ "default" ];
    platforms = [ ];
    source = {
      remotes = [ "https://rubygems.org" ];
      sha256 = "04wi7n51w42v9s958gfmxwkg5iikq25whacyflpi307517ymlaya";
      type = "gem";
    };
    version = "1.5.6";
  };
  rmagick = {
    dependencies = [ "observer" "pkg-config" ];
    groups = [ "default" ];
    platforms = [ ];
    source = {
      remotes = [ "https://rubygems.org" ];
      sha256 = "0qa11i72j76q2v8lbvls3a8dqvkh9v3sgbd9mv9g2rqvb8gqkjrp";
      type = "gem";
    };
    version = "6.0.1";
  };
  ruby-rc4 = {
    groups = [ "default" ];
    platforms = [ ];
    source = {
      remotes = [ "https://rubygems.org" ];
      sha256 = "00vci475258mmbvsdqkmqadlwn6gj9m01sp7b5a3zd90knil1k00";
      type = "gem";
    };
    version = "0.1.5";
  };
  ttfunk = {
    dependencies = [ "bigdecimal" ];
    groups = [ "default" ];
    platforms = [ ];
    source = {
      remotes = [ "https://rubygems.org" ];
      sha256 = "1ji0kn8jkf1rpskv3ijzxvqwixg4p6sk8kg0vmwyjinci7jcgjx7";
      type = "gem";
    };
    version = "1.8.0";
  };
}
