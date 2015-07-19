class SuggestionsController < ApplicationController
    before_action :set_suggestion, only: [:show, :edit, :update, :destroy, :vote_up, :vote_down]

    def index
      set_day
      get_previous_winners
      @suggestions = Suggestion.where("day_id == #{@day.id}")
      @up_votes_for_user = []
      @suggestion_votes = Hash.new {|h, k| h[k] = []}
      Vote.all.each do |vote|
        if current_user
          @up_votes_for_user << vote.suggestion_id if vote.user_id == current_user.id
        end
        @suggestion_votes[vote.suggestion_id] << Users.find(vote.user_id)
      end
    end

    def show
    end

    def new
      @day = current_day
      @suggestion = Suggestion.new
    end

    def edit
    end

    def create
      logger.info "creating suggestion"
      @suggestion = Suggestion.new(suggestion_params)
      @suggestion.day_id = current_day.id
      @suggestion.create_suggestion
      @suggestion.reload

      respond_to do |format|
        if @suggestion.save
          format.html { redirect_to suggestions_url, notice: 'Suggestion was successfully created!' }
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
          format.html { redirect_to @suggestion, notice: 'Suggestion was successfully updated!' }
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
      success, message = current_user.up_vote(@suggestion)
      if success
        respond_to do |format|
          flash[:notice] = message
          format.html { redirect_to suggestions_url }
        end
      else
        logger.info "you have already voted for this"
        respond_to do |format|
          format.html {
            flash[:warn] = message
            redirect_to suggestions_url
          }
        end
      end
    end

    def vote_down
      current_user.down_vote(@suggestion)
      respond_to do |format|
        format.html {
          flash[:notice] = "Your vote has been removed."
          redirect_to suggestions_url
        }
      end
    end


    private
    def set_suggestion
      @suggestion = Suggestion.find(params[:id])
    end

    def suggestion_params
      params.require(:suggestion).permit(:location, :departure_time)
    end

    def set_day
      @today = Day.get_or_create(Date.today)
      if current_user
        @day = current_day
      else
        @day = @today
      end
    end

    def get_previous_winners
      @winners = {}
      Suggestion.where("winner == ?", 1).each do |winning_suggestion|
        @winners[winning_suggestion] = Day.find(winning_suggestion.day_id)
      end
    end
end
