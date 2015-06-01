# spec/template_spec.rb

require 'spec_helper'
require "serverspec"
require "docker"

imagename = "template"

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

  def os_version
    command("/bin/cat /etc/redhat-release").stdout
  end

end