class SalesController < ApplicationController
  require 'csv'
  before_action :set_sale, only: %i[ show edit update destroy ]

  # GET /sales or /sales.json
  def index
    @sales = Sale.all
  end

  # GET /sales/1 or /sales/1.json
  def show
  end

  # GET /sales/new
  def new
    @sale = Sale.new
  end

  # GET /sales/1/edit
  def edit
  end

  # POST /sales or /sales.json
  def create
    @sale = Sale.new(sale_params)
    @company = Company.find_by(name: 'IKLI TECNOLOGIA')
  
    @sale.company_id = @company.id if @company # Associa a venda à empresa apenas se a empresa for encontrada
      respond_to do |format|
        if @sale&.save
          @company.amount += (@sale.item_price.to_f * @sale.purchase_count.to_i) if @sale.item_price && @sale.purchase_count
          @company.save

          format.html { redirect_to root_path, notice: "Sale was successfully created." }
          format.json { render :show, status: :created, location: @sale }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @sale&.errors, status: :unprocessable_entity }
        end
      end
  end

  def import
    file = params[:file]
    return redirect_to new_sale_path, notice: 'Only CSV please' unless file.content_type == "text/csv"
    file = File.open(file)
    csv = CSV.parse(file, headers: true, col_sep: ';')
    
    csv.each do |row|
      sale_hash = {}
      sale_hash[:purchase_name] = row['purchase_name'].to_s
      sale_hash[:item_description] = row['item_description'].to_s
      sale_hash[:item_price] = row['item_price'].to_f
      sale_hash[:purchase_count] = row['purchase_count'].to_i
      sale_hash[:merchant_address] = row['merchant_address'].to_s
      sale_hash[:merchant_name] = row['merchant_name'].to_s
      sale_hash[:company_id] = 1 
      
      @sale = Sale.new(sale_hash)
      if @sale.save(validate: false)
        @company = Company.find_by(name: 'IKLI TECNOLOGIA')
        @company.amount += (@sale.item_price * @sale.purchase_count) if @sale.item_price && @sale.purchase_count
        @company.save
      end
      #binding.b
    end
    redirect_to sales_path, notice: 'Sales imported'
  end

  # PATCH/PUT /sales/1 or /sales/1.json
  def update
    respond_to do |format|
      if @sale.update(sale_params)
        format.html { redirect_to sale_url(@sale), notice: "Sale was successfully updated." }
        format.json { render :show, status: :ok, location: @sale }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @sale.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sales/1 or /sales/1.json
  def destroy
    @sale.destroy

    @company = Company.find_by(name: 'IKLI TECNOLOGIA')
    @company.amount -= (@sale.item_price * @sale.purchase_count) if @sale.item_price && @sale.purchase_count
    @company.save

    respond_to do |format|
      format.html { redirect_to sales_url, notice: "Sale was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sale
      @sale = Sale.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def sale_params
      params.require(:sale).permit(:purchase_name, :item_description, :item_price, :purchase_count, :merchant_address, :merchant_name, :company_id)
    end
end
