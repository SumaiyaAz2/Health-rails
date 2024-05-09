class RecordsController < ApplicationController
  before_action :authorize_access_request!
  before_action :set_record, only: [ :show, :update, :destroy ]

  # GET /records
  def index
    @records = current_user.records.all

    render json: @records
  end

  # GET /records/1
  def show
    render json: @record
  end

  # POST /records
  def create
    @record = Record.new(record_params)
    @record.user_id = current_user.id
    @patient = Patient.find_by(params[:nid])
    @record.patient_id = @patient.id


    if RecordBlock.last
      @block = Block.next(RecordBlock.last, record_params.to_s, RecordBlock.last.hashh)

      @newblock = RecordBlock.new(
          previous_hash: @block.previous_hash,
          record: @block.data,
          hashh: @block.hash
      )

      if @record.save && @newblock.save
          render json:{ status: 200 }
      else
          render json: {message: "Could not create record!"}
      end
    else

      @block = Block.first(record_params.to_s)

      @newblock = RecordBlock.new(
          previous_hash: @block.previous_hash,
          record: @block.data,
          hashh: @block.hash
      )


      if @record.save && @newblock.save
          render json:{ status: 200 }
      else
          render json: {message: "Could not create  record!"}
      end
    end
  end

  # PATCH/PUT /records/1
  def update
    if @record.update(record_params)
      render json: @record
    else
      render json: @record.errors, status: :unprocessable_entity
    end
  end

  # DELETE /records/1
  def destroy
    @record.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_record
      @record = current_user.records.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def record_params
      params.require(:record).permit(:disease, :medicine, :nid)
    end
end


require "digest"

class Block
    attr_reader :id 
    attr_reader :timestamp
    attr_reader :data
    attr_reader :previous_hash
    attr_reader :hashh 
    attr_reader :nonce
    
    def initialize(id, data, previous_hash)
        @id = id
        @timestamp = Time.now
        @data = data 
        @previous_hash = previous_hash
        @nonce, @hashh = compute_hash_with_proof_of_work 
    end

    def compute_hash_with_proof_of_work(difficulty="00")
        nonce = 0

        loop do 
            hash = compute_hash_with_nonce(nonce)

            #proof of work
            if hash.start_with?(difficulty)
                return[nonce, hash]
            else 
                nonce += 1
            end

        end
    end

    def compute_hash_with_nonce(nonce = 0)
        sha = Digest::SHA256.new
        sha.update(nonce.to_s + @id.to_s + @timestamp.to_s + @data.to_s + @previous_hash)
        sha.hexdigest
    end

    def self.next(previous, data, previous_hash)
        Block.new(previous.id + 1, data, previous_hash)
    end

    def self.first(data)
        Block.new(0, data, "0")
    end
end