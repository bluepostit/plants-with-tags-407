class PlantTagsController < ApplicationController
  before_action :set_plant

  def new
    @plant_tag = PlantTag.new
  end

  def create
    # find the plant
    # create a new plant_tag - with params
    @tags = Tag.where(id: params[:plant_tag][:tag])

    # Must create a plant_tag for every tag in @tags!
    @tags.each do |tag|
      plant_tag = PlantTag.new(plant: @plant, tag: tag)
      plant_tag.plant = @plant
      plant_tag.save
    end
    redirect_to garden_path(@plant.garden)
  end

  private

  def set_plant
    @plant = Plant.find(params[:plant_id])
  end

  def plant_params
    params.require(:plant_tag).permit(:tag)
  end
end
