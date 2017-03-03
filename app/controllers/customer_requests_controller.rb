class CustomerRequestsController < ApplicationController

  def index
    @requests = current_company.eligible_customer_requests
    @company = current_company
    @requests = CustomerRequest.all
    @attributes = Company.column_names
    render "index.html.erb"
  end

  def new
    @customer_request = CustomerRequest.new
    @categories = ServiceCategory.all
    render "new.html.erb"
  end

  def create
    @request = CustomerRequest.new(customer_request_params)
    @request.customer_id = current_customer.id
    @request = CustomerRequest.new(
      name: params["name"],
      email: params["email"],
      phone: params["phone"],
      industry: params["industry"],
      job_type: params["job_type"],
      project_type: params["project_type"],
      explanation: params["explanation"],
      location: params["location"],
      customer_availability: params["customer_availability"]
      )
    @request.save
    flash[:success] = "You did it!"
    redirect_to "/customers/#{current_customer.id}"
    redirect_to '/requests'
  end

  def show
    @request = CustomerRequest.find(params[:id])
    render "show.html.erb"
  end

  def edit
  end

  def update
  end

  def destroy
  end

private

def customer_request_params
  params.require(:customer_request).permit(
    :address,
    :city,
    :state,
    :zipcode,
    :description,
    :expires_date,
    :service_category_id
    )
  end
end
