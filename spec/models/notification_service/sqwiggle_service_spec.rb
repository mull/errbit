require 'spec_helper'

describe NotificationService::SqwiggleService do
  it "sends a notification to Sqwiggle" do
    notice = Fabricate :notice
    notification_service = Fabricate :sqwiggle_notification_service, :app => notice.app

    stub_request(:any, /.*sqwiggle.*/).to_return({:body => {}.to_json})

    notification_service.create_notification(notice.problem)

    assert_requested :any, /.*sqwiggle.*/
  end
end
