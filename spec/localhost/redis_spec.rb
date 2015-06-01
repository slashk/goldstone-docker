# spec/redis_spec.rb

require 'spec_helper'
require "serverspec"
require "docker"

imagename = "redis"

describe imagename do
  before(:all) do
    image = Docker::Image.build_from_dir("Dockerfiles/" + imagename)

    set :os, :family => 'redhat'
    set :backend, :docker
    set :docker_image, image.id
  end

  it "installs the right version of Centos" do
    expect(os_version).to include("CentOS Linux release 7")
  end

  it "installs required packages" do
    expect(package("redis")).to be_installed
  end

  #it "should expose the default port" do
    ##expect(image.json["config"]["ExposedPorts"].has_key?("6379/tcp")).to be_true
  #end

  def os_version
    command("/bin/cat /etc/redhat-release").stdout
  end

end