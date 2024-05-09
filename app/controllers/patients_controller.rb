class PatientsController < ApplicationController
  before_action :authorize_access_request!


  def index
    @patients = Patient.all
    render json: @patients
  end



  def create
    @patient = Patient.new(patient_params)
    @patient.user_id = current_user.id

    if @patient.save
      render json: @patient, status: :created
    else
      render json: @patient.errors, status: :unprocessable_entity
    end
  end



  def search
    if Patient.exists?(nid: params[:nid])
        @patient = Patient.find_by(nid: params[:nid])
        @records = Record.all.where(nid: params[:nid])
        render json: {patient: @patient, medical_record: @records}
    else
        render json: {status: 404, message: "Patient Not Found!"}
    end
  end




  private
    # Only allow a list of trusted parameters through.
    def patient_params
      params.require(:patient).permit(:name, :contact, :address, :nid)
    end
end
