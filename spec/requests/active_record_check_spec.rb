require 'spec_helper'

describe 'A status request with an ActiveRecordCheck' do
  before do
    Codeschool::Status::Checker.
      add_check(Codeschool::Status::Checks::ActiveRecordCheck)
  end

  subject { get(status_path) ; response }

  context 'with an unerring ActiveRecord connection' do
    it_behaves_like 'a successful status response'
  end

  context 'with a failed ActiveRecord connection' do
    before do
      ActiveRecord::Base.connection.stub(:execute).
        and_raise(ActiveRecord::ConnectionNotEstablished)
    end

    it_behaves_like 'an erred status response'

    it 'contains a message regarding the database failure' do
      expect(subject).to include_status_error_message(I18n.t('activemodel.errors.models.codeschool/status/checker.attributes.base.database_unavailable'))
    end
  end
end