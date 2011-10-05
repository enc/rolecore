class RelationPropertiesController < ApplicationController
  # GET /relation_properties
  # GET /relation_properties.json
  def index
    @relation_properties = RelationProperty.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @relation_properties }
    end
  end

  # GET /relation_properties/1
  # GET /relation_properties/1.json
  def show
    @relation_property = RelationProperty.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @relation_property }
    end
  end

  # GET /relation_properties/new
  # GET /relation_properties/new.json
  def new
    @relation_property = RelationProperty.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @relation_property }
    end
  end

  # GET /relation_properties/1/edit
  def edit
    @relation_property = RelationProperty.find(params[:id])
  end

  # POST /relation_properties
  # POST /relation_properties.json
  def create
    @relation_property = RelationProperty.new(params[:relation_property])

    respond_to do |format|
      if @relation_property.save
        format.html { redirect_to @relation_property, notice: 'Relation property was successfully created.' }
        format.json { render json: @relation_property, status: :created, location: @relation_property }
      else
        format.html { render action: "new" }
        format.json { render json: @relation_property.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /relation_properties/1
  # PUT /relation_properties/1.json
  def update
    @relation_property = RelationProperty.find(params[:id])

    respond_to do |format|
      if @relation_property.update_attributes(params[:relation_property])
        format.html { redirect_to @relation_property, notice: 'Relation property was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @relation_property.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /relation_properties/1
  # DELETE /relation_properties/1.json
  def destroy
    @relation_property = RelationProperty.find(params[:id])
    @relation_property.destroy

    respond_to do |format|
      format.html { redirect_to relation_properties_url }
      format.json { head :ok }
    end
  end
end
