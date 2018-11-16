class V1::TransfersController < ApplicationController
  before_action :find_head, only: :create
  before_action :find_transfers, only: :index

  def create
    response = ::TransferService.call({
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

  def index
    render json: {
      status: :success,
      body: @transfers
    }
  end

  private

  def find_transfers
    @transfers = Transfer.all
  end

  def find_head
    @head = Head.find(params[:head_id])
  end

  def success?(response)
    response[:status] == :success
  end
end
