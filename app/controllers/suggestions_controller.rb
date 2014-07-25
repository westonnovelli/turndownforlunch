class SuggestionsController < ApplicationController
    before_action :set_suggestion, only: [:show, :edit, :update, :destroy, :refresh, :start, :stop]

    def index
    end

    def show
    end

    def new
      @suggestion = Suggestions.new
    end

    def edit
    end

    def create
      @suggestion = Suggestions.new(suggestion_params)
      @suggestion.reload

      respond_to do |format|
        if @suggestion.save
          format.html { redirect_to @suggestion, notice: 'suggestion was successfully created.' }
          format.json { render action: 'show', status: created, location: @suggestion }
        else
          format.html { render action: 'new' }
          format.json { render json: @suggestion.errors, status: :unprocessable_entity }
        end
      end
    end

    def update
      respond_to do |format|
        if @suggestion.update(suggestion_params)
          format.html { redirect_to @suggestion, notice: 'suggestion was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: 'edit' }
          format.json { render json: @suggestion.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      @suggestion.destroy
      respond_to do |format|
        format.html { redirect_to suggestions_url }
        format.json { head :no_content }
      end
    end

    def vote_up
      @suggestion.vote_up
    end

    private
    def set_suggestion
      @suggestion = suggestion.find(params[:id])
    end

    def suggestion_params
      params.require(:suggestion).permit(:location, :departure_time, :votes)
    end
end
