class SuggestionsController < ApplicationController
    before_action :set_suggestion, only: [:show, :edit, :update, :destroy, :vote_up]

    def index
      @suggestions = Suggestion.all
    end

    def show
    end

    def new
      @suggestion = Suggestion.new
    end

    def edit
    end

    def create
      logger.info "creating suggestion"
      @suggestion = Suggestion.new(suggestion_params)
      @suggestion.createSuggestion
      @suggestion.reload

      respond_to do |format|
        if @suggestion.save
          format.html { redirect_to suggestions_url, notice: 'suggestion was successfully created.' }
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
      respond_to do |format|
        if @suggestion.save
          format.html { redirect_to suggestions_url, notice: 'Vote successful!' }
          format.json { render action: 'show', status: created, location: @suggestion }
        else
          format.html { render action: 'new' }
          format.json { render json: @suggestion.errors, status: :unprocessable_entity }
        end
      end
    end

    private
    def set_suggestion
      @suggestion = Suggestion.find(params[:id])
    end

    def suggestion_params
      params.require(:suggestion).permit(:location, :departure_time)
    end
end
