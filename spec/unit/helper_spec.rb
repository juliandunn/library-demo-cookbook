#
# Author:: Julian C. Dunn (<jdunn@getchef.com>)
#
# Copyright (C) 2014 Chef Software, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

require 'spec_helper'

describe Demo::Helper do
  describe '#has_bacon?' do
    let(:shellout) { double(run_command: nil, error!: nil, stdout: '', stderr: double(empty?: true)) }
    let(:dummy_class) { Class.new { include Demo::Helper } }

    before {
      Mixlib::ShellOut.stub(:new).and_return(shellout)
    }

    it 'builds the correct command' do
      expect(Mixlib::ShellOut).to receive(:new).with('getent passwd bacon', {:returns=>[0, 2]})
      expect(shellout).to receive(:live_stream=).and_return(nil)
      expect(dummy_class.new.has_bacon?).to be_false
    end

    context 'without bacon' do
      let(:shellout) { double(run_command: nil, error!: nil, stdout: '', stderr: double(empty?: true)) }
      before { Mixlib::ShellOut.stub(:new).and_return(shellout) }

      it 'says there is no bacon' do
        expect(shellout).to receive(:live_stream=).and_return(nil)
        expect(dummy_class.new.has_bacon?).to be_false
      end
    end

    context 'with bacon' do
      let(:shellout) { double(run_command: nil, error!: nil, stdout: 'bacon', stderr: double(empty?: true)) }
      before { Mixlib::ShellOut.stub(:new).and_return(shellout) }

      it 'says there is bacon' do
        expect(shellout).to receive(:live_stream=).and_return(nil)
        expect(dummy_class.new.has_bacon?).to be_true
      end
    end
  end
end
