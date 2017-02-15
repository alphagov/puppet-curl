require 'spec_helper'

describe 'curl::authfetch', :type => :define do
  let(:title) { 'a_file' }

  let(:params) { {
    :source      => '127.0.0.1:80',
    :destination => '/tmp/files',
    :user        => 'deploy',
  } }

  context 'without proxies' do
    it { is_expected.to contain_exec('curl-a_file').with_environment [] }
  end

  context 'with proxies' do
    let(:facts) { {
      :http_proxy => '127.0.0.1:8888'
    } }

    it { is_expected.to contain_exec('curl-a_file').with_environment /HTTP/ }
  end
end
