require 'spec_helper'

#set :backend, :docker
#set :docker_container

RSpec.describe do
  around do |example|
    container = Docker::Container.create(
      'Cmd'        => ['/usr/lib/systemd/systemd'],
      'Image'      => 'gentoo-systemd',
      'Detach'     => true,
      'HostConfig' => {
        'CapAdd' => ['SYS_AdMIN'],
        'Binds'  => %w(
           /home/mtsmfm/.ghq/github.com/esminc/esm-overlay/dev-util/drone:/var/db/repos/esm/dev-util/drone
           /usr/portage/distfiles:/usr/portage/distfiles
        )
      }
    )
    container.start!

    puts container.exec %w(ebuild /var/db/repos/esm/dev-util/drone/drone-9999.ebuild merge)

    example.run

    container.kill!
  end

  it {
    binding.pry
  }
end
