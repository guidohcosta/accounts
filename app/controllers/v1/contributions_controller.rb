class V1::ContributionsController < ApplicationController
  before_action :find_head, only: :fetch_api

  def fetch_api
    response = ::ContributionService.call({
      account: @head,
      amount: params[:amount].to_i
    })

    if success?(response)
      render json: {
        status: :success,
        body: response[:body]
      }
    end
  end

  private

  def find_head
    @head = Head.find(params[:head_id])
  end

  def success?(response)
    response[:status] == :success
  end
end
