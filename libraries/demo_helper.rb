module Demo
  module Helper

    include Chef::Mixin::ShellOut

    def has_bacon?
      cmd = shell_out!("getent passwd bacon", {:returns => [0,2]})
      cmd.stderr.empty? && (cmd.stdout =~ /^bacon/)
    end
  end
end
