require 'spec_helper'

describe Demo::Helper do
  describe '#has_bacon?' do
    let(:shellout) { double(run_command: nil, error!: nil, stdout: '', stderr: double(empty?: true)) }
    let(:dummy_class) { Class.new { include Demo::Helper } }

    before { Mixlib::ShellOut.stub(:new).and_return(shellout) }

    it 'builds the correct command' do
      expect(Mixlib::ShellOut).to receive(:new).with('getent passwd bacon', {:returns=>[0, 2]})
      expect(dummy_class.new.has_bacon?).to be_false
    end

    context 'without bacon' do
      let(:shellout) { double(run_command: nil, error!: nil, stdout: '', stderr: double(empty?: true)) }
      before { Mixlib::ShellOut.stub(:new).and_return(shellout) }

      it 'says there is no bacon' do
        expect(dummy_class.new.has_bacon?).to be_false
      end
    end

    context 'with bacon' do
      let(:shellout) { double(run_command: nil, error!: nil, stdout: 'bacon', stderr: double(empty?: true)) }
      before { Mixlib::ShellOut.stub(:new).and_return(shellout) }

      it 'says there is bacon' do
        expect(dummy_class.new.has_bacon?).to be_true
      end
    end
  end
end
